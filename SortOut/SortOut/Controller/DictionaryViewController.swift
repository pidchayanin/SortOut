//
//  DictionaryViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 13/4/2564 BE.
//

import UIKit
import NaturalLanguage
import SwiftyJSON
import CoreData

class DictionaryViewController: UIViewController {
    
    var sections = Dictionary<String, Array<TableItem>>()
    var sortedSections = [String]()

    var addVocab: [AddToVocabCD] = []
    
    @IBOutlet weak var dictionaryTableView: UITableView!

    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
//    let addWord = AddToVocabCD(context:context!)
    
    var add_button = false
    var undo_button = false
    
    var load = true
    
    let cellReuseIdentifier = "dictCell"
    let cellSpacingHeight: CGFloat = 20
    var word = [""]
    var word1 = [String]()
    var word2 = String()
    var pos = [String]()
    
    var addListIndexPath = [Int]()
    
    var vocabs = String()
    var definitions = String()
    var synnonyms = String()
    var sentenceExamples = String()
    var vocabArr = [String]()
    var defArr = [String]()
    var synArr = [String]()
    var exampleArr = [String]()
    
    let currentDate = Date()
    
    let tagger = NLTagger(tagSchemes: [.lemma])
    let posTagger = NLTagger(tagSchemes: [.lexicalClass])
    let options : NLTagger.Options = [.omitWhitespace, .omitPunctuation]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.shared.dictVC = self

        // Do any additional setup after loading the view.
        dictionaryTableView.delegate = self
        dictionaryTableView.dataSource = self
        
        getData()
        //print("add vocab", addVocab)
        
        let temp = word.joined(separator: ", ")

        tagger.string = temp
        // Loop over all the tokens and print their lemma
        tagger.enumerateTags(in: temp.startIndex..<temp.endIndex, unit: .word, scheme: .lemma) { tag, tokenRange in
          if let tag = tag {
            //MARK: British English Only

            if [tag.rawValue] == ["be"] {
                for i in word {
                    if [i] == ["is"] {
                        word1.append(i)
                    } else if [i] == ["am"] {
                        word1.append(i)
                    } else if [i] == ["are"] {
                        word1.append(i)
                    } else if [i] == ["being"] {
                        word1.append(i)
                    }
                }
            } else {
                word1.append(tag.rawValue)
            }
          }
          return true
        }
        
        posTagger.string = temp
        posTagger.enumerateTags(in: temp.startIndex..<temp.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
            if let tag = tag{
                for k in [tag.rawValue] {
                    pos.append(k)
                }
            }
            return true
        }

