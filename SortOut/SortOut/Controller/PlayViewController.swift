//
//  PlayViewController.swift
//  SortOut
//
//  Created by Pidchayanin Chutipattana on 25/2/2564 BE.
//

import UIKit
import UserNotifications
import CoreData

private func firstDayOfMonth(date: Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    return calendar.date(from: components)!
}

class PlayViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var coinImg: UIImageView!
    @IBOutlet weak var starNumLabel: UILabel!
    @IBOutlet weak var coinNumLabel: UILabel!
    
    let cellReuseIdentifier = "historyCell"
    let cellSpacingHeight: CGFloat = 20
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var historyCD: [HistoryCD] = []
    
    var sections = [HistorySection<Date, HistoryCD>]()
    
    var coins = Int()
    var star = Int()
    
    let currentDate = Date()
    
    let gameViewID = "FirstGameID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starImg.image = UIImage(named: "star.png")
        coinImg.image = UIImage(named: "coin.png")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
        
        historyView.layer.cornerRadius = 10
        
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(true, forKey: "true")
        userDefaults.setValue(false, forKey: "false")
        
        fetchData()
        sort()
        
        self.sections = HistorySection.group(rows: self.historyCD, by: { firstDayOfMonth(date: $0.date!) })
        self.sections.sort { lhs, rhs in lhs.sectionItem > rhs.sectionItem }
        
        retrieveData()
        
        let dateToday = Date()
        /*let calendar1 = Calendar.current
        let compo = calendar1.dateComponents([.day], from: dateToday)*/
//        let df = DateFormatter()
//        df.dateFormat = "dd/MM/yyyy"
//        let str = df.string(from: dateToday)
        
        UserDefaults.standard.setValue(1, forKey: "logIn")
        UserDefaults.standard.setValue(dateToday, forKey: "currentDate")
        self.view.backgroundColor = .white
        
        // step 1: Ask for permission
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("O' oh!")
            }
        }
        
        // step 2: Create the notification content
        let content = UNMutableNotificationContent()
        content.title = "Hey! It's time for SortOut!"
        content.body = "Just a quick reminder, Knowing English might increase your chances of getting a job after college :)"
        
        // step 3: trigger
        
        let getTime = UserDefaults.standard.string(forKey: "time")
        print("getTime: ", getTime ?? "")
        let dateAsString = getTime ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        guard let date = dateFormatter.date(from: dateAsString) else { return }
        
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: date)
        print("date24: ", date24)
        
        var dateComponents = DateComponents()
        
        let hour = date24.components(separatedBy: ":")
        //10 o'clock
        dateComponents.hour = Int(hour[0])
        //30 minutes
        dateComponents.minute = Int(hour[1])
        //everyday
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        
        //let date = Date().addingTimeInterval(10)
        //let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        
        // step 4: Create the request
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // step 5: Register the request
        center.add(request) { (error) in
            //Check the error parameter and handle any error
        }
//        local notification
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))

        // Do any additional setup after loading the view.
        
        
    }
    
//
//    //Local notification- request permission from the user
//    @objc func registerLocal() {
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
//            if granted {
//                print("Yay!")
//            } else {
//                print("O' oh!")
//            }
//        }
//    }
//
//    @objc func scheduleLocal() {
//        let center = UNUserNotificationCenter.current()
//
//        center.removeAllPendingNotificationRequests()
//
//        let content = UNMutableNotificationContent()
//        content.title = "Late wake up call"
//        content.body = "The early bird catches the worm, but the second mouse get the cheese"
//        content.categoryIdentifier = "alarm"
//        content.userInfo = ["customer": "fizzbuzz"]
//        content.sound = .default
//
//        //trigger notification
//        var dateComponents = DateComponents()
//        //10 o'clock
//        dateComponents.hour = 10
//        //30 minutes
//        dateComponents.minute = 30
//        //everyday
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        center.add(request)
//
//    }
    
    func fetchData() {
        do {
            self.historyCD = try context?.fetch(HistoryCD.fetchRequest()) as! [HistoryCD]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("context fetch")
            print("=============")
        }
        catch {
            print("fetch error: ", error)
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
    
    func sort() {
        historyCD.sort(by: { $0.date! > $1.date! })
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coins = 0
        retrieveData()
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard

        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "firstPlay"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "firstPlay")
            print("App launched first time")
            return false
        }
    }
    
    @IBAction func playTapped(_ sender: Any) {
        if self.isAppAlreadyLaunchedOnce() == false {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: gameViewID)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true, completion: nil)
        }
        else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "gameViewID")
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    //    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        self.tabBarController?.delegate = self
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return self.sections.count
        return self.historyCD.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let historySection = sections[section]
        //return historySection.rows.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        //headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let sectionn = self.sections[section]
//        let date = sectionn.sectionItem
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd MMMM yyyy"
//        return dateFormatter.string(from: date)
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlayTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! PlayTableViewCell
        
        //var historySection = self.sections[indexPath.section]
        //let displayItems = historySection.rows[indexPath.row]
        let displayItems = historyCD[indexPath.section]
//        let date = displayItems.date
//        let calendar = Calendar.current
//        let minutes = calendar.component(.minute, from: date!)
        
        cell.engSentenceLabel.text = displayItems.englishSentence ?? ""
        
        cell.thSentenceLabel.text = displayItems.thaiSentence ?? ""
        
        cell.starImage.image = UIImage(named: (displayItems.receivedStar ?? ""))
        
        //cell.backgroundColor = UIColor.white
        //cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        cell.layer.shadowOffset = CGSize(width: 20, height: 20)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.23
        cell.layer.shadowRadius = 4
        
        // Does not work! SO TIRED
        //historySection.rows.sort { _,_ in minutes > minutes }
        
        //cell.contentView.backgroundColor = .white
        return cell
    }
    
    
}
