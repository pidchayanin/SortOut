
//
//  ProfileViewController.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 12/2/2564 BE.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //    let cell:ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ProfileTableViewCell
        
    //    cell.settingLabel.text = options[indexPath.row]
    //    return cell
   // }
    
    
    //func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // your number of cells here
   //     return self.options.count
   // }

    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
        print("You tapped cell number \(indexPath.row).")
    }*/
    
    let options: [String] = ["Notification", "Time", "Date"]
    let cellReuseIdentifier = "notiSettingCell"
    

    @IBOutlet weak var PlayerNameLabel: UILabel!
    //@IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var notificationTime: UITextField!
    
    @IBOutlet weak var notificationDate: UITextField!
    
    //**START time and date picker
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PlayerNameLabel.text = "Player" //add player name from apple game center
     
        createDatePicker()
        
        //  self.tableView.delegate = self
     //   self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func createDatePicker() {
        
        notificationDate.textAlignment = .center
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar to the keyboard
        notificationDate.inputAccessoryView = toolbar
        
        // assign date picker to the textfield
        notificationDate.inputView = datePicker
        
        // date picker mode: change it to just date
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressed() {
        // create a formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none // do not want to display time
        
        
        //notificationDate.text = "\(datePicker.date)"
        notificationDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
        print(notificationDate.text!)
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
