//
//  DictionaryViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 13/4/2564 BE.
//

import UIKit
import NaturalLanguage

class DictionaryViewController: UIViewController {
    
    var sections = Dictionary<String, Array<TableItem>>()
    var sortedSections = [String]()

    var addVocab: [AddToVocabCD] = []
    
    @IBOutlet weak var dictionaryTableView: UITableView!

    
    let cellReuseIdentifier = "dictCell"
    let cellSpacingHeight: CGFloat = 20
    var word = [""]
    let words = ["i", "too", "i", "here"]
    var word1 = [String]()
    var pos = [String]()
    
    let currentDate = Date()
    
    let tagger = NLTagger(tagSchemes: [.lemma])
    let posTagger = NLTagger(tagSchemes: [.lexicalClass])
    let options : NLTagger.Options = [.omitWhitespace, .omitPunctuation]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dictionaryTableView.delegate = self
        dictionaryTableView.dataSource = self
        
        getData()

        //print(word)
        //for i in word {
            //print(i)
        let temp = word.joined(separator: ", ")

        //print("temp: ", temp)
        tagger.string = temp
        // Loop over all the tokens and print their lemma
        tagger.enumerateTags(in: temp.startIndex..<temp.endIndex, unit: .word, scheme: .lemma) { tag, tokenRange in
          if let tag = tag {
            //print("\(temp[tokenRange]): \(tag.rawValue)")
            for j in [tag.rawValue] {
                word1.append(j)
            }
          }
          return true
        }
        posTagger.string = temp
        posTagger.enumerateTags(in: temp.startIndex..<temp.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
            if let tag = tag{
                //print("\(temp[tokenRange]): \(tag.rawValue)")
                for k in [tag.rawValue] {
                    pos.append(k)
                }
            }
            return true
        }


