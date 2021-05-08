//
//  AnswerViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 15/4/2564 BE.
//

import UIKit
import HandySwift
import MLKitTranslate

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
        
        coinImage.image = UIImage(named: "coin.png")
        coinReceiveLabel.text = "+ 100"
        complimentLabel.text = "Awesome!"
        
        let jsonInItObject: [Any]  = [
            [
                "star": 0,
                "coin": 1000,
                "itemName": "RETRY",
                "itemDescription": "Use this to try again when your answer is incorrect.",
                "itemPrice": 100,
                "itemNum": 0
            ]
        ]

        do{
            let checkInit = try initFile(jsonObject: jsonInItObject, toFilename: "ItemProp")
            print("checkInit: ", checkInit) //return false if file already exists
        }
        catch {
            
        }

        coinReceiveLabel.text = "+ 100"
        // Do any additional setup after loading the view.
        engSentenceLabel.text = receiveEnglishSentence
        engToThaiTranslation()
        updateDataToJSON()
    }
    

    
    func engToThaiTranslation() {
        // Create an English-Thai translator:
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
    
    func updateDataToJSON() {
        do {
            var coin = 0
            let jsons = try loadJSON(withFilename: "ItemProp")
//            print(jsons!)
            guard let array = jsons as? [Any] else {return}
            for i in array {
                guard let num = i as? [String: Any] else { return }
                coin = num["coin"] as! Int
            }
            coin += 100
            
            let jsonObject: [Any]  = [
                [
                    "star": 0,
                    "coin": coin,
                    "itemName": "RETRY",
                    "itemDescription": "Use this to try again when your answer is incorrect.",
                    "itemPrice": 100,
                    "itemNum": 0
                ]
            ]
            
            print("coin:", coin)
            
            let check = try save(jsonObject: jsonObject, toFilename: "ItemProp")
            print("check: ", check)
        }
        catch {
            let error = error
            print(error)
        }
    }
    
    func loadJSON(withFilename filename: String) throws -> Any? {
            let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
            if let url = urls.first {
                var fileURL = url.appendingPathComponent(filename)
                fileURL = fileURL.appendingPathExtension("json")
//                print(fileURL)
                let data = try Data(contentsOf: fileURL)
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves])
                return jsonObject
            }
            return nil
    }
    
    func save(jsonObject: Any, toFilename filename: String) throws -> Bool{
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            try data.write(to: fileURL, options: [.atomicWrite])
            return true
        }
        return false
    }
    
    func initFile(jsonObject: Any, toFilename filename: String) throws -> Bool{
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            
            let fileExists = (try? fileURL.checkResourceIsReachable()) ?? false
            if fileExists == true {
                return false
            }
            
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            try data.write(to: fileURL, options: [.atomicWrite])
            return true
        }
            
        return false
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