        retrieveDictionary()

    }
    
    
    func retrieveDictionary() {
        
        var def = ""
        var synn = ""
        var ex = ""
        var vocab = ""
        var temp = ""
        guard let path = Bundle.main.path(forResource: "Englishsentences - Dictionary (2)", ofType: "json") else {return}
                
        let url = URL(fileURLWithPath: path)
        
        do{
            let data = try Data(contentsOf: url)
            let json = try JSON(data: data)
            
            for k in word1 {
                temp = ""
                for i in json {
                    vocab = i.1["vocabulary"].stringValue.lowercased()
                    
                    let tempVocab = vocab
                    
                    tagger.string = tempVocab
                    // Loop over all the tokens and print their lemma
                    tagger.enumerateTags(in: tempVocab.startIndex..<tempVocab.endIndex, unit: .word, scheme: .lemma) { tag, tokenRange in
                      if let tag = tag {
                        vocab = tag.rawValue
                      }
                      return true
                    }
                    if vocab == k {
                        def = i.1["definition"].stringValue
                        synn = i.1["synonym"].stringValue
                        ex = i.1["sentence_example"].stringValue
                        defArr.append(def)
                        synArr.append(synn)
                        exampleArr.append(ex)
                        temp = "complete"
                        break
                    }
                }
                if temp == "" {
                    defArr.append("-")
                    synArr.append("-")
                    exampleArr.append("-")
                }
                //self.dictionaryTableView.reloadData()
            }
        }
        catch {
            
        }
    }
    
    /*func getData() {
        guard let appDelegate = <#expression#> else { return <#return value#> }
    }*/
    
    
    func getData() {
        print("getData")
        addVocab.removeAll()
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let wordFromCoreData = try? context.fetch(AddToVocabCD.fetchRequest()){
                if let words = wordFromCoreData as? [AddToVocabCD]{
                    addVocab = words
                    //self.dictionaryTableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return word.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        
        //let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        var av = [String]()
        
        // Make word added in addVocab to be an array
        if addVocab.count != 0 {
            for v in 0...addVocab.count - 1 {
                let av_temp = addVocab[v]
                let av_temp2 = av_temp.addedWord!
                av.append(av_temp2)
            }
        }
        
        print("dict av:", av)

        // Check if word already added
        var i = 0
        for word_1 in word1 {
            for word_2 in av {
                if word_1 == word_2 {
                    if !addListIndexPath.contains(i) {
                        addListIndexPath.append(i)
                    } 
                }
            }
            i += 1
        }
        
        print("alip: ", addListIndexPath)
        
        
        if word1[indexPath.row] != "" {
            cell.wordLabel.text = word1[indexPath.section]
            cell.partOfSpeechLabel.text = "(" + pos[indexPath.section] + ")"
            cell.definitionInThaiLabel.text = defArr[indexPath.section]
            cell.synnonymWordLabel.text = synArr[indexPath.section]
            cell.exampleSentenceLabel.text = exampleArr[indexPath.section]
            
        }
        
        cell.meaningInThaiLabel.text = "หมายถึง"
        cell.synnonymLabel.text = "Synonym(s)"
        cell.exampleLabel.text = "Example"
        
        // Check if words did not contained in addListIndexPath array to prevent reuseable cell looping when scroll the tableview
        //print("al:", addListIndexPath)
        if !addListIndexPath.contains(indexPath.section) {
            cell.addToVocabListButton.isEnabled = true
            cell.addToVocabListButton.backgroundColor = .systemBlue

            cell.addToListLabel.isHidden = false

            cell.undoButton.isHidden = true
            cell.undoButton.isEnabled = false

            cell.addedTextLabel.isHidden = true
        }
        else {
            cell.addToVocabListButton.isEnabled = false
            cell.addToVocabListButton.backgroundColor = .darkGray
        
            cell.addToListLabel.isHidden = true
            
            cell.undoButton.isHidden = false
            cell.undoButton.isEnabled = true
            
            cell.addedTextLabel.isHidden = false
        }
        
        cell.undoButtonAction = { [unowned self] in
            undo_button = true
            addListIndexPath = addListIndexPath.filter { $0 != indexPath.section }

            var idx = 0
            for w in av {
                if w == word1[indexPath.section] {
                    break
                }
                idx += 1
            }
            
            let wordFromCoreData = try? context!.fetch(AddToVocabCD.fetchRequest())
            context!.delete(wordFromCoreData![idx] as! NSManagedObject)

            cell.undoButton.isHidden = true
            cell.undoButton.isEnabled = false
            cell.addedTextLabel.isHidden = true
            cell.addToVocabListButton.isEnabled = true
            cell.addToVocabListButton.backgroundColor = .systemBlue
            
            cell.addToListLabel.isHidden = false
            //print(addWord)
            print("undo pressed")
            

            //print("ip2", indexPath.row)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
 

            getData()
            //self.dictionaryTableView.reloadData()
            // Still cannot find how to reload tableView
            
            
        }
        
        cell.addToVocabListButtonAction = { [unowned self] in
            add_button = true
            let addWord = AddToVocabCD(context:context!)
            print("AW:", addWord)
            addListIndexPath.append(indexPath.section)

            //let addDate = DateCD(context:context!)

            let addedWord = word1[indexPath.section]
            let addedPOS = pos[indexPath.section]
            let addedDefinition = defArr[indexPath.section]
            let addedSynonym = synArr[indexPath.section]
            let addedExample = exampleArr[indexPath.section]
            
            addWord.addedWord = addedWord
            addWord.addedPoS = addedPOS
            addWord.addedDefinition = addedDefinition
            addWord.addedSynonym = addedSynonym
            addWord.addedExample = addedExample
            addWord.addedDate = currentDate
            
            cell.addToVocabListButton.isEnabled = false
            cell.addToVocabListButton.backgroundColor = .darkGray
        
            cell.addToListLabel.isHidden = true
            
            cell.undoButton.isHidden = false
            cell.undoButton.isEnabled = true
            
            cell.addedTextLabel.isHidden = false
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
            getData()
            
            tableView.reloadData()
        }
        
        //Undo แล้วยังไม่ลบ
        
           
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        
        cell.clipsToBounds = true

        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if  segue.destination is VocabListViewController {
            let destination = segue.destination as? VocabListViewController
            destination?.addList = addListIndexPath
            }
    }
}
