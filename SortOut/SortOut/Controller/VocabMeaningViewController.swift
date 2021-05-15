//
//  VocabMeaningViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 21/2/2564 BE.
//

import UIKit
import CoreData

class VocabMeaningViewController: UIViewController {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var meanLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var synnonymsLabel: UILabel!
    @IBOutlet weak var synnonymWordsLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var exampleSentencesLabel: UILabel!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var favBtn: UIButton!
    
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var vocabCD: [AddToVocabCD] = []
    
    var meaningWord = String()
    var meaningPartOfSpeech = String()
    let meaningMean = "หมายถึง"
    var meaningMeaning = String()
    let meaningSynnonyms = "Synnonyms"
    var meaningSynnonymWords = String()
    let meaningExample = "Example"
    var meaningExampleSentences = String()
    
    override func viewWillAppear(_ animated: Bool) {
        wordLabel.text = meaningWord
        partOfSpeechLabel.text = meaningPartOfSpeech
        meanLabel.text = meaningMean
        meaningLabel.text = meaningMeaning
        synnonymsLabel.text = meaningSynnonyms
        synnonymWordsLabel.text = meaningSynnonymWords
        exampleLabel.text = meaningExample
        exampleSentencesLabel.text = meaningExampleSentences
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        wordLabel.text = meaningWord
        partOfSpeechLabel.text = meaningPartOfSpeech
        meanLabel.text = meaningMean
        meaningLabel.text = meaningMeaning
        synnonymsLabel.text = meaningSynnonyms
        synnonymWordsLabel.text = meaningSynnonymWords
        exampleLabel.text = meaningExample
        exampleSentencesLabel.text = meaningExampleSentences
//        favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
//        favBtn.frame = CGRect(x: 333.5, y: 161, width: 44.5, height: 52)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Delete \(wordLabel.text ?? "")", message: "Are you sure?", preferredStyle: .alert)
       
        //YES
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            
            
            let vocabs = AddToVocabCD.init(context: self.context!)
            self.context?.delete(vocabs)
            
            do {
                try self.context?.save()
            }
            catch {
                fatalError("CoreData cannot save")
            }
            
                
            
            
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        //NO
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Tap no")
      }))
        
        self.present(alert, animated: true, completion: nil)
    }
    //    @IBAction func isFavoriteTapped(_ sender: Any) {
//        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
//            let newFavorite = FavoriteVocabCD.init(context:context)
//            if favBtn.currentImage == UIImage(systemName: "heart") {
//                newFavorite.favWord = meaningWord
//                newFavorite.favPoS = meaningPartOfSpeech
//                newFavorite.favDef = meaningMeaning
//                //print("fav tapped")
//                //print("new fav:", newFavorite)
//                favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//                favBtn.frame = CGRect(x: 333.5, y: 161, width: 44.5, height: 52)
//                favBtn.tintColor = .blue
//            } else {
//                favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
//                favBtn.frame = CGRect(x: 333.5, y: 161, width: 44.5, height: 52)
//                favBtn.tintColor = .blue
//                context.delete(newFavorite)
//                DataManager.shared.vocabVC.viewWillAppear(true)
//                //print("remove from fav")
//                //print("remove new fav:", newFavorite)
//            }
//            //print(newFavorite)
//            //favBtn.setImage(UIImage(systemName: "heart.fil"), for: .normal)
//            //favBtn.frame = CGRect(x: 333.5, y: 161, width: 44.5, height: 52)
//            
//            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
//            //DataManager.shared.vocabVC.tableView.reloadData()
//        }
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
