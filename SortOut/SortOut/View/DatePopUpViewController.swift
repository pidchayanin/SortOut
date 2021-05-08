//
//  DatePopUpViewController.swift
//  SortOut
//
//  Created by Pidchayanin Chutipattana on 3/5/2564 BE.
//

import UIKit


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
    
    var flag1 = false
    var flag2 = false
    var flag3 = false
    var flag4 = false
    var flag5 = false
    var flag6 = false
    var flag7 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneBtn_TouchUpinside(_ sender: Any) {
        dismiss(animated: true)
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
