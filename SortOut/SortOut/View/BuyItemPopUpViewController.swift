//
//  BuyItemPopUpViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 28/3/2564 BE.
//

import UIKit
import CoreData

class BuyItemPopUpViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemCount:[Item]?
    let itemName = "Retry"
    var numOfItemCount = 0
    //let shopView = ShopViewController()
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var amountOfItemLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        itemNameLabel.text = itemName
        itemPriceLabel.text = "100"
        coinImage.image = UIImage(named: "insta.jpg")
        amountOfItemLabel.text = "1"
    }
    

    @IBAction func increaseItemTapped(_ sender: Any) {
        numOfItemCount += 1
        amountOfItemLabel.text = String(numOfItemCount)
    }
    
    @IBAction func decreaseItemTapped(_ sender: Any) {
        numOfItemCount -= 1
        amountOfItemLabel.text = String(numOfItemCount)
        if numOfItemCount <= 0 {
            numOfItemCount = 1
            amountOfItemLabel.text = String(numOfItemCount)
        }
    }
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        
        //shopView.retryItemText = [String(retryItem.itemNum)]
        //Use Alert
        let alert = UIAlertController(title: "Buy " + self.itemName + "?", message: "Are you sure?", preferredStyle: .alert)
        //Yes
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in NSLog("The \"YES\" alert occured.")
            
            //to update global variable, we need to create another class refer to https://stackoverflow.com/questions/45267122/how-to-update-a-global-variable-in-swift-in-a-function
            let retryItem = Item.init(context: self.context)
            retryItem.itemNum = Int64(self.numOfItemCount)
            print("popup", retryItem.itemNum)
            do {
                try self.context.save()
            } catch {
                fatalError("could not save")
            }
            self.presentingViewController?.dismiss(animated: false, completion: nil)
        }))
        
        //NO
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Tap no")
            self.presentingViewController?.dismiss(animated: false, completion: nil)
      }))
        
        self.present(alert, animated: true, completion: nil)
    

        
        
        
    }
    
    
    @IBAction func dismissPopUp1(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func dismissPopUp2(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: false, completion: nil)
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
