//
//  ShopViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 18/2/2564 BE.
//

import UIKit
import CoreData


class ShopViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var itemCount:[Item] = []
    var coinCount:[Coin] = []
    //var itemCount:[Int64] = []
    var itemString: [String] = []
    var itemDescriptionString: [String] = []
    var itemPriceString: [String] = []
    
    let buyPopUpView = BuyItemPopUpViewController()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    
    //let items = ["RETRY"]
    //let itemDescriptions = ["Use this to try again when your answer is incorrect."]
    //let itemPrices = ["100"]
    let itemNumber = [0]
    let cellReuseIdentifier = "shopCell"
    let itemImageName = [UIImage(named: "insta.jpeg")]
    let coinImageName = [UIImage(named: "insta.jpeg")]
    let cellSpacingHeight: CGFloat = 20
    var stars: Stars = Stars()
    //var coins: Coins = Coins()
    var retryItem: RetryItem = RetryItem()
    
    var retryItemText: [String] = []
    var starText = ""
    var coinText = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
//        screenNameLabel.text = "Useful Items"
        stars.star = 10
        starText = "\(stars.star)"
        starsLabel.text = starText
        //coins.coin = 1000
        //coinText = "\(coins.coin)"
        //coinsLabel.text = coinText

        //fetchNumberOfItem()
        addItem()
        addCoin()
        fetchItem()
    }
    
    func fetchItem() {
        
        // Fetch the data from Core Data to display in the tableview
        do {
            self.itemCount = try context.fetch(Item.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("Item Fetched")
            print("-------")
            
        } catch {
            
        }
        
    }
    
    func addItem() {
        //guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let retryItem = Item.init(context: context)
        retryItem.items = "RETRY"
        retryItem.itemDescriptions = "Use this to try again when your answer is incorrect."
        retryItem.itemPrices = 100
        //retryItem.itemNum = 0
        
        retryItemText = [String(retryItem.itemNum)]
        
        try! context.save()
        
    }
    
    func addCoin() {
        //guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let coinNumber = Coin.init(context: context)
        //coinNumber.coinNum = 1000
        //coinText = String(coinNumber.coinNum)
        //coinsLabel.text = coinText

        //print(coinText)

        print("----------")
        if coinCount.count == 0 {
            coinCount.append(coinNumber)
        }
        
        
        try! context.save()
    }
    
    /*func fetchNumberOfItem() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
         else {
            return
         }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        // Fetch number of retry item from core data
        /*do {
            self.itemCount = try manageContext.fetch(ItemCount.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        catch {
            
        }*/
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "ItemCount")
          
          //3
          do {
            itemCount = try manageContext.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        
    }*/
    
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BuyItemPopUpID") as? BuyItemPopUpViewController
        
        let button = sender as? UIButton
        let buttonFrame = button?.frame ?? CGRect.zero
        
        popOverVC?.modalPresentationStyle = .popover
        //popOverVC?.preferredContentSize = CGSize(width: 200, height: 100)
