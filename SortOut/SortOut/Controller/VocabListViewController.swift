//
//  VocabListViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 21/2/2564 BE.
//

import UIKit


private func firstDayOfMonth(date: Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    return calendar.date(from: components)!
}

class VocabListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switchButton: UISwitch!
    
    var i = Int()
 
    var favoriteCD: [FavoriteVocabCD] = []
    
    let cellReuseIdentifier = "vocabListCell"
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var currentDate = Date()
    //var words:[String] = []
    var addToVocabCD: [AddToVocabCD] = []
    var wordAdded = [String]()
    var posAdded = [String]()
    var defAdded = [String]()
    var synAdded = [String]()
    var exAdded = [String]()
    var seeVocab = 0
    
    var sections = [VocabListSection<Date, AddToVocabCD>]()
    
    var addList = [Int]()
    var av = [String]()
    
    var favExample = ["i", "tu", "i", "here"]
    
    var headerTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        DataManager.shared.vocabVC = self
        
        //print(words)
        //retrieveData()
        getData()
        //getDate()
        
        self.sections = VocabListSection.group(rows: self.addToVocabCD, by: { firstDayOfMonth(date: $0.addedDate!) })
        self.sections.sort { lhs, rhs in lhs.sectionItem > rhs.sectionItem }
        
        //sortByDate()
        
        switchButton.addTarget(self, action: #selector(switchIsChanged(switchButton:)), for: .valueChanged)
//        print("Date: ", currentDate)
        
    }
    
    @objc func switchIsChanged(switchButton: UISwitch) {
        if switchButton.isOn {

            self.tableView.reloadData()

        } else {

            self.tableView.reloadData()
        }
    }
    
    //Not working
    func sortByDate() {
        /*var vosec = VocabListSection.init(sectionItem: currentDate, rows: self.addToVocabCD)
        for d in vosec.rows {
            let date = d.addedDate
            let calendar = Calendar.current
            let seconds = calendar.component(.second, from: date!)
            vosec.rows.sort { _,_ in seconds > seconds }
        }*/
        addToVocabCD.sort { $0.addedDate! < $1.addedDate! }
    }
    
    /*func getFavorites() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            if let favoritesFromCoreData = try? context.fetch(FavoriteVocabCD.fetchRequest()){
                if let favorites = favoritesFromCoreData as? [FavoriteVocabCD]{
                    favoriteCD = favorites
                    print(favorites)
                    tableView.reloadData()
                }
            }
        }
    }*/
    
    func getData() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let wordFromCoreData = try? context.fetch(AddToVocabCD.fetchRequest()){
                if let words = wordFromCoreData as? [AddToVocabCD]{
                    addToVocabCD = words
                    //tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func editTapped(_ sender: UIBarButtonItem) {
        
        tableView.isEditing = !tableView.isEditing
        switch tableView.isEditing {
        case true:
            editButtonItem.title = "Done"
        case false:
            editButtonItem.title = "Edit"
        }
        
        /*guard let systemItem = sender.value(forKey: "systemItem") as? Int else {
              return
          }

          switch systemItem {
          case UIBarButtonItem.SystemItem.edit.rawValue:
                  let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: toggleEditSelector)
                  doneBarButtonItem.style = .plain
                  navigationItem.leftBarButtonItem = doneBarButtonItem
                  setEditing(true, animated: true)
          case UIBarButtonItem.SystemItem.done.rawValue:
                  let editBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: toggleEditSelector)
                  navigationItem.leftBarButtonItem = editBarButtonItem
                  setEditing(false, animated: true)
              default:
                  break
          }*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //getFavorites()
        //switchIsChanged(switchButton: switchButton)
        getData()
    }
}

extension VocabListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return addToVocabCD.count
        let sectionn = self.sections[section]
        print("section rows count: ", sectionn.rows.count)
        return sectionn.rows.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionn = self.sections[section]
        let date = sectionn.sectionItem
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:VocablistTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! VocablistTableViewCell
        
        let sectionn = self.sections[indexPath.section]
        let selectedWord = sectionn.rows[indexPath.row]
        //print("selectedWord: ", sectionn.rows.count)


        //let selectedWord = addToVocabCD[indexPath.row]
        //print("sw", selectedWord.addedWord!)
        wordAdded.append(selectedWord.addedWord ?? "")
        //print("wa", wordAdded)
        cell.wordLabel.text = selectedWord.addedWord ?? ""
        //print("vocab word added: ", selectedWord.addedWord ?? "")
        
        print("vocab word added: ", wordAdded[indexPath.row])
        
        posAdded.append(selectedWord.addedPoS ?? "")
        
        cell.partOfSpeechLabel.text = "(" + (selectedWord.addedPoS ?? "") + ")"
        
        defAdded.append(selectedWord.addedDefinition ?? "")
        
        cell.dashLabel.text = "-"
        
        cell.meaningLabel.text = selectedWord.addedDefinition ?? ""
        
        synAdded.append(selectedWord.addedSynonym ?? "")
        
        exAdded.append(selectedWord.addedExample ?? "")
        
        
        //selectedWord.addedDate = currentDate
        
        if switchButton.isOn == true {
            switchButton.setOn(true, animated: true)
            cell.dashLabel.isHidden = false
            cell.partOfSpeechLabel.isHidden = false
            cell.meaningLabel.isHidden = false
            //print("switch on")
        } else if switchButton.isOn == false {
            switchButton.setOn(false, animated: true)
            cell.dashLabel.isHidden = true
            cell.partOfSpeechLabel.isHidden = true
            cell.meaningLabel.isHidden = true
            //print("switch off")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        i = indexPath.row

        performSegue(withIdentifier: "toVocabMeaning", sender: self)
        
        seeVocab += 1
        print("vocabList seeVocab: ", seeVocab)
        UserDefaults.standard.setValue(seeVocab, forKey: "seeVocab")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        if editingStyle == .delete {
            self.tableView.beginUpdates()
            
            let removeRow = self.sections[indexPath.section].rows[indexPath.row]
            managedContext?.delete(removeRow)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            self.sections[indexPath.section].rows.remove(at: i)
            
            //DispatchQueue.main.async {
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            //}
            
            if self.sections[indexPath.section].rows.count == 0 {
                sections.remove(at: indexPath.section)
            }
        }
        
        /*if editingStyle == .delete {
            tableView.beginUpdates()
            switch indexPath.section {
            case 0:
                self.sections[indexPath.section].rows.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                let removeRow = self.sections[indexPath.section].rows[indexPath.row]
                managedContext?.delete(removeRow)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            case 1:
                self.sections[indexPath.section].rows.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                let removeRow = self.sections[indexPath.section].rows[indexPath.row]
                managedContext?.delete(removeRow)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            default:
                break
            }
            tableView.endUpdates()
        }*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //if  segue.destination is VocabMeaningViewController {
        if segue.identifier == "toVocabMeaning" {
            let destination = segue.destination as? VocabMeaningViewController
            destination?.meaningWord = wordAdded[i]
            destination?.meaningPartOfSpeech = posAdded[i]
            destination?.meaningMeaning = defAdded[i]
            destination?.meaningSynnonymWords = synAdded[i]
            destination?.meaningExampleSentences = exAdded[i]
        }
    }
}
