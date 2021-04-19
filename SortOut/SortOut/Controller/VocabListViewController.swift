//
//  VocabListViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 21/2/2564 BE.
//

import UIKit

var i = Int()

class VocabListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "vocabListCell"
    //var words:[String] = []
    var addToVocabCD: [AddToVocabCD] = []
    var wordAdded = [String]()
//    let words = [["collegeeeeeeee", "affair", "amaze", "house"], ["word1", "word2", "word3"]]
//    let partOfSpeeches = [["(Noun)", "(Verb)", "(Adjective)", "(Noun)"], ["(PoS1)", "(PoS2)", "(PoS3)"]]
//    let dashes = [["-", "-", "-", "-"], ["-", "-", "-"]]
//    let meanings = [["วิทยาลัย, โรงเรียน", "กิจ, ธุระ", "ตะลึง, แปลกใจ", "บ้าน"], ["ความหมาย1", "ความหมาย2", "ความหมาย3"]]
//    let synnonyms = [["synnonym word1", "synnonym word2", "synnonym word3", "synnonym word4"], ["synnonym word5", "synnonym word6", "synnonym word7"]]
//    let examples = [["example sentence1", "example sentence2", "example sentence3", "example sentence4"], ["example sentence5", "example sentence6", "example sentence7"]]
//
//    let headerTitles = ["14 September 2020", "15 September 2020"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //print(words)
        //retrieveData()
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
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    
  /*func retrieveData() {
        guard let path = Bundle.main.path(forResource: "English sentences - Sheet1", ofType: "json") else {return}
        
        let url = URL(fileURLWithPath: path)
        //print("--1--")
        do {
            //print("--2--")
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let array = json as? [Any] else {return}
            
            for word in array {
                
                guard let wordsList = word as? [String: Any] else {return}
                guard let wordInSentence = wordsList["sentence1"] as? [String] else {return}
                words = wordInSentence
                print("fetch words.count :", words.count)
            }
            
            
        } catch {
            print("--------\n", error)
        }
    }*/
    
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    /*
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
            if let cell = sender as? UITableViewCell {
                let i = self.tableView.indexPath(for: cell)!.row
                let j = self.tableView.indexPath(for: cell)!.section
                if segue.identifier == "toVocabMeaning" {
                    let vc = segue.destination as! VocabMeaningViewController
                    vc.meaningWord = words[i][j]
                }
            }
        }*/
    /*
     
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toVocabMeaning"{
            let navigationController = segue.destination as! UINavigationController
            let vc = navigationController.topViewController as! VocabMeaningViewController
            let wordSection = self.tableView.indexPathForSelectedRow?.section
            let wordRow = self.tableView.indexPathForSelectedRow?.row
            vc.meaningWord = words[wordSection!][wordRow!]
         }
    }*/

}

extension VocabListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addToVocabCD.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //use Date ?
        return 1//words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:VocablistTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! VocablistTableViewCell
        

        let selectedWord = addToVocabCD[indexPath.row]
//        if let wordAdded = selectedWord.addedWord {
//            cell.wordLabel.text = wordAdded
//        }
        //wordAdded = selectedWord.addedWord!
        wordAdded.append(selectedWord.addedWord!)
        cell.wordLabel.text = wordAdded[indexPath.row]
        print("vocab word added: ", wordAdded)
//        }
        
        //print(words.count)
    
        
//        cell.wordLabel.text = words[indexPath.section]
//        cell.partOfSpeechLabel.text = self.partOfSpeeches[indexPath.section][indexPath.row]
//        cell.dashLabel.text = self.dashes[indexPath.section][indexPath.row]
//        cell.meaningLabel.text = self.meanings[indexPath.section][indexPath.row]
        

        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section < headerTitles.count {
//            return headerTitles[section]
//        }
//
//        return nil
//    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        i = indexPath.row
        print("i: ", i)
        performSegue(withIdentifier: "toVocabMeaning", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        let saveWord = addToVocabCD[indexPath.row]
        
        if editingStyle == .delete {
            managedContext?.delete(saveWord)
            
            // Delete the row from the data source
            self.addToVocabCD.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if  segue.identifier == "toVocabMeaning",
//                let destination = segue.destination as? VocabMeaningViewController,
//                let wordSection = self.tableView.indexPathForSelectedRow?.section,
//                let wordRow = self.tableView.indexPathForSelectedRow?.row
//            {
//            destination.meaningWord = wordAdded
//            print("meaning of: ", wordAdded)
////            destination.meaningPartOfSpeech = partOfSpeeches[wordSection][wordRow]
////            destination.meaningMeaning = meanings[wordSection][wordRow]
////            destination.meaningSynnonymWords = synnonyms[wordSection][wordRow]
////            destination.meaningExampleSentences = examples[wordSection][wordRow]
//            }
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if  segue.destination is VocabMeaningViewController {
            let destination = segue.destination as? VocabMeaningViewController
            destination?.meaningWord = wordAdded[i]
            //print("meaning of: ", wordAdded)
//            destination.meaningPartOfSpeech = partOfSpeeches[wordSection][wordRow]
//            destination.meaningMeaning = meanings[wordSection][wordRow]
//            destination.meaningSynnonymWords = synnonyms[wordSection][wordRow]
//            destination.meaningExampleSentences = examples[wordSection][wordRow]
            }
    }
}
