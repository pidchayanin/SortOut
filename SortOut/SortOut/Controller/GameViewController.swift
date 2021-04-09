//
//  GameViewController.swift
//  SortOut
//
//  Created by Pidchayanin Chutipattana on 21/2/2564 BE.
//

import UIKit
import SwiftyJSON

class GameViewController: UIViewController {
    
    @IBOutlet weak var word1Button: UIButton!
    @IBOutlet weak var word2Button: UIButton!
    @IBOutlet weak var word3Button: UIButton!
    @IBOutlet weak var word4Button: UIButton!
    @IBOutlet weak var word5Button: UIButton!
    @IBOutlet weak var word6Button: UIButton!
    @IBOutlet weak var word7Button: UIButton!
    @IBOutlet weak var word8Button: UIButton!
    
    @IBOutlet weak var wordTapped1: UIButton!
    @IBOutlet weak var wordTapped2: UIButton!
    @IBOutlet weak var wordTapped3: UIButton!
    @IBOutlet weak var wordTapped4: UIButton!
    @IBOutlet weak var wordTapped5: UIButton!
    @IBOutlet weak var wordTapped6: UIButton!
    @IBOutlet weak var wordTapped7: UIButton!
    @IBOutlet weak var wordTapped8: UIButton!
    
    var words1 = ""
    var words2 = ""
    var words3 = ""
    var words4 = ""
    var words5 = ""
    var words6 = ""
    var words7 = ""
    var words8 = ""
    
    var numbers = 0
    var numbers1 = 0
    var numbers2 = 0

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
        
