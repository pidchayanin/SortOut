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
