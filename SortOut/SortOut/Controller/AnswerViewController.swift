//
//  AnswerViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 15/4/2564 BE.
//

import UIKit
import HandySwift
import MLKitTranslate
import CoreData
import NaturalLanguage

class AnswerViewController: UIViewController {

    @IBOutlet weak var complimentLabel: UILabel!
    @IBOutlet weak var engSentenceLabel: UILabel!
    @IBOutlet weak var thaiSentenceLabel: UILabel!
    @IBOutlet weak var coinReceiveLabel: UILabel!
    
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var ansImage: UIImageView!
    
    @IBOutlet weak var retryLabel: UILabel!
    @IBOutlet weak var playNextLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var retryItemBtn: UIButton!
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var receiveEnglishSentence = ""
    var receiveImage = ""
    var receiveNum = 0
    var receiveSentence = [Any]()
    var receiveStar = ""
    var threeStar = "3-star.png"
    var twoStar = "2-star.png"
    var oneStar = "1-star.png"
    var zeroStar = "0-star.png"
    var thaiSentence = ""
    var compliments = ""
    var itemNumber = 0
    var useItem = 0
    var usedItemPrev = 0
    var useItemPrev = 0
    
    var sentenceAns = [SentenceAnswers]()
    
    var coins = 0

    let currentDate = Date()
    
    var starCollect = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
        DataManager.shared.ansVC = self
        
        //print("ansrs: ", receiveSentence)

        starImage.image = UIImage(named: receiveStar)
        
        coinImage.image = UIImage(named: "coin.png")
        coinReceiveLabel.text = "+ \(coins)"
        //coinReceiveLabel.text = "+ 100"
        //complimentLabel.text = compliments
        
        retryLabel.text = "Try again"
        playNextLabel.text = "Play next"
        homeLabel.text = "Home"
        ansImage.image = UIImage(named: receiveImage)
        //print("ri", receiveImage)
        
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

