//
//  GiftViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 13/2/2564 BE.
//

import UIKit
import CoreData

class GiftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    /*
     @IBOutlet weak var starDisplay: UILabel!
     */
    @IBOutlet weak var coinDisplay: UILabel!
    
    var coin: Float = 0
    
    
   /* @IBAction func textFieldDoneEditing(sender: UITextField) {
          if sender.text == result {     // you should probably force everything to lowercase, to avoid wrong test
            myLabel.text = "Correct"
      } else {
            myLabel.text = "Incorrect"
  }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.tasks.count
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tasks.count
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
        let cell:GiftCustomCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! GiftCustomCell
        
        cell.myCellLabel.text = self.tasks[indexPath.section]
        cell.myImage.image = self.imageName[indexPath.section]
        
        //let indexPaths = tableView.indexPath(for: cell)
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        
        cell.collectButtonAction = { [unowned self] in
            let task = self.tasks[indexPath.section]
            let amountGift = self.amountGifts[indexPath.section]
            let alert = UIAlertController(title: "Collect!", message: "Collect coins from \(task) Congrats! You got \(amountGift) coins", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            coinDisplay.text = "100"
            cell.collectButton.isEnabled = false
            //cell.layer.backgroundColor = UIColor.darkGray.cgColor
            //tableView.moveRow(at: indexPath, to: indexPaths?.last)
                  
            self.present(alert, animated: true, completion: nil)
        }
       /* let button = cell.collectButton
        button.addTarget(self, action: #selector(subscribeButtonTapped(_:)), for: UIControl.Event.touchUpInside)*/
        
        return cell
    }
    
    
    
    /*func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
        print("You tapped cell number \(indexPath.row).")
    }*/
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    let tasks: [String] = ["First Game of the day", "Royalty user: log in two days in a row", "Diligent leaner: study 5 vocabulary", "Starter kit: first-time user"]
    let cellReuseIdentifier = "giftCell"
    let imageName = [UIImage(named: "coin-reward.png"), UIImage(named: "coin-reward.png"), UIImage(named: "coin-reward.png"), UIImage(named: "coin-reward.png")]
    let cellSpacingHeight: CGFloat = 20
    
    //amount of coins user will get from each gifts
    let amountGifts: [String] = ["100", "100", "100", "100"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        screenNameLabel.text = "Gift"
    }
    
    
  /*  @IBAction func subscribeButtonTapped(_ sender: UIButton){
        // if the closure is defined (not nil)
        // then execute the code inside the subscribeButtonAction closure
        subscribeButtonAction?()
      }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*extension ViewController: TableViewNew {
        func onClickCell(index: Int) {
            print("\(tasks[index]) is selected")
        }
    }*/

}
