//
//  VocabListViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 21/2/2564 BE.
//

import UIKit

var i = Int()

private func firstDayOfMonth(date: Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    return calendar.date(from: components)!
}

class VocabListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switchButton: UISwitch!
 
    var favoriteCD: [FavoriteVocabCD] = []
    
    let cellReuseIdentifier = "vocabListCell"
    
    var currentDate = Date()
    //var words:[String] = []
    var addToVocabCD: [AddToVocabCD] = []
    var dateCD: [DateCD] = []
    var wordAdded = [String]()
    var posAdded = [String]()
    var defAdded = [String]()
    var synAdded = [String]()
    var exAdded = [String]()
    
    var sections = [VocabListSection<Date, AddToVocabCD>]()
    
    var addList = [Int]()
    var av = [String]()
    
    var favExample = ["i", "tu", "i", "here"]
    
    var headerTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        DataManager.shared.vocabVC = self
        
        
        
        //print(words)
        //retrieveData()
        getData()
        getDate()
        
        self.sections = VocabListSection.group(rows: self.addToVocabCD, by: { firstDayOfMonth(date: $0.addedDate!) })
        self.sections.sort { lhs, rhs in lhs.sectionItem < rhs.sectionItem }
        
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
    
    func getFavorites() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            if let favoritesFromCoreData = try? context.fetch(FavoriteVocabCD.fetchRequest()){
                if let favorites = favoritesFromCoreData as? [FavoriteVocabCD]{
                    favoriteCD = favorites
                    print(favorites)
                    tableView.reloadData()
                }
            }
        }
    }
    
    func getData() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let wordFromCoreData = try? context.fetch(AddToVocabCD.fetchRequest()){
                if let words = wordFromCoreData as? [AddToVocabCD]{
                    addToVocabCD = words
                    tableView.reloadData()
                }
            }
        }
    }
    
    func getDate() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let dateFromCoreData = try? context.fetch(DateCD.fetchRequest()) {
                if let dates = dateFromCoreData as? [DateCD] {
                    dateCD = dates
                    tableView.reloadData()
                }
            }
        }
    }
    

    /*@IBAction func segmentChange(_ sender: Any) {
        switch(segmentedController.selectedSegmentIndex)
            {
            case 0:
                //print("vocab")
                tableView.reloadData()
                break

            case 1:
                //print("fav vocab")
                tableView.reloadData()
                break
            default:
                break

            }
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
        switchIsChanged(switchButton: switchButton)
    }
}

extension VocabListViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return addToVocabCD.count
        let section = self.sections[section]
        return section.rows.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //use Date ?
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.sections[section]
        let date = section.sectionItem
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:VocablistTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! VocablistTableViewCell
        


        let selectedWord = addToVocabCD[indexPath.row]
        //print("sw", selectedWord.addedWord!)
        wordAdded.append(selectedWord.addedWord ?? "")
        //print("wa", wordAdded)
        cell.wordLabel.text = wordAdded[indexPath.row]
        print("vocab word added: ", wordAdded[indexPath.row])
        posAdded.append(selectedWord.addedPoS ?? "")
        cell.partOfSpeechLabel.text = "(" + posAdded[indexPath.row] + ")"
        defAdded.append(selectedWord.addedDefinition ?? "")
        cell.dashLabel.text = "-"
        cell.meaningLabel.text = defAdded[indexPath.row]
        synAdded.append(selectedWord.addedSynonym ?? "")
        exAdded.append(selectedWord.addedExample ?? "")
        
        //selectedWord.addedDate = currentDate
        
        if switchButton.isOn == true {
            switchButton.setOn(true, animated: true)
            cell.dashLabel.isHidden = false
            cell.partOfSpeechLabel.isHidden = false
            cell.meaningLabel.isHidden = false
            //print("switch on")
            //return cell2
        } else if switchButton.isOn == false {
            switchButton.setOn(false, animated: true)
            cell.dashLabel.isHidden = true
            cell.partOfSpeechLabel.isHidden = true
            cell.meaningLabel.isHidden = true
            //print("switch off")
            //return cell2
        }
        
        /*let addedDate = dateCD[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let firstAddDateString = dateFormatter.string(from: addedDate.day! as Date)
        let anotherAddDateString = dateFormatter.string(from: currentDate as Date)
        if addedDate.day != currentDate {
            headerTitles = [firstAddDateString, anotherAddDateString]
        }*/
//        if let wordAdded = selectedWord.addedWord {
//            cell.wordLabel.text = wordAdded
//        }
        //wordAdded = selectedWord.addedWord!
        
        
        
        
//        }
        

        //print(words.count)
    
        
//        cell.wordLabel.text = words[indexPath.section]
//        cell.partOfSpeechLabel.text = self.partOfSpeeches[indexPath.section][indexPath.row]
//        cell.dashLabel.text = self.dashes[indexPath.section][indexPath.row]
//        cell.meaningLabel.text = self.meanings[indexPath.section][indexPath.row]
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        i = indexPath.row
        //print("i: ", i)
        performSegue(withIdentifier: "toVocabMeaning", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        
        let saveWord = addToVocabCD[indexPath.row]
        if editingStyle == .delete {
            managedContext?.delete(saveWord)
            self.addToVocabCD.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if  segue.destination is VocabMeaningViewController {
            let destination = segue.destination as? VocabMeaningViewController
            destination?.meaningWord = wordAdded[i]
            destination?.meaningPartOfSpeech = posAdded[i]
            destination?.meaningMeaning = defAdded[i]
            destination?.meaningSynnonymWords = synAdded[i]
            destination?.meaningExampleSentences = exAdded[i]
            //print("meaning of: ", wordAdded)
//            destination.meaningPartOfSpeech = partOfSpeeches[wordSection][wordRow]
//            destination.meaningMeaning = meanings[wordSection][wordRow]
//            destination.meaningSynnonymWords = synnonyms[wordSection][wordRow]
//            destination.meaningExampleSentences = examples[wordSection][wordRow]
        }
    }
}
