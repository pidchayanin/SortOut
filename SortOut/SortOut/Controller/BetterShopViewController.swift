//
//  BetterShopViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 27/4/2564 BE.
//

import UIKit

class BetterShopViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITabBarControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var starNumLabel: UILabel!
    @IBOutlet weak var coinNumLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var topStarImg: UIImageView!
    @IBOutlet weak var topCoinImg: UIImageView!
    
//    var itemList: ItemProp!
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let cellSpacingHeight: CGFloat = 20
    let cellReuseIdentifier = "shopCell"
    
    var itemNames = String()
    var itemDescriptions = String()
    var itemPrices = Int()
    var itemNums = Int()
    var coins = Int()
    var numFromPopUp = Int()
    var coinFromPopUp = Int()
    
    let itemImageName = [UIImage(named: "retry-item.png")]
    let coinImageName = [UIImage(named: "coin.png")]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        print("inN", numFromPopUp)
        tableView.delegate = self
        tableView.dataSource = self
        

        DataManager.shared.firstVC = self
        
        topStarImg.image = UIImage(named: "star.png")
        topCoinImg.image = UIImage(named: "coin.png")
        
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
            if checkInit == true {
                
                itemNames = "RETRY"
                itemDescriptions = "Use this to try again when your answer is incorrect."
                itemPrices = 100
                //itemNums = n
                starNumLabel.text = "0"
                coinNumLabel.text = "1000"
            }
        }
        catch {
            
        }
        
        retrieveData()
 
    }
        
    func retrieveData() {
        var stars = 0
        do {
            let jsons = try loadJSON(withFilename: "ItemProp")
//            print(jsons!)
            guard let array = jsons as? [Any] else {return}
            for i in array {
                guard let num = i as? [String: Any] else { return }
                print(num["itemNum"]!)
                itemNums = num["itemNum"] as! Int
                itemNames = num["itemName"] as! String
                itemDescriptions = num["itemDescription"] as! String
                itemPrices = num["itemPrice"] as! Int
                stars = num["star"] as! Int
                coins = num["coin"] as! Int
                starNumLabel.text = String(stars)
                coinNumLabel.text = String(coins)
            }
            
            numFromPopUp = UserDefaults.standard.integer(forKey: "Key")
            coinFromPopUp = UserDefaults.standard.integer(forKey: "coin")
            print("coinFromPopUp: ", coinFromPopUp)
            
            print("n", numFromPopUp)
            print("i", itemNums)
            itemNums += numFromPopUp
            coins -= coinFromPopUp

            let c = coins
            let n = itemNums //+ numFromPopUp
            let jsonObject: [Any]  = [
                [
                    "star": stars,
                    "coin": c,
                    "itemName": "RETRY",
                    "itemDescription": "Use this to try again when your answer is incorrect.",
                    "itemPrice": 100,
                    "itemNum": n
                ]
            ]
            
            
            let check = try save(jsonObject: jsonObject, toFilename: "ItemProp")
            print("check: ", check)
            
            if check == true {
                //reset numFromPopUp to 0
                UserDefaults.standard.removeObject(forKey: "Key")
                UserDefaults.standard.removeObject(forKey: "coin")
            }
            
            print("n1", numFromPopUp)
            print("i1", itemNums)
            
            itemNums = n
            coins = c
            coinNumLabel.text = String(coins)
 
            print("-------------")

            print("top2: ", itemNums)
            print("coins: ", coins)

            self.tableView.reloadData()

        }
        catch {
            
        }
        
        self.tableView.reloadData()
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
    
    
    @IBAction func buyTapped(_ sender: Any) {
        
        if coins <= 0 {
            let alert = UIAlertController(title: "You do not have enough coins", message: "Get more coins first!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                print("Tap OK")
          }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BuyItemPopUpID") as? BetterBuyItemPopUpViewController
                    
            popOverVC?.modalPresentationStyle = .popover
            
            let button = sender as? UIButton
            let buttonFrame = button?.frame ?? CGRect.zero
            
            if let popoverPresentationController = popOverVC?.popoverPresentationController {
                //popoverPresentationController.permittedArrowDirections = .up
                popoverPresentationController.sourceView = self.view
                popoverPresentationController.sourceRect = buttonFrame //CGRect(x: 0,y: 0,width: 50,height: 50)
                popoverPresentationController.delegate = self
                if let popoverController = popOverVC {
                    present(popoverController, animated: true, completion: nil)
                    }
            }
        }
        
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .overFullScreen
    }

    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {

    }

    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        self.tabBarController?.delegate = self
//    }

}

extension BetterShopViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //itemCD.count //itemCount.count
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
        
        let cell:BetterShopTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! BetterShopTableViewCell
        
        print("Notice me senpai!")
        
//        let retryItem = itemCD[indexPath.row]
        
//        itemNums = Int(retryItem.itemNum + Int64(numFromPopUp))
//        itemNames = "Retry"
//        itemDescriptions = "This item is using for something"
//        itemPrices = 100
        
       // retryItem.itemNum = itemNums
//        print("name", retryItem.itemName!)
//        print("description", retryItem.itemDescription!)
//        print("price", retryItem.itemPrice)
//
        cell.itemNameLabel.text = itemNames//retryItem.itemName
        cell.itemDescriptionLabel.text = itemDescriptions//retryItem.itemDescription
        cell.itemPriceLabel.text = String(itemPrices)//String(retryItem.itemPrice)
        cell.itemNumLabel.text = String(itemNums)//String(retryItem.itemNum)
        cell.itemImage.image = self.itemImageName[indexPath.row]
        cell.coinImage.image = self.coinImageName[indexPath.row]
        

//
//        print(retryItem.itemNum)
//        print(itemNums)
//        print(cell.itemNumLabel.text!)
//        print("count", itemCD.count)
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        
//        try! context.save()
//        DispatchQueue.main.async {
        //(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            //self.tableview.reloadData()
//        }
        //tableView.reloadData()
        return cell
    }
}
