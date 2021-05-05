//
//  TimePopUpViewController.swift
//  SortOut
//
//  Created by Pidchayanin Chutipattana on 3/5/2564 BE.
//

import UIKit

class TimePopUpViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var formattedDate: String {
        get {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: timePicker.date)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneBtn_TouchUpinside(_ sender: Any) {
        NotificationCenter.default.post(name: .saveDateTime , object: self)
        dismiss(animated: true)
        
        
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
