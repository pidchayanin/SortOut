
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
    @IBOutlet weak var notifyBtn: UIButton!
    @IBOutlet weak var dateStackView: UIStackView!
    
    //**START time and date picker
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let notificationManager = LocalNotificationManager()
    var text: String = "Day of the week"
    var time: Date?
    var date: [Day]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.profileVC = self
        notificationManager.listScheduleNotifications()
    }
    
    @IBAction func alertMe(_ sender: Any) {
        guard let time = time, let date = date else { return }
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "th")
        let hour = calendar.component(.hour, from: time)
        let minutes = calendar.component(.minute, from: time)
        date.forEach { dateItem in
            print(dateItem, time)
            let dateComponent = DateComponents(calendar: calendar, hour: hour, minute: minutes, weekday: dateItem.rawValue)
            notificationManager.addNotification(id: UUID().uuidString, title: "Notify ME!", dateTime: dateComponent)
        }
        notificationManager.schedule()
    }
    @IBAction func openTimeViewController(_ sender: Any) {
        guard let timeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TimeViewController") as? TimePopUpViewController else { return }
        timeViewController.delegate = self
        present(timeViewController, animated: true, completion: nil)
    }
    
    @IBAction func openDateViewController(_ sender: Any) {
        guard let dateViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DateViewController") as? DatePopUpViewController else { return }
        dateViewController.delegate = self
        present(dateViewController, animated: true, completion: nil)
    }
}

extension ProfileViewController: DatePopUpViewControllerDelegate {
    func datePopUpViewControllerDidSelectDate(date: [Day]) {
        self.date = date
        var dateText = ""
        notifyBtn.isEnabled = !(self.time == nil || self.date == nil)
        date.enumerated().forEach { (index, item) in
            dateText += (index == 0 ? "" : ", ") + item.convertDay()
        }
        dateLabel.text = dateText
    }
}

extension ProfileViewController: TimePopUpViewControllerDelegate {
    func timePopUpViewControllerDidSelectTime(time: Date, timeText: String) {
        self.time = time
        timeLabel.text = timeText
        notifyBtn.isEnabled = !(self.time == nil || self.date == nil)
        dateStackView.isHidden = self.time == nil
    }
}
