
//
//  ProfileViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 12/2/2564 BE.
//

import UIKit

class ProfileViewController: UIViewController {
    
   
    
    @IBOutlet weak var notificationTime: UITextField!
    
    @IBOutlet weak var notificationDate: UITextField!
    
    //**START time and date picker
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //old date and time picker in UItextfield
        createDatePicker()
        createTimePicker()
        
        //new
        
        
        // Do any additional setup after loading the view.
    }
    
    func createDatePicker() {
        
        notificationDate.textAlignment = .center
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDonePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        
        // assign toolbar to the keyboard
        notificationDate.inputAccessoryView = toolbar
        
        // assign date picker to the textfield
        notificationDate.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        
        // date picker mode: change it to just date
        datePicker.datePickerMode = .date
    }
    
    @objc func dateDonePressed() {
        // create a formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none // do not want to display time
        
        //notificationDate.text = "\(datePicker.date)"
        notificationDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
        print(notificationDate.text!)
    }
    

    func createTimePicker() {
        notificationTime.textAlignment = .center
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeDonePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar to the keyboard
        notificationTime.inputAccessoryView = toolbar
        
        // assign date picker to the textfield
        notificationTime.inputView = timePicker
        timePicker.preferredDatePickerStyle = .wheels
        
        // date picker mode: change it to just time
        timePicker.datePickerMode = .time
    }
    
    @objc func timeDonePressed() {
        // create a formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium // do not want to display date
        
        //notificationDate.text = "\(datePicker.date)"
        notificationTime.text = formatter.string(from: timePicker.date)
        self.view.endEditing(true)
        
        print(notificationTime.text!)
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
