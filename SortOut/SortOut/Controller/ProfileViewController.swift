
//
//  ProfileViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 12/2/2564 BE.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //**START time and date picker
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    var text:String = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePopupClosing), name: .saveDateTime, object: nil)
        
        dateLabel?.text = text
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handlePopupClosing(notification: Notification) {
        let dateVc = notification.object as! TimePopUpViewController
        timeLabel.text = dateVc.formattedDate
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