        checkSentences()
        //coinReceiveLabel.text = "+ 100"
        // Do any additional setup after loading the view.
        engSentenceLabel.text = receiveEnglishSentence
        engToThaiTranslation()
        updateDataToJSON()
        //saveToCoreData()
        UserDefaults.standard.setValue(1, forKey: "firstGame")
    }
    
    func checkSentences() {
        //updateDataToJSON()
        
        
        guard let filepath = Bundle.main.path(forResource: "Englishsentences - answers", ofType: "csv") else {
            return
        }
        var data = ""
        do {
            data = try String(contentsOfFile: filepath)
            var rows = data.components(separatedBy: "\n")
            rows.removeFirst()
            for row in rows {
                let columns = row.components(separatedBy: ",")
                print("columns: ", columns)
                let sentences = columns[0]
                let scoring = Int(String(columns[1].filter {!"\r".contains($0)})) ?? 0
                print("scoring: ", scoring)
                let ans = SentenceAnswers(sentences: sentences, score: scoring)
                sentenceAns.append(ans)
            }
            //print("sentenceAns: ", sentenceAns)
            for sentence in sentenceAns {
                let sentences = sentence.sentences
                //print("senScore", sentence.score)
                if receiveEnglishSentence == sentences {
                    print("reEng: ", receiveEnglishSentence)
                    print("sent: ", sentences)
                    let score = sentence.score
                    print("score: ", score)
                    print("====score:====")
                    if score == 3 {
                        receiveStar = threeStar
                        starImage.image = UIImage(named: receiveStar)
                        coins = 100
                        coinImage.isHidden = false
                        coinReceiveLabel.isHidden = false
                        ansImage.isHidden = false
                        retryBtn.isHidden = false
                        retryItemBtn.isHidden = true
                        retryLabel.text = "Retry"
                        coinReceiveLabel.text = "+ \(coins)"
                        complimentLabel.text = "You are an expert at this!"
                        playNextLabel.text = "Play next"
                    }
                    else if score == 2 {
                        receiveStar = twoStar
                        starImage.image = UIImage(named: receiveStar)
                        coins = 50
                        coinImage.isHidden = false
                        coinReceiveLabel.isHidden = false
                        ansImage.isHidden = false
                        retryBtn.isHidden = false
                        retryItemBtn.isHidden = true
                        retryLabel.text = "Retry"
                        coinReceiveLabel.text = "+ \(coins)"
                        complimentLabel.text = "Great job!"
                        playNextLabel.text = "Play next"
                    }
                    else if score == 1 {
                        receiveStar = oneStar
                        starImage.image = UIImage(named: receiveStar)
                        coins = 25
                        coinImage.isHidden = false
                        coinReceiveLabel.isHidden = false
                        ansImage.isHidden = false
                        retryBtn.isHidden = false
                        retryItemBtn.isHidden = true
                        coinReceiveLabel.text = "+ \(coins)"
                        retryLabel.text = "Retry"
                        complimentLabel.text = "You have unique potential!"
                        playNextLabel.text = "Play next"
                    }
                }
                
                if coinImage.isHidden == true {
                    print("score 0")
                    let usedItem = UserDefaults.standard.integer(forKey: "usedItem")
                    print("init useditem", usedItem)
                    receiveStar = zeroStar
                    starImage.image = UIImage(named: receiveStar)
                    coinImage.isHidden = true
                    coinReceiveLabel.isHidden = true
                    ansImage.isHidden = true
                    retryBtn.isHidden = true
                    retryItemBtn.isHidden = false
//                    if usedItem != useItemPrev {
                    retryLabel.text = "Retry (item \(usedItem) left)"
                    print("usedItem != 0: ", usedItem)
                    print("useditemPrev1: ", useItemPrev)
//                    }
//                    else {
//                        retryLabel.text = "Retry (item \(usedItem) left)"
//                        //retryLabel.text = "Retry (item 0 left)"
//                        print("usedItem == 0: ", usedItem)
//                        print("useditemPrev2: ", useItemPrev)
//                    }
                    complimentLabel.text = "Don't give up!"
                    playNextLabel.text = "Skip"
                    useItemPrev = usedItem
                }
//                else {
//                    print("score 0")
//                    let usedItem = UserDefaults.standard.integer(forKey: "usedItem")
//                    receiveStar = zeroStar
//                    starImage.image = UIImage(named: receiveStar)
//                    coinImage.isHidden = true
//                    coinReceiveLabel.isHidden = true
//                    ansImage.isHidden = true
//                    retryBtn.isHidden = true
//                    retryItemBtn.isHidden = false
//                    retryLabel.text = "Retry (item \(usedItem) left)"
//                    complimentLabel.text = "Don't give up!"
//                    playNextLabel.text = "Skip"
//                }
                
            }
            
        }
        catch {
            fatalError("cannot use model")
            //return
        }
        
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
                let historyData = HistoryCD.init(context: self.context!)
                // Translation succeeded.
                print(translatedText)
                
                self.thaiSentenceLabel.text = translatedText
                historyData.thaiSentence = translatedText
                historyData.englishSentence = self.receiveEnglishSentence
                historyData.receivedStar = self.receiveStar
                historyData.date = self.currentDate
                do {
                    try self.context?.save()
                }
                catch {
                    print("error: ", error)
                }
            }
        }
        
    }
    
    func saveToCoreData() {
        let historyData = HistoryCD.init(context: context!)
        historyData.englishSentence = receiveEnglishSentence
        historyData.receivedStar = receiveStar
        historyData.date = currentDate
        do {
            try context?.save()
        }
        catch {
            print("error: ", error)
        }
    }
    
    func useRetryItem() {
        let items = UserDefaults.standard.integer(forKey: "itemNums")
        if items != 0 {
            useItem = items
            print("useItem1: ", useItem)
            UserDefaults.standard.setValue(items, forKey: "usedItem")
            let alert = UIAlertController(title: "Try again (Use Item)", message: "Are you sure?", preferredStyle: .alert)
            
            //YES
            alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
                //var items = UserDefaults.standard.integer(forKey: "itemNums")
                
                self.useItem -= 1
                //self.updateDataToJSON()
                //self.useItem -= 1
                UserDefaults.standard.setValue(self.useItem, forKey: "usedItem")
                print("useItem2: ", self.useItem)
                let newReceiveSentence: [String] = self.receiveSentence.compactMap {String(describing: $0)}
                UserDefaults.standard.setValue(self.receiveNum, forKey: "randomNum")
                UserDefaults.standard.setValue(newReceiveSentence, forKey: "randomSentence")
                UserDefaults.standard.setValue(self.receiveImage, forKey: "randomImg")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "gameViewID")
                self.present(vc, animated: true)
                
            }))
            
            //NO
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Tap no")
          }))
            
            self.present(alert, animated: true, completion: nil)
        }
        else {
//            useItem = items
            /*let alert = UIAlertController(title: "You do not have enough item!", message: "Please buy item at the shop", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)*/
            
            let alert = UIAlertController(title: "You do not have enough coins", message: "Want to visit the shop?", preferredStyle: .alert)
            
            //YES
            alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ShopID") as! BetterShopViewController
                
                self.present(vc, animated: true)
                vc.closeBtn.isHidden = false
            }))
            
            //NO
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Tap no")
          }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateDataToJSON() {
        do {
            var coin = 0
            var star = 0
            var itemNums = 0
            let jsons = try loadJSON(withFilename: "ItemProp")
//            print(jsons!)
            guard let array = jsons as? [Any] else {return}
            for i in array {
                guard let num = i as? [String: Any] else { return }
                coin = num["coin"] as! Int
                star = num["star"] as! Int
                itemNums = num["itemNum"] as! Int
            }
            coin += coins
            itemNumber = itemNums
            print("itemNumber: ", itemNums)
            UserDefaults.standard.setValue(itemNums, forKey: "itemNums")
            
            if starImage.image == UIImage(named: "3-star.png") {
                starCollect = 3
            } else if starImage.image == UIImage(named: "2-star.png") {
                starCollect = 2
            } else if starImage.image == UIImage(named: "1-star.png") {
                starCollect = 1
            } else if starImage.image == UIImage(named: "0-star.png") {
                starCollect = 0
            }
            star += starCollect
            //useRetryItem()
            let usedItem = UserDefaults.standard.integer(forKey: "usedItem")
            
            itemNums = usedItem
            
            print("usedItem3: ", usedItem)
            print("itemNums - useItem: ", itemNums)
            let jsonObject: [Any]  = [
                [
                    "star": star,
                    "coin": coin,
                    "itemName": "RETRY",
                    "itemDescription": "Use this to try again when your answer is incorrect.",
                    "itemPrice": 100,
                    "itemNum": itemNums
                ]
            ]
            
            //print("coin:", coin)
            
            let check = try save(jsonObject: jsonObject, toFilename: "ItemProp")
            print("check: ", check)
            
//            if usedItem != usedItemPrev {
//                self.viewDidLoad()
//            }
//            usedItemPrev = usedItem
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
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
//        checkSentences()
//    }
    
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
    
    
    @IBAction func playNextTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Play next round", message: "Are you sure?", preferredStyle: .alert)
        
        //YES
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            
            UserDefaults.standard.removeObject(forKey: "randomNum")
            UserDefaults.standard.removeObject(forKey: "randomSentence")
            UserDefaults.standard.removeObject(forKey: "randomImg")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "gameViewID")
            self.present(vc, animated: true)
            
        }))
        
        //NO
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Tap no")
      }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func retryTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Try again", message: "Are you sure?", preferredStyle: .alert)
        
        //YES
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            
            let newReceiveSentence: [String] = self.receiveSentence.compactMap {String(describing: $0)}
            UserDefaults.standard.setValue(self.receiveNum, forKey: "randomNum")
            UserDefaults.standard.setValue(newReceiveSentence, forKey: "randomSentence")
            UserDefaults.standard.setValue(self.receiveImage, forKey: "randomImg")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "gameViewID")
            self.present(vc, animated: true)
            
        }))
        
        //NO
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Tap no")
      }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func retryItemTapped(_ sender: Any) {
        useRetryItem()
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
