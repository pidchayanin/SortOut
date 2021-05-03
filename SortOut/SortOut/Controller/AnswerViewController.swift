//
//  AnswerViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 15/4/2564 BE.
//

import UIKit
import HandySwift
import MLKitTranslate
import CoreServices

class AnswerViewController: UIViewController {

    @IBOutlet weak var complimentLabel: UILabel!
    @IBOutlet weak var engSentenceLabel: UILabel!
    @IBOutlet weak var thaiSentenceLabel: UILabel!
    @IBOutlet weak var coinReceiveLabel: UILabel!
    
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var ansImage: UIImageView!
    
    var receiveEnglishSentence = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        engSentenceLabel.text = receiveEnglishSentence
        engToThaiTranslation()
    }
    

    
    func engToThaiTranslation() {
        // Create an English-German translator:
        let options = TranslatorOptions(sourceLanguage: .english, targetLanguage: .thai)
        let englishThaiTranslator = Translator.translator(options: options)
        
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true
        )
        englishThaiTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else { return }

            // Model downloaded successfully. Okay to start translating.
            englishThaiTranslator.translate(self.receiveEnglishSentence) { translatedText, error in
                guard error == nil, let translatedText = translatedText else { return }

                // Translation succeeded.
                print(translatedText)
                self.thaiSentenceLabel.text = translatedText
            }
        }
        
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Back to Home", message: "Are you sure?", preferredStyle: .alert)
       
        //YES
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"YES\" alert occured.")
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "TabbarID") as! TabbarViewController
            self.present(vc, animated: true, completion: nil)
            
            
        }))
        
        //NO
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Tap no")
      }))
        
        self.present(alert, animated: true, completion: nil)
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
