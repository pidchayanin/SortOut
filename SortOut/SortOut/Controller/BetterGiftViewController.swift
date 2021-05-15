//
//  BetterGiftViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 15/5/2564 BE.
//

import UIKit
import HandySwift

struct Task {
    var task: [String]
    var img: [String]
    var amountOfGift: [Int]
    var numberOfTask: [Int]
    var taskDone: [Int]
}

class BetterGiftViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var receivedImg: UIImageView!
    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coinImg: UIImageView!
    @IBOutlet weak var coinNumLabel: UILabel!
    @IBOutlet weak var starNumLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    
    let cellReuseIdentifier = "giftCell"
    
    var tasks = [Task]()
    
    let cellSpacingHeight: CGFloat = 20
    
    var stars = 0
    private var coins = 0
    var vocabSeen = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        starImg.image = UIImage(named: "star.png")
        coinImg.image = UIImage(named: "coin.png")
        
        starNumLabel.layer.backgroundColor = UIColor.darkGray.cgColor
        starNumLabel.layer.cornerRadius = 5
        starNumLabel.textColor = UIColor.white
        starNumLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        
        coinNumLabel.layer.backgroundColor = UIColor.darkGray.cgColor
        coinNumLabel.layer.cornerRadius = 5
        coinNumLabel.textColor = UIColor.white
        coinNumLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        
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
        
        retrieveData()
        addTask()
    }
    
    func addTask() {
        let task = ["First Game of the day", "Royalty user: log in to the game", "Diligent leaner: study 5 vocabulary", "Starter kit: first-time user"]
        let imageName = ["coin-reward.png", "coin-reward.png", "coin-reward.png", "coin-reward.png"]
        let amountGifts = [100, 100, 100, 100]
        let numOfTasks = [1, 1, 5, 1]
        let taskDone = [0, 0, 0, 0]
        
        /*if isAppAlreadyLaunchedOnce() == true {
            taskDone = [0, 0, vocabSeen, 1]
        }*/
        
        let addTask = Task(task: task, img: imageName, amountOfGift: amountGifts, numberOfTask: numOfTasks, taskDone: taskDone)
        tasks.append(addTask)
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard

        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    func retrieveData() {

        var coin = 0
        var star = 0
        var itemNums = 0
        
        do {
            let jsons = try loadJSON(withFilename: "ItemProp")
//            print(jsons!)
            guard let array = jsons as? [Any] else {return}
            for i in array {
                guard let num = i as? [String: Any] else { return }
//                print(num["itemNum"]!)
//                itemNums = num["itemNum"] as! Int
//                itemNames = num["itemName"] as! String
//                itemDescriptions = num["itemDescription"] as! String
//                itemPrices = num["itemPrice"] as! Int
                star = num["star"] as! Int
                coin = num["coin"] as! Int
                itemNums = num["itemNum"] as! Int
                starNumLabel.text = String(star)
                coinNumLabel.text = String(coin)
            }
            print("coins: ", coins)
            coin += coins
//            numFromPopUp = UserDefaults.standard.integer(forKey: "Key")
//            coinFromPopUp = UserDefaults.standard.integer(forKey: "coin")
//            print("coinFromPopUp: ", coinFromPopUp)
            
//            print("n", numFromPopUp)
//            print("i", itemNums)
//            itemNums += numFromPopUp
//            coins -= coinFromPopUp

//            let n = itemNums //+ numFromPopUp
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
            
            
            let check = try save(jsonObject: jsonObject, toFilename: "ItemProp")
            print("check: ", check)
            
//            if check == true {
//                //reset numFromPopUp to 0
////                UserDefaults.standard.removeObject(forKey: "Key")
////                UserDefaults.standard.removeObject(forKey: "coin")
//            }
            
//            print("n1", numFromPopUp)
//            print("i1", itemNums)
//
//            itemNums = n

//            print("top2: ", itemNums)
//            print("coins: ", coins)

        }
        catch {
            
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
    
    override func viewWillAppear(_ animated: Bool) {
        coins = 0
        retrieveData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        self.tabBarController?.delegate = self
//    }

}

extension BetterGiftViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var task = 0
        for t in tasks {
            task = t.task.count
        }
        return task
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:GiftTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! GiftTableViewCell
        
        vocabSeen = UserDefaults.standard.integer(forKey: "seeVocab")
        print("vocabSeen: ", vocabSeen)
        let firstGame = UserDefaults.standard.integer(forKey: "firstGame")
        let logIn = UserDefaults.standard.integer(forKey: "logIn")
        let dateToday = UserDefaults.standard.string(forKey: "currentDate")
        let currentDate = Date()
        /*let calendar = Calendar.current
        let day = calendar.dateComponents([.day], from: currentDate)*/
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let strDate = df.string(from: currentDate)
        
        
        var taskName = ""
        var imgName = ""
        var giftAmount = 0
        var taskNum = 0
        var taskDone = 0
        for var t in tasks {
            
            if firstGame == t.numberOfTask[0] {
                t.taskDone[0] = firstGame
                //UserDefaults.standard.removeObject(forKey: "firstGame")
            }
            if logIn == t.numberOfTask[1] {
                t.taskDone[1] = logIn
                //UserDefaults.standard.removeObject(forKey: "logIn")
            }
            if vocabSeen == t.numberOfTask[2] {
                t.taskDone[2] = vocabSeen
                //UserDefaults.standard.removeObject(forKey: "seeVocab")
            }
            if isAppAlreadyLaunchedOnce() == false {
                t.taskDone[3] = 1
            } /*else if isAppAlreadyLaunchedOnce() == true {
                cell.contentView.alpha = 0.3
                cell.collectButton.isHidden = true
                cell.collectButton.isEnabled = false
                cell.inProgressLabel.isHidden = true
                cell.checkImg.isHidden = false
                t.taskDone[3] = 1
            }*/
            
            taskName = t.task[indexPath.section]
            imgName = t.img[indexPath.section]
            giftAmount = t.amountOfGift[indexPath.section]
            taskNum = t.numberOfTask[indexPath.section]
            taskDone = t.taskDone[indexPath.section]
        }
        
        cell.taskLabel.text = taskName
        cell.coinImg.image = UIImage(named: imgName)
        cell.numberOfTaskLabel.text = String(taskNum)
        cell.taskDoneLabel.text = String(taskDone)
        cell.numberOfgiftLabel.text = String(giftAmount)
        cell.backSlashLabel.text = "/"
        
        
        cell.collectButton.isHidden = true
        cell.collectButton.isEnabled = false
        
        if taskDone == taskNum {
            cell.inProgressLabel.isHidden = true
            
            cell.collectButton.isHidden = false
            cell.collectButton.isEnabled = true
        }
        
        cell.collectButtonAction = { [unowned self] in
            cell.contentView.alpha = 0.3
            cell.collectButton.isEnabled = false
            cell.collectButton.isHidden = true
            cell.checkImg.isHidden = false
            
            coins = giftAmount

            retrieveData()
            receivedImg.isHidden = false
            UIView.animate(withDuration: 2, animations: {
                self.receivedImg.alpha = 1
            }, completion:  nil)
            
            UIView.animate(withDuration: 2, animations: {
                 self.receivedImg.alpha = 0
            }, completion:  {
               (value: Bool) in
                   self.receivedImg.isHidden = true
            })
        }
        
        
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        
        if strDate != dateToday {
            let userDefault = UserDefaults.standard
            userDefault.removeObject(forKey: "seeVocab")
            userDefault.removeObject(forKey: "firstGame")
            userDefault.removeObject(forKey: "logIn")
        }
        
        return cell
    }
    
}
