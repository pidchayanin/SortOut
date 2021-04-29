//
//  GameViewController.swift
//  SortOut
//
//  Created by Pidchayanin Chutipattana on 21/2/2564 BE.
//

import Foundation
import UIKit
import SwiftyJSON

var isReload = false

class GameViewController: UIViewController {
    
    @IBOutlet weak var word1Button: UIButton!
    @IBOutlet weak var word2Button: UIButton!
    @IBOutlet weak var word3Button: UIButton!
    @IBOutlet weak var word4Button: UIButton!
    @IBOutlet weak var word5Button: UIButton!
    @IBOutlet weak var word6Button: UIButton!
    @IBOutlet weak var word7Button: UIButton!
    @IBOutlet weak var word8Button: UIButton!
    @IBOutlet weak var word9Button: UIButton!
    @IBOutlet weak var word10Button: UIButton!
    

    
    @IBOutlet weak var textfield: UITextField!
    
    var words1 = ""
    var words2 = ""
    var words3 = ""
    var words4 = ""
    var words5 = ""
    var words6 = ""
    var words7 = ""
    var words8 = ""
    var words9 = ""
    var words10 = ""
    
    //var numbers = 0
    //var numbers1 = 0
    //var numbers2 = 0
    
    var wordsArr = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        retreiveData()
        addDataToButtons()
    }
    
    func addDataToButtons() {
        word1Button.layer.borderWidth = 1
        word2Button.layer.borderWidth = 1
        word3Button.layer.borderWidth = 1
        word4Button.layer.borderWidth = 1
        word5Button.layer.borderWidth = 1
        word6Button.layer.borderWidth = 1
        word7Button.layer.borderWidth = 1
        word8Button.layer.borderWidth = 1
        word9Button.layer.borderWidth = 1
        word10Button.layer.borderWidth = 1

//        let number1 = numbers1
//        let number2 = numbers2
//        var tempInt = 0
//
//        tempInt += numbers
//
//        if ((number1 + number2) % 9) + 1 == tempInt{
//            print("tempInt: ", tempInt)
        if words1 == ""{
            word1Button.isHidden = true
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
            word9Button.setTitle(words9, for: .normal)
            word10Button.setTitle(words10, for: .normal)
        }
        if words2 == ""{
            word2Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
            word9Button.setTitle(words9, for: .normal)
            word10Button.setTitle(words10, for: .normal)
        }
        if words3 == ""{
            word3Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
            word9Button.setTitle(words9, for: .normal)
            word10Button.setTitle(words10, for: .normal)
        }
        if words4 == ""{
            word4Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
            word9Button.setTitle(words9, for: .normal)
            word10Button.setTitle(words10, for: .normal)
        }
        if words5 == ""{
            word5Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
            word9Button.setTitle(words9, for: .normal)
            word10Button.setTitle(words10, for: .normal)
        }
        if words6 == ""{
            word6Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
            word9Button.setTitle(words9, for: .normal)
            word10Button.setTitle(words10, for: .normal)
        }
        if words7 == "" {
            word7Button.isHidden = true
//                word8Button.isHidden = true
//                word6Button.isHidden = true
//                word5Button.isHidden = true
//                word4Button.isHidden = true
//                word3Button.isHidden = true
//            print(words7)
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word8Button.setTitle(words8, for: .normal)
            word9Button.setTitle(words9, for: .normal)
            word10Button.setTitle(words10, for: .normal)
        }
        if words8 == ""{
            word8Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word9Button.setTitle(words9, for: .normal)
            word10Button.setTitle(words10, for: .normal)
        }
        if words9 == ""{
            word9Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
            word10Button.setTitle(words10, for: .normal)
        }
        if words10 == ""{
            word10Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
            word9Button.setTitle(words9, for: .normal)
        }
        
        else {
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
            word9Button.setTitle(words9, for: .normal)
            word10Button.setTitle(words10, for: .normal)
        }
        //}
        
        
    }
    
    func retreiveData() {
        var tempStr = ""
        let number1 = Int.random(in: 0 ..< 20000)
        let number2 = Int.random(in: 0 ..< number1)
        var tempInt = 0
        var tempInt1 = 0
        
        guard let path = Bundle.main.path(forResource: "English sentences", ofType: "json") else {return}
                
        let url = URL(fileURLWithPath: path)
        //print("--1--")
        do {
            //print("--2--")
            let data = try Data(contentsOf: url)
            let json = try JSON(data: data)
            
            let array = json
            
//            for (index,subJson):(String, JSON) in json {
//                // Do something you want
//                //print(index.count,  subJson["sentence1"])
//                for key in subJson["sentence1"] {
//                    let result = key.1.arrayValue.map({$0["sentence1"].stringValue})
//                    print("key", key.1)
//                    //print("result: ", result)
//                }
//            }
            
            for item in array {
                
                var word1 = ""
                var word2 = ""
                var word3 = ""
                var word4 = ""
                var word5 = ""
                var word6 = ""
                var word7 = ""
                var word8 = ""
                var word9 = ""
                var word10 = ""
                
                let number = item.1["number"]
                
//                word1 = sentences[0].stringValue
//                word2 = sentences[1].stringValue
//                word3 = sentences[2].stringValue
//                word4 = sentences[3].stringValue
//                word5 = sentences[4].stringValue
//                word6 = sentences[5].stringValue
//                word7 = sentences[6].stringValue
//                word8 = sentences[7].stringValue
                
//                let word1 = item.1["sentence1"][0]
//                let word2 = item.1["sentence1"][1]
//                let word3 = item.1["sentence1"][2]
//                let word4 = item.1["sentence1"][3]
//                let word5 = item.1["sentence1"][4]
//                let word6 = item.1["sentence1"][5]
//                let word7 = item.1["sentence1"][6]
//                let word8 = item.1["sentence1"][7]
                //print(item.1["sentence1"].shuffled())
                //print(number)
                //print(word1)
                
                tempStr = number.rawString()!
                tempInt += 1
//                print(tempInt)
//                print("======")
//                print(number1)
//                print("======")
//                print(number2)
                //MARK: This is the beginning of RNG generator
                // %9 is not confirmed rng 1 and 2, too
                if ((number1 + number2) % 9) + 1 == tempInt{
                    //numbers1 = number1
                    //numbers2 = number2
//                    print("temp: ", tempStr)
//                    print("======")
                    
                    tempInt1 = Int(tempStr)!
                    //numbers = tempInt1
                    //print("numbers: ", numbers)
                    print("num: ", tempInt1)
                    
//                    print("Int: ", tempInt1)
                    
                    let sentences = item.1["sentence1"].arrayValue.shuffled()
                    //let testWord1 = sentences[0]
                    if sentences.count <= 10 && sentences.count > 9 {
                        word1 = sentences[0].stringValue.lowercased()
                        word2 = sentences[1].stringValue.lowercased()
                        word3 = sentences[2].stringValue.lowercased()
                        word4 = sentences[3].stringValue.lowercased()
                        word5 = sentences[4].stringValue.lowercased()
                        word6 = sentences[5].stringValue.lowercased()
                        word7 = sentences[6].stringValue.lowercased()
                        word8 = sentences[7].stringValue.lowercased()
                        word9 = sentences[8].stringValue.lowercased()
                        word10 = sentences[9].stringValue.lowercased()
                    }
                    else if sentences.count <= 9 && sentences.count > 8 {
                        word1 = sentences[0].stringValue.lowercased()
                        word2 = sentences[1].stringValue.lowercased()
                        word3 = sentences[2].stringValue.lowercased()
                        word4 = sentences[3].stringValue.lowercased()
                        word5 = sentences[4].stringValue.lowercased()
                        word6 = sentences[5].stringValue.lowercased()
                        word7 = sentences[6].stringValue.lowercased()
                        word8 = sentences[7].stringValue.lowercased()
                        word9 = sentences[8].stringValue.lowercased()
                    }
                    else if sentences.count <= 8 && sentences.count > 7 {
                        word1 = sentences[0].stringValue.lowercased()
                        word2 = sentences[1].stringValue.lowercased()
                        word3 = sentences[2].stringValue.lowercased()
                        word4 = sentences[3].stringValue.lowercased()
                        word5 = sentences[4].stringValue.lowercased()
                        word6 = sentences[5].stringValue.lowercased()
                        word7 = sentences[6].stringValue.lowercased()
                        word8 = sentences[7].stringValue.lowercased()
                    }
                    else if sentences.count <= 7 && sentences.count > 6 {
                        word1 = sentences[0].stringValue.lowercased()
                        word2 = sentences[1].stringValue.lowercased()
                        word3 = sentences[2].stringValue.lowercased()
                        word4 = sentences[3].stringValue.lowercased()
                        word5 = sentences[4].stringValue.lowercased()
                        word6 = sentences[5].stringValue.lowercased()
                        word7 = sentences[6].stringValue.lowercased()
                    }
                    else if sentences.count <= 6 && sentences.count > 5 {
                        word1 = sentences[0].stringValue.lowercased()
                        word2 = sentences[1].stringValue.lowercased()
                        word3 = sentences[2].stringValue.lowercased()
                        word4 = sentences[3].stringValue.lowercased()
                        word5 = sentences[4].stringValue.lowercased()
                        word6 = sentences[5].stringValue.lowercased()
                    }
                    else if sentences.count <= 5 && sentences.count > 4 {
                        word1 = sentences[0].stringValue.lowercased()
                        word2 = sentences[1].stringValue.lowercased()
                        word3 = sentences[2].stringValue.lowercased()
                        word4 = sentences[3].stringValue.lowercased()
                        word5 = sentences[4].stringValue.lowercased()
                    }
                    else if sentences.count <= 4 && sentences.count > 3 {
                        word1 = sentences[0].stringValue.lowercased()
                        word2 = sentences[1].stringValue.lowercased()
                        word3 = sentences[2].stringValue.lowercased()
                        word4 = sentences[3].stringValue.lowercased()
                    }
                    else if sentences.count <= 3 && sentences.count > 2 {
                        word1 = sentences[0].stringValue.lowercased()
                        word2 = sentences[1].stringValue.lowercased()
                        word3 = sentences[2].stringValue.lowercased()
                    }
                    else if sentences.count <= 2 && sentences.count > 1 {
                        word1 = sentences[0].stringValue.lowercased()
                        word2 = sentences[1].stringValue.lowercased()
                    }
                    else if sentences.count <= 1 && sentences.count > 0 {
                        word1 = sentences[0].stringValue.lowercased()
                    }

                    words1 = word1
                    words2 = word2
                    words3 = word3
                    words4 = word4
                    words5 = word5
                    words6 = word6
                    words7 = word7
                    words8 = word8
                    words9 = word9
                    words10 = word10
                }
                
                

                
                
                
//                numbers = number.intValue
//                print(numbers)
//
//                words1 = word1.rawString()!
//                words2 = word2.rawString()!
//                words3 = word3.rawString()!
//                words4 = word4.rawString()!
//                words5 = word5.rawString()!
//                words6 = word6.rawString()!
//                words7 = word7.rawString()!
//                words8 = word8.rawString()!
                
                
                
                

                
//                print(words1)
                
//                print(number)
//                print(word1)
//                print(word2)
//                print(word3)
//                print(word4)
//                print(word5)
//                print(word6)
//                print(word7)
//                print(word8)
                
//                print("itemProperty :", itemProperty)
//                print("star :", star)
//                print("coin :", coin)
//                print("itemName :", itemName)
                
                
//                print("I notice you kouhai-kun!")
                
            }
            
            
            
        } catch {
            print("--------\n", error)
        }
    }
    
    //ToDO: Fix UI of upper button for long words
    
    @IBAction func word1Tapped(_ sender: Any) {
        
        word1Button.isHidden = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words1.capitalized
        }
        else {
            textfield.text?.append(" " + words1)
        }
        
    }
    
    @IBAction func word2Tapped(_ sender: Any) {
        
        word2Button.isHidden = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words2.capitalized
        }
        else {
            textfield.text?.append(" " + words2)
        }
        
    }
    
    @IBAction func word3Tapped(_ sender: Any) {
        
        word3Button.isHidden = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words3.capitalized
        }
        else {
            textfield.text?.append(" " + words3)
        }
        
    }
    
    @IBAction func word4Tapped(_ sender: Any) {
        
        word4Button.isHidden = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words4.capitalized
        }
        else {
            textfield.text?.append(" " + words4)
        }
        
    }
    
    @IBAction func word5Tapped(_ sender: Any) {
        
        word5Button.isHidden = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words5.capitalized
        }
        else {
            textfield.text?.append(" " + words5)
        }
        
    }
    
    @IBAction func word6Tapped(_ sender: Any) {
        
        word6Button.isHidden = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words6.capitalized
        }
        else {
            textfield.text?.append(" " + words6)
        }
        
    }
    
    @IBAction func word7Tapped(_ sender: Any) {
        
        word7Button.isHidden = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words7.capitalized
        }
        else {
            textfield.text?.append(" " + words7)
        }
        
    }
    
    @IBAction func word8Tapped(_ sender: Any) {
        
        word8Button.isHidden = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words8.capitalized
        }
        else {
            textfield.text?.append(" " + words8)
        }
        
    }
    
    @IBAction func word9Tapped(_ sender: Any) {
        
        word9Button.isHidden = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words9.capitalized
        }
        else {
            textfield.text?.append(" " + words9)
        }
    }
    
    @IBAction func word10Tapped(_ sender: Any) {
        
        word10Button.isHidden = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words10.capitalized
        }
        else {
            textfield.text?.append(" " + words10)
        }
    }
    

    //MARK: Delete button tapped
    @IBAction func deleteTapped(_ sender: Any) {
        //ToDo: Make condition that if the button is null so .isHidden = true
        if words5 == "" {
            word5Button.isHidden = true
            
            textfield.text = ""
            
            word1Button.isHidden = false
            word2Button.isHidden = false
            word3Button.isHidden = false
            word4Button.isHidden = false
//            print("1")
        }
        else if words6 == "" {
            word6Button.isHidden = true
//            print("2")
            
            textfield.text = ""
            
            word1Button.isHidden = false
            word2Button.isHidden = false
            word3Button.isHidden = false
            word4Button.isHidden = false
            word5Button.isHidden = false
        }
        else if words7 == "" {
            word7Button.isHidden = true
            
            textfield.text = ""
            
            word1Button.isHidden = false
            word2Button.isHidden = false
            word3Button.isHidden = false
            word4Button.isHidden = false
            word5Button.isHidden = false
            word6Button.isHidden = false
//            print("3")
        }
        else if words8 == "" {
            word8Button.isHidden = true
            
            textfield.text = ""
            
            word1Button.isHidden = false
            word2Button.isHidden = false
            word3Button.isHidden = false
            word4Button.isHidden = false
            word5Button.isHidden = false
            word6Button.isHidden = false
            word7Button.isHidden = false
//            print("4")
        }
        else if words9 == "" {
            word9Button.isHidden = true
            
            textfield.text = ""
            
            word1Button.isHidden = false
            word2Button.isHidden = false
            word3Button.isHidden = false
            word4Button.isHidden = false
            word5Button.isHidden = false
            word6Button.isHidden = false
            word7Button.isHidden = false
            word8Button.isHidden = false
        }
        else if words10 == "" {
            word10Button.isHidden = true
            
            textfield.text = ""
            
            word1Button.isHidden = false
            word2Button.isHidden = false
            word3Button.isHidden = false
            word4Button.isHidden = false
            word5Button.isHidden = false
            word6Button.isHidden = false
            word7Button.isHidden = false
            word8Button.isHidden = false
            word9Button.isHidden = false
        }
        else{
        word1Button.isHidden = false
        word2Button.isHidden = false
        word3Button.isHidden = false
        word4Button.isHidden = false
        word5Button.isHidden = false
        word6Button.isHidden = false
        word7Button.isHidden = false
        word8Button.isHidden = false
        word9Button.isHidden = false
        word10Button.isHidden = false
            
        textfield.text = ""
//            print("normal")
        }
        
        
    }
   
    @IBAction func showGameSettingPopUp(_ sender: Any) {
        //noted: Main as in Main.storyboard
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameSettingPopUpID") as! GameSettingPopUpViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if words5 == "" {
            wordsArr = [words1, words2, words3, words4]
        } else if words6 == "" {
            wordsArr = [words1, words2, words3, words4, words5]
        } else if words7 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6]
        } else if words8 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7]
        } else if words9 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8]
        } else if words10 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
        }
        else {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9, words10]
        }
        
        if segue.identifier == "toDictionary" {
            //isReload = true
            let vc = segue.destination as? DictionaryViewController
            vc?.word = wordsArr
        }
        else if segue.identifier == "toCorrectAnswer" {
            //for passing data to ans screen
            let vc = segue.destination as? AnswerViewController
            vc?.receiveEnglishSentence = textfield.text! + "."
            
        }
    }
    

}
