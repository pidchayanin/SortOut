//
//  DatePopUpViewController.swift
//  SortOut
//
//  Created by Pidchayanin Chutipattana on 3/5/2564 BE.
//

import UIKit

protocol DatePopUpViewControllerDelegate: NSObject {
    func datePopUpViewControllerDidSelectDate(date: [Day])
}

enum Day: Int, CaseIterable {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
    
    func convertDay() -> String {
        switch self {
        case .sunday:
            return "Sun."
        case .monday:
            return "Mon."
        case .tuesday:
            return "Tue."
        case .wednesday:
            return "Wed."
        case .thursday:
            return "Thu."
        case .friday:
            return "Fri."
        case .saturday:
            return "Sat."
        }
    }
}

class DatePopUpViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIView!
    
    @IBOutlet weak var cbDate1: UIButton!
    @IBOutlet weak var cbDate2: UIButton!
    @IBOutlet weak var cbDate3: UIButton!
    @IBOutlet weak var cbDate4: UIButton!
    @IBOutlet weak var cbDate5: UIButton!
    @IBOutlet weak var cbDate6: UIButton!
    @IBOutlet weak var cbDate7: UIButton!
    
    weak var delegate: DatePopUpViewControllerDelegate?
    var flag1 = false
    var flag2 = false
    var flag3 = false
    var flag4 = false
    var flag5 = false
    var flag6 = false
    var flag7 = false
    
    var showDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func doneBtn_TouchUpinside(_ sender: Any) {
        //check if checkbox is ticked
        var result: [Day] = []
        if flag1 == true {
            result.append(.sunday)
        }
        if flag2 == true {
            result.append(.monday)
        }
        if flag3 == true {
            result.append(.tuesday)
        }
        if flag4 == true {
            result.append(.wednesday)
        }
        if flag5 == true {
            result.append(.thursday)
        }
        if flag6 == true {
            result.append(.friday)
        }
        if flag7 == true {
            result.append(.saturday)
        }
        
        delegate?.datePopUpViewControllerDidSelectDate(date: result)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelBtn_TouchUpInside(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func cbBtnDate1(_ sender: UIButton) {
        if (flag1 == false)
        {
            sender.setBackgroundImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
            flag1 = true
        }
        else
        {
            sender.setBackgroundImage(UIImage(named: "uncheckbox"), for: UIControl.State.normal)
            flag1 = false
        }
    }
    
    @IBAction func cbBtnDate2(_ sender: UIButton) {
        if (flag2 == false)
        {
            sender.setBackgroundImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
            flag2 = true
        }
        else
        {
            sender.setBackgroundImage(UIImage(named: "uncheckbox"), for: UIControl.State.normal)
            flag2 = false
        }
    }
    @IBAction func cbBtnDate3(_ sender: UIButton) {
        if (flag3 == false)
        {
            sender.setBackgroundImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
            flag3 = true
        }
        else
        {
            sender.setBackgroundImage(UIImage(named: "uncheckbox"), for: UIControl.State.normal)
            flag3 = false
        }
    }
    
    @IBAction func cbBtnDate4(_ sender: UIButton) {
        if (flag4 == false)
        {
            sender.setBackgroundImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
            flag4 = true
        }
        else
        {
            sender.setBackgroundImage(UIImage(named: "uncheckbox"), for: UIControl.State.normal)
            flag4 = false
        }
    }
    @IBAction func cbBtnDate5(_ sender: UIButton) {
        if (flag5 == false)
        {
            sender.setBackgroundImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
            flag5 = true
        }
        else
        {
            sender.setBackgroundImage(UIImage(named: "uncheckbox"), for: UIControl.State.normal)
            flag5 = false
        }
    }
    @IBAction func cbBtnDate6(_ sender: UIButton) {
        if (flag6 == false)
        {
            sender.setBackgroundImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
            flag6 = true
        }
        else
        {
            sender.setBackgroundImage(UIImage(named: "uncheckbox"), for: UIControl.State.normal)
            flag6 = false
        }
    }
    @IBAction func cbBtnDate7(_ sender: UIButton) {
        if (flag7 == false)
        {
            sender.setBackgroundImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
            flag7 = true
        }
        else
        {
            sender.setBackgroundImage(UIImage(named: "uncheckbox"), for: UIControl.State.normal)
            flag7 = false
        }
    }

}

extension String {
    func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: characters.count, by: n).forEach {
            result += String(characters[$0..<min($0+n, characters.count)])
            if $0+n < characters.count {
                result += separator
            }
        }
        return result
    }
}
