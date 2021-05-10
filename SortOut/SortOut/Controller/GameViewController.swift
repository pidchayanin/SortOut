//
//  GameViewController.swift
//  SortOut
//
//  Created by Pidchayanin Chutipattana on 21/2/2564 BE.
//

import Foundation
import UIKit
import SwiftyJSON
import HandySwift

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
    
    @IBOutlet weak var submitBtn: UIButton!
    
    
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
    
    var definitions = String()
    var synnonyms = String()
    var sentenceExamples = String()
    var image = String()
    var randomNum = Int()
    var randomSentence = [Any]()
    
    var getStar = ""
    /*print("def: ", definitions)
    print("synn: ", synnonyms)
    print("example: ", sentenceExamples)*/
    var defArr = [String]()
    var synArr = [String]()
    var exampleArr = [String]()
    var tempArr = [Int]()
    //var numbers = 0
    //var numbers1 = 0
    //var numbers2 = 0
    
    var wordsArr = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if textfield.text == "" {
//            submitBtn.backgroundColor = UIColor.gray
            submitBtn.isEnabled = false
        }
        
        retreiveData()
        addDataToButtons()
        //retrieveDictionary()
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
        let number1 = Int.random(in: 0 ..< 50000)
        let number2 = Int.random(in: 0 ..< number1)
        var tempInt = 0
        var tempInt1 = 0
        var retryNum = 0
        var randomSentences = [String]()
        var randomImg = ""
        //var tempImg = ""
        
        
        guard let path = Bundle.main.path(forResource: "English sentences(2)", ofType: "json") else {return}
                
        let url = URL(fileURLWithPath: path)
        //print("--1--")
        do {
            //print("--2--")
            let data = try Data(contentsOf: url)
            let json = try JSON(data: data)
            
            let array = json
                
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
                
                tempStr = number.rawString()!
                tempInt += 1

                retryNum = UserDefaults.standard.integer(forKey: "randomNum")
                randomSentences = UserDefaults.standard.stringArray(forKey: "randomSentence") ?? [""]
                randomImg = UserDefaults.standard.string(forKey: "randomImg") ?? ""
                
                if retryNum != 0 {
                    tempInt1 = retryNum
                    randomNum = tempInt1
                    print("num: ", tempInt1)
                    randomSentence = randomSentences
                    image = randomImg
                    print("sentence: ", randomSentences)
                    if randomSentences.count <= 10 && randomSentences.count > 9 {
                        word1 = randomSentences[0].lowercased()
                        word2 = randomSentences[1].lowercased()
                        word3 = randomSentences[2].lowercased()
                        word4 = randomSentences[3].lowercased()
                        word5 = randomSentences[4].lowercased()
                        word6 = randomSentences[5].lowercased()
                        word7 = randomSentences[6].lowercased()
                        word8 = randomSentences[7].lowercased()
                        word9 = randomSentences[8].lowercased()
                        word10 = randomSentences[9].lowercased()
                    }
                    else if randomSentences.count <= 9 && randomSentences.count > 8 {
                        word1 = randomSentences[0].lowercased()
                        word2 = randomSentences[1].lowercased()
                        word3 = randomSentences[2].lowercased()
                        word4 = randomSentences[3].lowercased()
                        word5 = randomSentences[4].lowercased()
                        word6 = randomSentences[5].lowercased()
                        word7 = randomSentences[6].lowercased()
                        word8 = randomSentences[7].lowercased()
                        word9 = randomSentences[8].lowercased()
                    }
                    else if randomSentences.count <= 8 && randomSentences.count > 7 {
                        word1 = randomSentences[0].lowercased()
                        word2 = randomSentences[1].lowercased()
                        word3 = randomSentences[2].lowercased()
                        word4 = randomSentences[3].lowercased()
                        word5 = randomSentences[4].lowercased()
                        word6 = randomSentences[5].lowercased()
                        word7 = randomSentences[6].lowercased()
                        word8 = randomSentences[7].lowercased()
                    }
                    else if randomSentences.count <= 7 && randomSentences.count > 6 {
                        word1 = randomSentences[0].lowercased()
                        word2 = randomSentences[1].lowercased()
                        word3 = randomSentences[2].lowercased()
                        word4 = randomSentences[3].lowercased()
                        word5 = randomSentences[4].lowercased()
                        word6 = randomSentences[5].lowercased()
                        word7 = randomSentences[6].lowercased()
                    }
                    else if randomSentences.count <= 6 && randomSentences.count > 5 {
                        word1 = randomSentences[0].lowercased()
                        word2 = randomSentences[1].lowercased()
                        word3 = randomSentences[2].lowercased()
                        word4 = randomSentences[3].lowercased()
                        word5 = randomSentences[4].lowercased()
                        word6 = randomSentences[5].lowercased()
                    }
                    else if randomSentences.count <= 5 && randomSentences.count > 4 {
                        word1 = randomSentences[0].lowercased()
                        word2 = randomSentences[1].lowercased()
                        word3 = randomSentences[2].lowercased()
                        word4 = randomSentences[3].lowercased()
                        word5 = randomSentences[4].lowercased()
                    }
                    else if randomSentences.count <= 4 && randomSentences.count > 3 {
                        word1 = randomSentences[0].lowercased()
                        word2 = randomSentences[1].lowercased()
                        word3 = randomSentences[2].lowercased()
                        word4 = randomSentences[3].lowercased()
                    }
                    else if randomSentences.count <= 3 && randomSentences.count > 2 {
                        word1 = randomSentences[0].lowercased()
                        word2 = randomSentences[1].lowercased()
                        word3 = randomSentences[2].lowercased()
                    }
                    else if randomSentences.count <= 2 && randomSentences.count > 1 {
                        word1 = randomSentences[0].lowercased()
                        word2 = randomSentences[1].lowercased()
                    }
                    else if randomSentences.count <= 1 && randomSentences.count > 0 {
                        word1 = randomSentences[0].lowercased()
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
                    
                    UserDefaults.standard.removeObject(forKey: "randomNum")
                    UserDefaults.standard.removeObject(forKey: "randomSentence")
                    UserDefaults.standard.removeObject(forKey: "randomImg")
                    break
                    
                } else {
                    //MARK: This is the beginning of RNG generator
                    // %9 is not confirmed rng 1 and 2, too
                    if ((number1 + number2) % 71) + 1 == tempInt{
                        print("tempInt:", tempInt)

                        tempInt1 = Int(tempStr)!
                        randomNum = tempInt1
                        print("num: ", tempInt1)
                        
                        let sentences = item.1["sentence1"].arrayValue.shuffled()
                        print("ss: ", sentences as Array<Any>)
                        
                        randomSentence = sentences as Array<Any>
                        print("rs: ", randomSentence)
                        
                        let img = item.1["image"].stringValue
                        image = img
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
                }
            }
        } catch {
            print("--------\n", error)
        }
    }
    
    func retrieveDictionary() {
        
        var def = ""
        var synn = ""
        var ex = ""
        var vocab = ""
        guard let path = Bundle.main.path(forResource: "Englishsentences - Dictionary (2)", ofType: "json") else {return}
                
        let url = URL(fileURLWithPath: path)
        
        do{
            let data = try Data(contentsOf: url)
            let json = try JSON(data: data)
            
            for i in json {
                vocab = i.1["vocabulary"].stringValue
                //print("vocab in loop:", vocab)
                
                    //print("i:", i)
                for k in wordsArr {
                    if vocab == k {
                        //print("word:", word)
                        //print("k:", k)
                        def = i.1["definition"].stringValue
                        synn = i.1["synonym"].stringValue
                        ex = i.1["sentence_example"].stringValue
                        
                        definitions = def
                        synnonyms = synn
                        sentenceExamples = ex
                        /*print("def: ", definitions)
                        print("synn: ", synnonyms)
                        print("example: ", sentenceExamples)*/
                        defArr.append(definitions)
                        synArr.append(synnonyms)
                        exampleArr.append(sentenceExamples)
                        print("defArr:", defArr)
                        print("synArr:", synArr)
                        print("exampleArr", exampleArr)
                    }
                }
            }
        }
        catch {
            
        }
    }
    
    //ToDO: Fix UI of upper button for long words
    
    @IBAction func word1Tapped(_ sender: Any) {
        
        word1Button.isHidden = true
        submitBtn.isEnabled = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words1.capitalized
        }
        else {
            textfield.text?.append(" " + words1)
        }
        
    }
    
    @IBAction func word2Tapped(_ sender: Any) {
        
        word2Button.isHidden = true
        submitBtn.isEnabled = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words2.capitalized
        }
        else {
            textfield.text?.append(" " + words2)
        }
        
    }
    
    @IBAction func word3Tapped(_ sender: Any) {
        
        word3Button.isHidden = true
        submitBtn.isEnabled = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words3.capitalized
        }
        else {
            textfield.text?.append(" " + words3)
        }
        
    }
    
    @IBAction func word4Tapped(_ sender: Any) {
        
        word4Button.isHidden = true
        submitBtn.isEnabled = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words4.capitalized
        }
        else {
            textfield.text?.append(" " + words4)
        }
        
    }
    
    @IBAction func word5Tapped(_ sender: Any) {
        
        word5Button.isHidden = true
        submitBtn.isEnabled = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words5.capitalized
        }
        else {
            textfield.text?.append(" " + words5)
        }
        
    }
    
    @IBAction func word6Tapped(_ sender: Any) {
        
        word6Button.isHidden = true
        submitBtn.isEnabled = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words6.capitalized
        }
        else {
            textfield.text?.append(" " + words6)
        }
        
    }
    
    @IBAction func word7Tapped(_ sender: Any) {
        
        word7Button.isHidden = true
        submitBtn.isEnabled = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words7.capitalized
        }
        else {
            textfield.text?.append(" " + words7)
        }
        
    }
    
    @IBAction func word8Tapped(_ sender: Any) {
        
        word8Button.isHidden = true
        submitBtn.isEnabled = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words8.capitalized
        }
        else {
            textfield.text?.append(" " + words8)
        }
        
    }
    
    @IBAction func word9Tapped(_ sender: Any) {
        
        word9Button.isHidden = true
        submitBtn.isEnabled = true
        
        if textfield.text?.isEmpty == true {
            textfield.text = words9.capitalized
        }
        else {
            textfield.text?.append(" " + words9)
        }
    }
    
    @IBAction func word10Tapped(_ sender: Any) {
        
        word10Button.isHidden = true
        submitBtn.isEnabled = true
        
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
    
    @IBAction func submitTapped(_ sender: Any) {
        print("submit tapped")
        if word1Button.isHidden == true && word2Button.isHidden == true && word3Button.isHidden == true && word4Button.isHidden == true && word5Button.isHidden == true && word6Button.isHidden == true && word7Button.isHidden == true && word8Button.isHidden == true && word9Button.isHidden == true && word10Button.isHidden == true {
            getStar = "3-star.png"
            print("3 star", getStar)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toCorrectAnswer", sender: self)
            }
        }
        else if word1Button.isHidden == true && word2Button.isHidden == true && word3Button.isHidden == true && word4Button.isHidden == true && word5Button.isHidden == true {
            getStar = "2-star.png"
            print("2 star", getStar)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toCorrectAnswer", sender: self)
            }
        }
        else if  word1Button.isHidden == true && word2Button.isHidden == true && word3Button.isHidden == true {
            getStar = "1-star.png"
            print("1 star", getStar)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toCorrectAnswer", sender: self)
            }
        }
        /*else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "wrongAnswerID")
            self.present(vc, animated: true)
        }*/
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //MARK: To do - Check if human's name = no need to pass the data. Also check if it has the same word in the sentence = no need to pass that data.
        
        //wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9, words10]
        var wordsArrRemoveDupe = [String]()
        //wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        //print("wadp", wordsArrRemoveDupe)
        
        if words5 == "" {
            wordsArr = [words1, words2, words3, words4]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
            print(1)
        } else if words6 == "" {
            wordsArr = [words1, words2, words3, words4, words5]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
            print(2)
        } else if words7 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
            print(3)
        } else if words8 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
            print(4)
        } else if words9 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
            print(5)
        } else if words10 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
            print(6)
        }
        
        //Alex
        else if words1 == "Alex" {
            wordsArr = [words2, words3, words4, words5, words6, words7, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words2 == "Alex" {
            wordsArr = [words1, words3, words4, words5, words6, words7, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words3 == "Alex" {
            wordsArr = [words1, words2, words4, words5, words6, words7, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words4 == "Alex" {
            wordsArr = [words1, words2, words3, words5, words6, words7, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words5 == "Alex" {
            wordsArr = [words1, words2, words3, words4, words6, words7, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words6 == "Alex" {
            wordsArr = [words1, words2, words3, words4, words5, words7, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words7 == "Alex" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words8 == "Alex" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words9 == "Alex" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words10 == "Alex" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        }
        
        //Kathy
        else if words1 == "Kathy" {
            wordsArr = [words2, words3, words4, words5, words6, words7, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words2 == "Kathy" {
            wordsArr = [words1, words3, words4, words5, words6, words7, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words3 == "Kathy" {
            wordsArr = [words1, words2, words4, words5, words6, words7, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words4 == "Kathy" {
            wordsArr = [words1, words2, words3, words5, words6, words7, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words5 == "Kathy" {
            wordsArr = [words1, words2, words3, words4, words6, words7, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words6 == "Kathy" {
            wordsArr = [words1, words2, words3, words4, words5, words7, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words7 == "Kathy" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words8 == "Kathy" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words9 == "Kathy" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        } else if words10 == "Kathy" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
        }
        
        else {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9, words10]
            wordsArrRemoveDupe = wordsArrRemoveDupe.removeDuplicates(array: wordsArr)
            print(52)
        }
        
        if segue.identifier == "toDictionary" {
            //isReload = true
            let vc = segue.destination as? DictionaryViewController
            vc?.word = wordsArrRemoveDupe
            //vc?.defArr = defArr
            //vc?.synArr = synArr
            //vc?.exampleArr = exampleArr
            //print(wordsArr)
        }
        else if segue.identifier == "toCorrectAnswer" {
            //for passing data to ans screen
            //sleep(4)
            let vc = segue.destination as? AnswerViewController
            vc?.receiveEnglishSentence = textfield.text! + "."
            vc?.receiveImage = image
            vc?.receiveNum = randomNum
            vc?.receiveSentence = randomSentence
            vc?.receiveStar = getStar
            print("getStar: ", getStar)
            print("rstar: ", vc!.receiveStar)
        }
    }
    

}

extension Array where Element: Equatable {
    func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
                // Do not add a duplicate element.
            }
            else {
                // Add value to the set.
                encountered.insert(value)
                // ... Append the value.
                result.append(value)
            }
        }
        return result
    }
}