//        self.addChild(popOverVC!)
//        popOverVC?.view.frame = self.view.frame
//        self.view.addSubview(popOverVC!.view)
//        popOverVC?.didMove(toParent: self)
        
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
    
    
    //UIPopoverPresentationControllerDelegate inherits from UIAdaptivePresentationControllerDelegate, we will use this method to define the presentation style for popover presentation controller
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .overFullScreen
    }

    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {

    }

    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    @objc func didTapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

   /* override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          
          //1
          guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "ItemCount")
          
          //3
          do {
            itemCount = try managedContext.fetch(fetchRequest)
            print("Context fetched")
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
    }
    
    
    func save(itemNum: Int64) {
      
          guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
          }
          
          // 1
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          // 2
          let entity =
            NSEntityDescription.entity(forEntityName: "ItemCount",
                                       in: managedContext)!
          
          let itemRetryNum = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
          
          // 3
          itemRetryNum.setValue(itemNum, forKeyPath: "itemNum")
          
          // 4
          do {
            try managedContext.save()
            //itemCount.append(itemRetryNum)
           /* if itemCount.count == 0{
                itemCount.append(itemRetryNum)
            }
            itemCount[0] = itemRetryNum*/
            print("Context saved")
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
    }*/

    
    
    /* func buyItems() {
        
        
        // itemRetryNum.itemNum = 20
        retryItemText = ["\(itemRetryNum.itemNum)"]
        
        // save data
        
        
//        retryItem.retryItemCount = 20
//        retryItemText = ["\(retryItem.retryItemCount)"]
//        numberOfItemLabel.text = retryItemText
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //itemCount.count
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
        let cell:ShopTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ShopTableViewCell
        
        //addItem()
        //addCoin()
        
        //print(itemCount.count)
        //self.retryItem.retryItemCount = 0
        
        
        
        //let retryItemCount = self.retryItem.retryItemCount
        //retryItemText = [String(retryItemCount)]
        
//        print(retryItemText, "1st")
//        print("---------")
        
//        let retryItem = ItemCount.init(context: context)
//        retryItem.items = "RETRY"
//        retryItem.itemDescriptions = "Use this to try again when your answer is incorrect."
//        retryItem.itemPrices = 100
//
//        retryItem.itemNum = 0
//        retryItemText = [String(retryItem.itemNum)]
//
//        try! context.save()
        
        //maybe parse JSON instead

        let itemRetryCount = self.itemCount[indexPath.row]
        //let coinNumCount = Coin.init(context: context)
        itemRetryCount.itemNum += Int64(buyPopUpView.numOfItemCount)
        
        let coinNumCount = coinCount[0]
        print("coinCount.count = ", coinCount.count, coinCount[0])
//        if coinNumCount.coinNum == 0 {
//            coinNumCount.coinNum += 1000
//            try! context.save()
//        }
        //coinNumCount.coinNum = coinCount[0].coinNum
        
        coinText = String(coinNumCount.coinNum)
        coinsLabel.text = coinText
        print(coinText)
        //itemRetryCount.setPrimitiveValue(0, forKey: "itemNum")
        //itemRetryCount.itemNum = Int64(retryItemCount)
        
        //var itemNumber = itemRetryCount.itemNum
        
        //retryItemText = [String(itemNumber)]
        retryItemText = [String(itemRetryCount.itemNum)]
        
        //print("ItemNum: ", itemNumber)
        print("ItemNum: ", itemRetryCount.itemNum)
        
        //print(retryItemText, "1st")
        //print("---------")
//
//
//
//        itemRetryCount.items = "RETRY"
//        itemRetryCount.itemDescriptions = "Use this to try again when your answer is incorrect."
//        itemRetryCount.itemPrices = 100
        
        
        itemString = [itemRetryCount.items!]
//        itemString = [retryItem.items!]
//        itemDescriptionString = [retryItem.itemDescriptions!]
//        itemPriceString = [String(retryItem.itemPrices)]
        itemDescriptionString = [itemRetryCount.itemDescriptions!]
        itemPriceString = [String(itemRetryCount.itemPrices)]
        
        cell.itemNameLabel.text = itemString[indexPath.section]
        cell.itemDescriptionLabel.text = itemDescriptionString[indexPath.section]
        cell.priceLabel.text = itemPriceString[indexPath.section]
        cell.itemImage.image = self.itemImageName[indexPath.section]
        cell.coinImage.image = self.coinImageName[indexPath.section]
        cell.numberOfItemLabel.text = retryItemText[indexPath.section]
        
        /*cell.buyButtonAction = { [unowned self] in
            let item = self.itemString[indexPath.section]
            let alert = UIAlertController(title: "Collect!", message: "Collect coins from \(item)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {(ACTION) in itemRetryCount.itemNum += 1
                //itemNumber = itemRetryCount.itemNum
                //print("ItemNum2: ", itemNumber)
                print("ItemNum2: ", itemRetryCount.itemNum)
//                if itemRetryCount.isUpdated == true {
//                    coinNumCount.coinNum -= 100
//                    try! context.save()
//                }
                coinNumCount.coinNum -= 100
                print("Decreased coin", coinNumCount.coinNum)
                coinText = String(coinNumCount.coinNum)
                coinsLabel.text = coinText
                
                //coinCount.append(coinNumCount)
//                if coinNumCount.coinNum != coinCount[0].coinNum {
//                    coinCount[0].coinNum = coinNumCount.coinNum
//                }
                print("This is remaining coin = ", coinText)
                
                print("----------")
                
//                if coinCount.count == 1 {
//                    coinCount[0] = coinNumCount
//                }
                
                //retryItemText = [String(itemNumber)]
                retryItemText = [String(itemRetryCount.itemNum)]
                cell.numberOfItemLabel.text = retryItemText[indexPath.section]
                
                //coinsLabel.text = "\(coins.coin)"
                print(retryItemText, "2nd")
                
                do {
                    try context.save()
                    print("saved")
                } catch {
                    fatalError("cannot save")
                }
                
                fetchItem()
                
            })
            alert.addAction(okAction)
                  
            self.present(alert, animated: true, completion: nil)
        }*/
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        
        
        
        //fetchItem()
        
        return cell
    }
    
    
    
}
