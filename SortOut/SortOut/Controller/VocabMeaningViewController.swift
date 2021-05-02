//
//  VocabMeaningViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 21/2/2564 BE.
//

import UIKit

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
    
    var meaningWord = String()
    var meaningPartOfSpeech = String()
    let meaningMean = "หมายถึง"
    var meaningMeaning = String()
    let meaningSynnonyms = "Synnonyms"
    var meaningSynnonymWords = String()
    let meaningExample = "Example"
    var meaningExampleSentences = String()
    
    override func viewWillAppear(_ animated: Bool) {
        
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
        favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        favBtn.frame = CGRect(x: 333.5, y: 161, width: 44.5, height: 52)
    }
    
    @IBAction func isFavoriteTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let newFavorite = FavoriteVocabCD.init(context:context)

            newFavorite.favWord = meaningWord
            newFavorite.favPoS = meaningPartOfSpeech
            print("fav tapped")
            
            if favBtn.currentImage == UIImage(systemName: "heart") {
                favBtn.setImage(UIImage(systemName: "star"), for: .normal)
                favBtn.frame = CGRect(x: 333.5, y: 161, width: 44.5, height: 52)
                favBtn.tintColor = .blue
            }
            //favBtn.setImage(UIImage(systemName: "heart.fil"), for: .normal)
            //favBtn.frame = CGRect(x: 333.5, y: 161, width: 44.5, height: 52)
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            //DataManager.shared.vocabVC.tableView.reloadData()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
