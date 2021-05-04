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
    /*print("def: ", definitions)
    print("synn: ", synnonyms)
    print("example: ", sentenceExamples)*/
    var defArr = [String]()
    var synArr = [String]()
    var exampleArr = [String]()
    
    //var numbers = 0
    //var numbers1 = 0
    //var numbers2 = 0
    
    var wordsArr = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

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
        
        guard let path = Bundle.main.path(forResource: "English sentences(2)", ofType: "json") else {return}
                
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
                if ((number1 + number2) % 71) + 1 == tempInt{
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
    
    func retrieveDictionary() {
        
        var def = ""
        var synn = ""
        var ex = ""
        var vocab = ""
        guard let path = Bundle.main.path(forResource: "Englishsentences - Dictionary (1)", ofType: "json") else {return}
                
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
               /*if vocab == k {
                    print("word2:", word2)
                    def = i.1["definition"].stringValue
                    synn = i.1["synonym"].stringValue
                    ex = i.1["sentence_example"].stringValue
                    
                    definitions = def
                    synnonyms = synn
                    sentenceExamples = ex
                    print("def: ", definitions)
                    print("synn: ", synnonyms)
                    print("example: ", sentenceExamples)
                }*/
                        
                //self.dictionaryTableView.reloadData()
            }
        
        

            //vocab = json["vocabulary"].stringValue//.rawString()!
            //print("vocab:", vocab)
            //print("word1:", word1)
            
            
            /*for item in json {
                
                
                
                let vocab = item.1["vocabulary"]
                //let definition = item.1["definition"]
                //let synonym = item.1["synonym"]
                //let sentenceExample = item.1["sentence_example"]
                /*definitions = definition.rawString()!
                synnonyms = synonym.rawString()!
                sentenceExamples = sentenceExample.rawString()!*/
                
                vocabs = vocab.rawString()!.lowercased()
                //def = definition.stringValue
                //synn = synonym.stringValue
                //ex = sentenceExample.stringValue
                /*print("vocab: ", vocabs)
                print("def: ", definitions)
                print("synn: ", synnonyms)
                print("example: ", sentenceExamples)*/
                
                //print("word1", word1)
                
                vocabArr.append(vocabs)
                /*defArr.append(definitions)
                synArr.append(synnonyms)
                exampleArr.append(sentenceExamples)*/
                //print("word1:", word1)
                print("item.1:", item.1[])
                
                
                
            }
            for i in word1 {
                
                for j in vocabArr {
                    if i == j {
                        print("i:", i)
                        print("j:", j)
                        //def = definition[0].stringValue
                        //synn = synonym[0].stringValue
                        //ex = sentenceExample[0].stringValue
                        //print("def:", def)
                        //print("synn:", synn)
                        //print("ex:", ex)
                        
                        definitions = def
                        synnonyms = synn
                        sentenceExamples = ex
                        print("definitions:", definitions)
                        print("synnonyms:", synnonyms)
                        print("sentenceExamples", sentenceExamples)
                    }
                }
            }*/
        }
        catch {
            
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
        
        //MARK: To do - Check if human's name = no need to pass the data. Also check if it has the same word in the sentence = no need to pass that data.
        
        if words5 == "" {
            wordsArr = [words1, words2, words3, words4]
            print(1)
        } else if words6 == "" {
            wordsArr = [words1, words2, words3, words4, words5]
            print(2)
        } else if words7 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6]
            print(3)
        } else if words8 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7]
            print(4)
        } else if words9 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8]
            print(5)
        } else if words10 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
            print(6)
        }
        // word1
        /*else if words1 == words2 {
            wordsArr = [words1, words3, words4, words5, words6, words7, words8, words9, words10]
            print(7)
        } else if words1 == words2 && words5 == "" {
            wordsArr = [words1, words3, words4]
            print("sp7.1")
        } else if words1 == words2 && words6 == "" {
            wordsArr = [words1, words3, words4, words5]
            print("sp7.2")
        } else if words1 == words2 && words7 == "" {
            wordsArr = [words1, words3, words4, words5, words6]
            print("sp7.3")
        } else if words1 == words2 && words8 == "" {
            wordsArr = [words1, words3, words4, words5, words6, words7]
            print("sp7.4")
        } else if words1 == words2 && words9 == "" {
            wordsArr = [words1, words3, words4, words5, words6, words7, words8]
            print("sp7.5")
        } else if words1 == words2 && words10 == "" {
            wordsArr = [words1, words3, words4, words5, words6, words7, words8, words9]
            print("sp7.6")
        } else if words1 == words3 {
            wordsArr = [words1, words2, words4, words5, words6, words7, words8, words9, words10]
            print(8)
        } else if words1 == words3 && words5 == "" {
            wordsArr = [words1, words2, words4]
            print("sp8.1")
        } else if words1 == words3 && words6 == "" {
            wordsArr = [words1, words2, words4, words5]
            print("sp8.2")
        } else if words1 == words3 && words7 == "" {
            wordsArr = [words1, words2, words4, words5, words6]
            print("sp8.3")
        } else if words1 == words3 && words8 == "" {
            wordsArr = [words1, words2, words4, words5, words6, words7]
            print("sp8.4")
        } else if words1 == words3 && words9 == "" {
            wordsArr = [words1, words2, words4, words5, words6, words7, words8]
            print("sp8.5")
        } else if words1 == words3 && words10 == "" {
            wordsArr = [words1, words2, words4, words5, words6, words7, words8, words9]
            print("sp8.6")
        }  else if words1 == words4 {
            wordsArr = [words1, words2, words3, words5, words6, words7, words8, words9, words10]
            print(9)
        } else if words1 == words4 && words5 == "" {
            wordsArr = [words1, words2, words3]
            print("sp9.1")
        } else if words1 == words4 && words6 == "" {
            wordsArr = [words1, words2, words3, words5]
            print("sp9.2")
        } else if words1 == words4 && words7 == "" {
            wordsArr = [words1, words2, words3, words5, words6]
            print("sp9.3")
        } else if words1 == words4 && words8 == "" {
            wordsArr = [words1, words2, words3, words5, words6, words7]
            print("sp9.4")
        } else if words1 == words4 && words9 == "" {
            wordsArr = [words1, words2, words3, words5, words6, words7, words8]
            print("sp9.5")
        } else if words1 == words4 && words10 == "" {
            wordsArr = [words1, words2, words3, words5, words6, words7, words8, words9]
            print("sp9.6")
        } else if words1 == words5 {
            wordsArr = [words1, words2, words3, words4, words6, words7, words8, words9, words10]
            print(10)
        } else if words1 == words5 && words6 == "" {
            wordsArr = [words1, words2, words3, words4]
            print("sp10.1")
        } else if words1 == words5 && words7 == "" {
            wordsArr = [words1, words2, words3, words4, words6]
            print("sp10.2")
        } else if words1 == words5 && words8 == "" {
            wordsArr = [words1, words2, words3, words4, words6, words7]
            print("sp10.3")
        } else if words1 == words5 && words9 == "" {
            wordsArr = [words1, words2, words3, words4, words6, words7, words8]
            print("sp10.4")
        } else if words1 == words5 && words10 == "" {
            wordsArr = [words1, words2, words3, words4, words6, words7, words8, words9]
            print("sp10.5")
        } else if words1 == words6 {
            wordsArr = [words1, words2, words3, words4, words5, words7, words8, words9, words10]
            print(11)
        } else if words1 == words6 && words7 == "" {
            wordsArr = [words1, words2, words3, words4, words5]
            print("sp11.1")
        } else if words1 == words6 && words8 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words7]
            print("sp11.2")
        } else if words1 == words6 && words9 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words7, words8]
            print("sp11.3")
        } else if words1 == words6 && words10 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words7, words8, words9]
            print("sp11.4")
        }  else if words1 == words7 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words8, words9, words10]
            print(12)
        } else if words1 == words7 && words8 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6]
            print("sp12.1")
        } else if words1 == words7 && words9 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words8]
            print("sp12.2")
        } else if words1 == words7 && words10 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words8, words9]
            print("sp12.3")
        } else if words1 == words8 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words9, words10]
            print(13)
        } else if words1 == words8 && words9 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7]
            print("sp13.1")
        } else if words1 == words8 && words10 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words9]
            print("sp13.2")
        }  else if words1 == words9 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words10]
            print(14)
        } else if words1 == words9 && words10 == "" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8]
            print("sp13.2")
        } else if words1 == words10 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
            print(15)
        }
        // word2
        else if words2 == words3 {
            wordsArr = [words1, words2, words4, words5, words6, words7, words8, words9, words10]
            print(16)
        } else if words2 == words4 {
            wordsArr = [words1, words2, words3, words5, words6, words7, words8, words9, words10]
            print(17)
        } else if words2 == words5 {
            wordsArr = [words1, words2, words3, words4, words6, words7, words8, words9, words10]
            print(18)
        } else if words2 == words6 {
            wordsArr = [words1, words2, words3, words4, words5, words7, words8, words9, words10]
            print(19)
        } else if words2 == words7 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words8, words9, words10]
            print(20)
        } else if words2 == words8 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words9, words10]
            print(21)
        } else if words2 == words9 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words10]
            print(22)
        } else if words2 == words10 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
            print(23)
        }
        // word3
         else if words3 == words4 {
            wordsArr = [words1, words2, words3, words5, words6, words7, words8, words9, words10]
            print(24)
        } else if words3 == words5 {
            wordsArr = [words1, words2, words3, words4, words6, words7, words8, words9, words10]
            print(25)
        } else if words3 == words6 {
            wordsArr = [words1, words2, words3, words4, words5, words7, words8, words9, words10]
            print(26)
        } else if words3 == words7 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words8, words9, words10]
            print(27)
        } else if words3 == words8 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words9, words10]
            print(28)
        } else if words3 == words9 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words10]
            print(29)
        } else if words3 == words10 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
            print(30)
        }
        // word4
        else if words4 == words5 {
            wordsArr = [words1, words2, words3, words4, words6, words7, words8, words9, words10]
            print(31)
        } else if words4 == words6 {
            wordsArr = [words1, words2, words3, words4, words5, words7, words8, words9, words10]
            print(32)
        } else if words4 == words7 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words8, words9, words10]
            print(33)
        } else if words4 == words8 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words9, words10]
            print(34)
        } else if words4 == words9 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words10]
            print(35)
        } else if words4 == words10 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
            print(36)
        }
        // word5
        else if words5 == words6 {
            wordsArr = [words1, words2, words3, words4, words5, words7, words8, words9, words10]
            print(37)
        } else if words5 == words7 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words8, words9, words10]
            print(38)
        } else if words5 == words8 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words9, words10]
            print(39)
        } else if words5 == words9 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words10]
            print(40)
        } else if words5 == words10 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
            print(41)
        }
        // word6
        else if words6 == words7 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words8, words9, words10]
            print(42)
        } else if words6 == words8 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words9, words10]
            print(43)
        } else if words6 == words9 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words10]
            print(44)
        } else if words6 == words10 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
            print(45)
        }
        // word7
        else if words7 == words8 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words9, words10]
            print(46)
        } else if words7 == words9 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words10]
            print(47)
        } else if words7 == words10 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
            print(48)
        }
        // word8
        else if words8 == words9 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words10]
            print(49)
        } else if words8 == words10 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
            print(50)
        }
        // word9
        else if words9 == words10 {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
            print(51)
        }*/
        
        //Alex
        else if words1 == "Alex" {
            wordsArr = [words2, words3, words4, words5, words6, words7, words8, words9, words10]
        } else if words2 == "Alex" {
            wordsArr = [words1, words3, words4, words5, words6, words7, words8, words9, words10]
        } else if words3 == "Alex" {
            wordsArr = [words1, words2, words4, words5, words6, words7, words8, words9, words10]
        } else if words4 == "Alex" {
            wordsArr = [words1, words2, words3, words5, words6, words7, words8, words9, words10]
        } else if words5 == "Alex" {
            wordsArr = [words1, words2, words3, words4, words6, words7, words8, words9, words10]
        } else if words6 == "Alex" {
            wordsArr = [words1, words2, words3, words4, words5, words7, words8, words9, words10]
        } else if words7 == "Alex" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words8, words9, words10]
        } else if words8 == "Alex" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words9, words10]
        } else if words9 == "Alex" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words10]
        } else if words10 == "Alex" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
        }
        
        //Kathy
        else if words1 == "Kathy" {
            wordsArr = [words2, words3, words4, words5, words6, words7, words8, words9, words10]
        } else if words2 == "Kathy" {
            wordsArr = [words1, words3, words4, words5, words6, words7, words8, words9, words10]
        } else if words3 == "Kathy" {
            wordsArr = [words1, words2, words4, words5, words6, words7, words8, words9, words10]
        } else if words4 == "Kathy" {
            wordsArr = [words1, words2, words3, words5, words6, words7, words8, words9, words10]
        } else if words5 == "Kathy" {
            wordsArr = [words1, words2, words3, words4, words6, words7, words8, words9, words10]
        } else if words6 == "Kathy" {
            wordsArr = [words1, words2, words3, words4, words5, words7, words8, words9, words10]
        } else if words7 == "Kathy" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words8, words9, words10]
        } else if words8 == "Kathy" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words9, words10]
        } else if words9 == "Kathy" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words10]
        } else if words10 == "Kathy" {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9]
        }
        
        else {
            wordsArr = [words1, words2, words3, words4, words5, words6, words7, words8, words9, words10]
            print(52)
        }
        
        if segue.identifier == "toDictionary" {
            //isReload = true
            let vc = segue.destination as? DictionaryViewController
            vc?.word = wordsArr
            //vc?.defArr = defArr
            //vc?.synArr = synArr
            //vc?.exampleArr = exampleArr
            print(wordsArr)
        }
        else if segue.identifier == "toCorrectAnswer" {
            //for passing data to ans screen
            let vc = segue.destination as? AnswerViewController
            vc?.receiveEnglishSentence = textfield.text! + "."
            
        }
    }
    

}