        wordTapped1.layer.borderWidth = 1
        wordTapped2.layer.borderWidth = 1
        wordTapped3.layer.borderWidth = 1
        wordTapped4.layer.borderWidth = 1
        wordTapped5.layer.borderWidth = 1
        wordTapped6.layer.borderWidth = 1
        wordTapped7.layer.borderWidth = 1
        wordTapped8.layer.borderWidth = 1
//        let number1 = numbers1
//        let number2 = numbers2
//        var tempInt = 0
//
//        tempInt += numbers
//
//        if ((number1 + number2) % 9) + 1 == tempInt{
//            print("tempInt: ", tempInt)
        if words1 == "null"{
            word1Button.isHidden = true
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
        }
        if words2 == "null"{
            word2Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
        }
        if words3 == "null"{
            word3Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
        }
        if words4 == "null"{
            word4Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
        }
        if words5 == "null"{
            word5Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
        }
        if words6 == "null"{
            word6Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word7Button.setTitle(words7, for: .normal)
            word8Button.setTitle(words8, for: .normal)
        }
        if words7 == "null" {
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
        }
        if words8 == "null"{
            word8Button.isHidden = true
            word1Button.setTitle(words1, for: .normal)
            word2Button.setTitle(words2, for: .normal)
            word3Button.setTitle(words3, for: .normal)
            word4Button.setTitle(words4, for: .normal)
            word5Button.setTitle(words5, for: .normal)
            word6Button.setTitle(words6, for: .normal)
            word7Button.setTitle(words7, for: .normal)
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
        }
        //}
        
        
    }
    
    func retreiveData() {
        var tempStr = ""
        let number1 = Int.random(in: 0 ..< 20)
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
            
            for item in array {
                
                let number = item.1["number"]
                let word1 = item.1["sentence1"][0]
                let word2 = item.1["sentence1"][1]
                let word3 = item.1["sentence1"][2]
                let word4 = item.1["sentence1"][3]
                let word5 = item.1["sentence1"][4]
                let word6 = item.1["sentence1"][5]
                let word7 = item.1["sentence1"][6]
                let word8 = item.1["sentence1"][7]
                
                //print(number)
                
                tempStr = number.rawString()!
                
                
                tempInt += 1
//                print(tempInt)
//                print("======")
//                print(number1)
//                print("======")
//                print(number2)
                
                // %9 is not confirmed rng 1 and 2, too
                if ((number1 + number2) % 9) + 1 == tempInt{
                    numbers1 = number1
                    numbers2 = number2
//                    print("temp: ", tempStr)
//                    print("======")
                    
                    tempInt1 = Int(tempStr)!
                    numbers = tempInt1
                    print("numbers: ", numbers)
//                    print("Int: ", tempInt1)
                    if word7.isEmpty == true {
                        words7 = "null"
                    }
                    else if word8.isEmpty == true {
                        words8 = "null"
                    }
                    else if word6.isEmpty == true {
                        words6 = "null"
                    }
                    else if word5.isEmpty == true {
                        words5 = "null"
                    }
                    else if word4.isEmpty == true {
                        words4 = "null"
                    }
                    else if word3.isEmpty == true {
                        words3 = "null"
                    }
                    else if word2.isEmpty == true {
                        words2 = "null"
                    }
                    else if word1.isEmpty == true {
                        words1 = "null"
                    }
                    words1 = word6.rawString()!
                    words2 = word5.rawString()!
                    words3 = word3.rawString()!
                    words4 = word2.rawString()!
                    words5 = word1.rawString()!
                    words6 = word7.rawString()!
                    words7 = word8.rawString()!
                    words8 = word4.rawString()!
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
    
    @IBAction func word1Tapped(_ sender: Any) {
        wordTapped1.isHidden = false
        wordTapped1.setTitle(words1, for: .normal)
        word1Button.isHidden = true
    }
    
    @IBAction func word2Tapped(_ sender: Any) {
        if wordTapped1.isHidden == true {
            wordTapped1.isHidden = false
            wordTapped1.setTitle(words2, for: .normal)
            word2Button.isHidden = true
        }
        else{
//            wordTapped1.isHidden = true
            wordTapped1.setTitle(words1, for: .normal)
//            word2Button.isHidden = true
        }
//        wordTapped2.isHidden = false
//        wordTapped2.setTitle(words2, for: .normal)
    }
    
    @IBAction func word3Tapped(_ sender: Any) {
        wordTapped3.isHidden = false
        wordTapped3.setTitle(words3, for: .normal)
    }
    
    @IBAction func word4Tapped(_ sender: Any) {
        wordTapped4.isHidden = false
        wordTapped4.setTitle(words4, for: .normal)
    }
    
    @IBAction func word5Tapped(_ sender: Any) {
        wordTapped5.isHidden = false
        wordTapped5.setTitle(words5, for: .normal)
    }
    
    @IBAction func word6Tapped(_ sender: Any) {
        wordTapped6.isHidden = false
        wordTapped6.setTitle(words6, for: .normal)
    }
    
    @IBAction func word7Tapped(_ sender: Any) {
        wordTapped7.isHidden = false
        wordTapped7.setTitle(words7, for: .normal)
    }
    
    @IBAction func word8Tapped(_ sender: Any) {
        wordTapped8.isHidden = false
        wordTapped8.setTitle(words8, for: .normal)
    }
    
    //Navigation: Below is the button for words that are on textfield
    
    @IBAction func tapWord1(_ sender: Any) {
        wordTapped1.isHidden = true
//        wordTapped1.setTitle(words1, for: .normal)
        word1Button.isHidden = false
        word2Button.isHidden = false
    }
    
    @IBAction func tapWord2(_ sender: Any) {
        if wordTapped1.isHidden == false {
            wordTapped1.isHidden = true
//            wordTapped1.setTitle(words2, for: .normal)
        }
        else{
//            wordTapped1.isHidden = true
            wordTapped1.setTitle(words1, for: .normal)
        }
//        wordTapped2.isHidden = false
//        wordTapped2.setTitle(words2, for: .normal)
    }
    
    @IBAction func tapWord3(_ sender: Any) {
        wordTapped3.isHidden = false
        wordTapped3.setTitle(words3, for: .normal)
    }
    
    @IBAction func tapWord4(_ sender: Any) {
        wordTapped4.isHidden = false
        wordTapped4.setTitle(words4, for: .normal)
    }
    
    @IBAction func tapWord5(_ sender: Any) {
        wordTapped5.isHidden = false
        wordTapped5.setTitle(words5, for: .normal)
    }
    
    @IBAction func tapWord6(_ sender: Any) {
        wordTapped6.isHidden = false
        wordTapped6.setTitle(words6, for: .normal)
    }
    
    @IBAction func tapWord7(_ sender: Any) {
        wordTapped7.isHidden = false
        wordTapped7.setTitle(words7, for: .normal)
    }
    
    @IBAction func tapWord8(_ sender: Any) {
        wordTapped8.isHidden = false
        wordTapped8.setTitle(words8, for: .normal)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        //ToDo: Make condition that if the button is null so .isHidden = true
        
        word1Button.isHidden = false
        word2Button.isHidden = false
        word3Button.isHidden = false
        word4Button.isHidden = false
        word5Button.isHidden = false
        word6Button.isHidden = false
        word7Button.isHidden = false
        word8Button.isHidden = false
        
        wordTapped1.isHidden = true
        wordTapped2.isHidden = true
        wordTapped3.isHidden = true
        wordTapped4.isHidden = true
        wordTapped5.isHidden = true
        wordTapped6.isHidden = true
        wordTapped7.isHidden = true
        wordTapped8.isHidden = true
    }
   
    @IBAction func showGameSettingPopUp(_ sender: Any) {
        //noted: Main as in Main.storyboard
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameSettingPopUpID") as! GameSettingPopUpViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
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
