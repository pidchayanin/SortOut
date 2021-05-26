//
//  TimePopUpViewController.swift
//  SortOut
//
//  Created by Pidchayanin Chutipattana on 3/5/2564 BE.
//

import UIKit

protocol TimePopUpViewControllerDelegate: NSObject {
    func timePopUpViewControllerDidSelectTime(time: Date, timeText: String)
}

class TimePopUpViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    weak var delegate: TimePopUpViewControllerDelegate?
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
        timePicker.locale = Locale(identifier: "th")
    }
    
    @IBAction func doneBtn_TouchUpinside(_ sender: Any) {
        print("DATE: ", formattedDate)
        delegate?.timePopUpViewControllerDidSelectTime(time: timePicker.date, timeText: formattedDate)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtn_TouchUpinside(_ sender: Any) {
        dismiss(animated: true)
    }
}
