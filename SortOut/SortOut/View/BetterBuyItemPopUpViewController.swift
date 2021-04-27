//
//  BetterBuyItemPopUpViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 27/4/2564 BE.
//

import UIKit

class BetterBuyItemPopUpViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var amountOfItemLabel: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    
    
    var amount = 1
    var item = 0
    var price = 100
    var coin = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        amountOfItemLabel.text = String(amount)//"\(amount + 1)"
       getCoin()
    }
    
    func getCoin() {
        do {
            let jsons = try loadJSON(withFilename: "ItemProp")
//            print(jsons!)
            guard let array = jsons as? [Any] else {return}
            for i in array {
                guard let num = i as? [String: Any] else { return }
                coin = num["coin"] as! Int
                print("getCoin coin: ", coin)

            }
        }
        catch {
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
    

    
    @IBAction func plusTapped(_ sender: Any) {
        amount += 1
        amountOfItemLabel.text = String(amount)
        self.item = amount
        price += 100
        if price > coin {
            print("not enough coin!")
            let alert = UIAlertController(title: "Not enough coin" , message: "Lower the amount of item or get more coins!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction!) in
                self.buyBtn.isEnabled = false
                print("Tap ok")
                //self.presentingViewController?.dismiss(animated: false, completion: nil)
          }))
            self.present(alert, animated: true, completion: nil)
        }
        print("plus", self.item)
        print("plus price: ", price)
    }
    
    @IBAction func minusTapped(_ sender: Any) {
        if amount >= 2 {
            amount -= 1
            amountOfItemLabel.text = String(amount)
            self.item = amount
            price -= 100
            buyBtn.isEnabled = true
            print("minus", self.item)
            print("minus price", price)
        }
    }
    
    @IBAction func buyTapped(_ sender: Any) {
        print("buy tapped")
        let alert = UIAlertController(title: "Buy " + "Retry" + "?", message: "Are you sure?", preferredStyle: .alert)
        
        //Yes
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            
            if self.item == 0 {
                self.item = 1
                self.price = 100
            }
            UserDefaults.standard.set(self.item, forKey: "Key")
            UserDefaults.standard.set(self.price, forKey: "coin")
            DataManager.shared.firstVC.viewDidLoad()
            //self.viewCon?.tableview.reloadData()
            print("popUpItem: ", self.item)
            print("coin decreased: ", self.price)
            
//            do {
//                try DataManager.shared.firstVC.context.save()
//            }
//            catch {
//
//            }
            //self.performSegue(withIdentifier: "toViewCon", sender: self)
//            let newItem = ItemCD.init(context: self.context)
//                if self.item == 0 {
//                    self.item = 1
//                }
//                newItem.itemNum += Int64(self.item)
//                print(self.item)
//                print("newItem", newItem.itemNum)
//            self.viewCon?.fetchData()
            //try! self.context.save()
//                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                //self.viewCon.tableview.reloadData()
            
            
            
            self.presentingViewController?.dismiss(animated: false, completion: nil)
            
        }))
        
        //NO
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Tap no")
            self.presentingViewController?.dismiss(animated: false, completion: nil)
      }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func dissMissPopUp1(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func dismissPopUp2(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }

}