        //}
    }
    
    func getData() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let wordFromCoreData = try? context.fetch(AddToVocabCD.fetchRequest()){
                if let words = wordFromCoreData as? [AddToVocabCD]{
                    addVocab = words
                    dictionaryTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    //    @IBAction func addToListTapped(_ sender: UIButton) {
//        switch sender.tag {
//                    case 0:
//                        print("Button 1 Clicked")
//                    case 1:
//                        let vocabTab = (self.tabBarController?.viewControllers?[3]) as? VocabListViewController
//                        performSegue(withIdentifier: "addToVocabList", sender: self)
//                        
//                        //print(vocabTab?.words)
//                    default: break
//              }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DictionaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return word.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DictionaryTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! DictionaryTableViewCell

        //cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if word1[indexPath.row] != "" {
            cell.wordLabel.text = word1[indexPath.row]
            cell.partOfSpeechLabel.text = "(" + pos[indexPath.row] + ")"
            //print("pos: ", pos)
        }
        
        /*if addVocab.isEmpty == false {
            print(addVocab.count)
            print(addVocab[indexPath.count])
            let alreadyHaveWord = addVocab[indexPath.row]
            
            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    //                let vc = self.storyboard!.instantiateViewController(withIdentifier: "TabbarID") as! TabbarViewController
    //                if let destVC = vc.viewControllers,
    //                   let nc = destVC.first as? UINavigationController,
    //                   let vocabVC = nc.topViewController as? VocabListViewController{
    //                    vocabVC.words.append(word[indexPath.row])
    //                }
    //                let destVC = vc.viewControllers?[3] as! VocabListViewController
    //                destVC.words.append(word[indexPath.row])
                //let vc = self.storyboard?.instantiateViewController(withIdentifier: "NCID") as! UINavigationController
                //let destVC = vc.topViewController as! VocabListViewController
                //destVC.words.append(word[indexPath.row])
                //print(destVC.words)
                //self.present(vc, animated: true, completion: nil)
            let addWord = AddToVocabCD(context:context!)
            //let addDate = DateCD(context:context!)
            let addedWord = word[indexPath.row]
            
            
            let addedPOS = pos[indexPath.row]
            
            //MARK: To do - check if the word is already added or not
            
            if alreadyHaveWord.addedWord == addedWord {
                cell.addToVocabListButton.isEnabled = false
                cell.addToVocabListButton.backgroundColor = .lightGray
                cell.addToListLabel.text = "Already added this word"
            }
            
            
            cell.addToVocabListButtonAction = { [unowned self] in
                
                addWord.addedWord = addedWord
                addWord.addedPoS = addedPOS
                
                //let alert = UIAlertController(title: "Add \(word[indexPath.row]) to list", message: "Are you sure?", preferredStyle: .alert)
               
                //YES
                //alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
                //NSLog("The \"YES\" alert occured.")
                    
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                
                let date:String = dateFormatter.string(from: currentDate)

                    //if we don't have section for particular date, create new one, otherwise we'll just add item to existing section
                if self.sections.index(forKey: date) == nil {
                        self.sections[date] = [TableItem(title: date, creationDate: currentDate)]
                    }
                    else {
                        self.sections[date]!.append(TableItem(title: date, creationDate: currentDate))
                    }

                    //we are storing our sections in dictionary, so we need to sort it
                self.sortedSections = self.sections.keys.sorted { $0 > $1}
                    self.dictionaryTableView.reloadData()
                
                //let addedDate = currentDate
                //addDate.day = addedDate
                //print(addDate.day!)
                
                //print("word1: ", word1)
                //print("array addedword: ", [addedWord])
                //print("word: ", word)
                //print("word indexpath: ", addedWord.count)
                //print("indPath: ", indexPath.row)
                //print("added word: ", addWord)
                
                //if [addedWord][i].count == 1 {
                    //addWord.addedWord = String([addedWord][0])
                
                
                
                cell.addToVocabListButton.isEnabled = false
                cell.addToVocabListButton.backgroundColor = .lightGray
            
                cell.addToListLabel.isHidden = true
                
                cell.undoButton.isHidden = false
                cell.undoButton.isEnabled = true
                
                cell.addedTextLabel.isHidden = false
            
                
                if cell.undoButton.isHidden == false {
                    cell.undoButtonAction = {
                        [unowned self] in
                        //self.undoManager?.undo()
                        //cell.undoButton.isEnabled = self.undoManager?.canUndo ?? false
                        context!.delete(addWord)
                        cell.undoButton.isHidden = true
                        cell.undoButton.isEnabled = false
                        cell.addedTextLabel.isHidden = true
                        cell.addToVocabListButton.isEnabled = true
                        cell.addToVocabListButton.backgroundColor = .systemBlue
                        
                        cell.addToListLabel.isHidden = false
                        print(addWord)
                        print("undo pressed")
                    }
                }
            //}

            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
        }*/
        cell.meaningInThaiLabel.text = "หมายถึง"
        cell.synnonymLabel.text = "Synnonym(s)"
        cell.exampleLabel.text = "Example"
        
        
        cell.addToVocabListButtonAction = { [unowned self] in
            
            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
 
            let addWord = AddToVocabCD(context:context!)
            //let addDate = DateCD(context:context!)
            let addedWord = word[indexPath.row]
            
            
            let addedPOS = pos[indexPath.row]
            
            addWord.addedWord = addedWord
            addWord.addedPoS = addedPOS
            
            
            //let alert = UIAlertController(title: "Add \(word[indexPath.row]) to list", message: "Are you sure?", preferredStyle: .alert)
           
            //YES
            //alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            //NSLog("The \"YES\" alert occured.")
                
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            let date:String = dateFormatter.string(from: currentDate)

                //if we don't have section for particular date, create new one, otherwise we'll just add item to existing section
            if self.sections.index(forKey: date) == nil {
                    self.sections[date] = [TableItem(title: date, creationDate: currentDate)]
                }
                else {
                    self.sections[date]!.append(TableItem(title: date, creationDate: currentDate))
                }

                //we are storing our sections in dictionary, so we need to sort it
            self.sortedSections = self.sections.keys.sorted { $0 > $1}
                self.dictionaryTableView.reloadData()
            
            //let addedDate = currentDate
            //addDate.day = addedDate
            //print(addDate.day!)
            
            //print("word1: ", word1)
            //print("array addedword: ", [addedWord])
            //print("word: ", word)
            //print("word indexpath: ", addedWord.count)
            //print("indPath: ", indexPath.row)
            //print("added word: ", addWord)
            
            //if [addedWord][i].count == 1 {
                //addWord.addedWord = String([addedWord][0])
            
            
            
            cell.addToVocabListButton.isEnabled = false
            cell.addToVocabListButton.backgroundColor = .lightGray
        
            cell.addToListLabel.isHidden = true
            
            cell.undoButton.isHidden = false
            cell.undoButton.isEnabled = true
            
            cell.addedTextLabel.isHidden = false
        
            
            if cell.undoButton.isHidden == false {
                cell.undoButtonAction = {
                    [unowned self] in
                    //self.undoManager?.undo()
                    //cell.undoButton.isEnabled = self.undoManager?.canUndo ?? false
                    context!.delete(addWord)
                    cell.undoButton.isHidden = true
                    cell.undoButton.isEnabled = false
                    cell.addedTextLabel.isHidden = true
                    cell.addToVocabListButton.isEnabled = true
                    cell.addToVocabListButton.backgroundColor = .systemBlue
                    
                    cell.addToListLabel.isHidden = false
                    print(addWord)
                    print("undo pressed")
                }
            }
        //}

        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        
        
        
        
            
            /*for item in word1 {
                if word1[indexPath.row] == item {
                    print("item: ", item)
                    let addedWord = item
                    addWord.addedWord = addedWord
                    
                    let addedPOS = pos[indexPath.row]
                    addWord.addedPoS = addedPOS
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    
                    let date:String = dateFormatter.string(from: currentDate)

                        //if we don't have section for particular date, create new one, otherwise we'll just add item to existing section
                    if self.sections.index(forKey: date) == nil {
                            self.sections[date] = [TableItem(title: date, creationDate: currentDate)]
                        }
                        else {
                            self.sections[date]!.append(TableItem(title: date, creationDate: currentDate))
                        }

                        //we are storing our sections in dictionary, so we need to sort it
                    self.sortedSections = self.sections.keys.sorted { $0 > $1}
                        self.dictionaryTableView.reloadData()
                    
                    //let addedDate = currentDate
                    //addDate.day = addedDate
                    //print(addDate.day!)
                    
                    //print("word1: ", word1)
                    //print("array addedword: ", [addedWord])
                    //print("word: ", word)
                    //print("word indexpath: ", addedWord.count)
                    //print("indPath: ", indexPath.row)
                    //print("added word: ", addWord)
                    
                    //if [addedWord][i].count == 1 {
                        //addWord.addedWord = String([addedWord][0])
                    cell.addToVocabListButton.isEnabled = false
                    cell.addToVocabListButton.backgroundColor = .lightGray
                
                    cell.addToListLabel.isHidden = true
                    
                    cell.undoButton.isHidden = false
                    cell.undoButton.isEnabled = true
                    
                    cell.addedTextLabel.isHidden = false
                
                    
                    if cell.undoButton.isHidden == false {
                        cell.undoButtonAction = {
                            [unowned self] in
                            //self.undoManager?.undo()
                            //cell.undoButton.isEnabled = self.undoManager?.canUndo ?? false
                            context!.delete(addWord)
                            cell.undoButton.isHidden = true
                            cell.undoButton.isEnabled = false
                            cell.addedTextLabel.isHidden = true
                            cell.addToVocabListButton.isEnabled = true
                            cell.addToVocabListButton.backgroundColor = .systemBlue
                            
                            cell.addToListLabel.isHidden = false
                            print(addWord)
                            print("undo pressed")
                        }
                    }
                //}

                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                }
            }*/
            
                    
                
                
            //}))
            
            //NO
            //alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
          //      print("Tap no")
          //}))
            
           // self.present(alert, animated: true, completion: nil)
        
        
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        
        cell.clipsToBounds = true
        
        
        
        //fetchItem()
        //tableView.reloadData()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if  segue.destination is VocabListViewController {
            let destination = segue.destination as? VocabListViewController
            destination?.sections = sections
            destination?.sortedSections = sortedSections
            }
    }
}
