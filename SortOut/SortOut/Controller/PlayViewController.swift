//
//  PlayViewController.swift
//  SortOut
//
//  Created by Pidchayanin Chutipattana on 25/2/2564 BE.
//

import UIKit

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
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var historyCD: [HistoryCD] = []
    
    var sections = [HistorySection<Date, HistoryCD>]()
    
    var coins = Int()
    var star = Int()
    
    let currentDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateToday = Date()
        /*let calendar1 = Calendar.current
        let compo = calendar1.dateComponents([.day], from: dateToday)*/
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let str = df.string(from: dateToday)
        
        UserDefaults.standard.setValue(1, forKey: "logIn")
        UserDefaults.standard.setValue(str, forKey: "currentDate")

        // Do any additional setup after loading the view.
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
        
        fetchData()
        
        self.sections = HistorySection.group(rows: self.historyCD, by: { firstDayOfMonth(date: $0.date!) })
        self.sections.sort { lhs, rhs in lhs.sectionItem > rhs.sectionItem }
        
        retrieveData()
        
    }
    
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
                starNumLabel.text = String(star)
                coinNumLabel.text = String(coin)
            }
            
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
                    "itemNum": 0
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
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let historySection = sections[section]
        return historySection.rows.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionn = self.sections[section]
        let date = sectionn.sectionItem
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlayTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! PlayTableViewCell
        
        var historySection = self.sections[indexPath.section]
        let displayItems = historySection.rows[indexPath.row]
        let date = displayItems.date
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date!)
        
        cell.engSentenceLabel.text = displayItems.englishSentence ?? ""
        
        cell.thSentenceLabel.text = displayItems.thaiSentence ?? ""
        
        cell.starImage.image = UIImage(named: (displayItems.receivedStar ?? ""))
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        
        // Does not work! SO TIRED
        historySection.rows.sort { _,_ in minutes > minutes }
        
        return cell
    }
    
    
}
