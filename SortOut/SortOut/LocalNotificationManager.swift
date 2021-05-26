//
//  LocalNotificationManager.swift
//  SortOut
//


import Foundation
import UserNotifications
class LocalNotificationManager {
    var notifications: [Notification] = []
    
    func addNotification(id: String, title: String, dateTime: DateComponents) {
        notifications.append(Notification(id: id, title: title, datetime: dateTime))
    }
    
    func listScheduleNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            print("CHECK NOTIFICATION LIST")
            notifications.forEach { notification in
                print(notification)
            }
        }
    }
    
    public func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] setting in
            guard let self = self else { return }
            
            print("CHECK USER PERMISSION")
            switch setting.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotification()

            default: break
            }
        }
    }
    
    private func scheduleNotification() {
        print("START ADD NOTIFICATION")
        notifications.forEach({ notification in
            let content = UNMutableNotificationContent()
            content.title = "Hey! It is time for SortOut!"
            content.body = "Just a quick reminder, knowing English might increase your chance of getting a job after college :)"
            content.sound = .default
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: notification.datetime, repeats: true)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            print("CHECK REQUEST ", notification.id, request, trigger)
            UNUserNotificationCenter.current().add(request) { [weak self] error in
                print("ADD NOTIFICATION SUCCESS ID", notification.id, error ?? "")
                guard let _ = self, error != nil else { return }
                print("Notification Error ID: ", notification.id, error ?? "")
            }
        })
        listScheduleNotifications()
    }
    
    private func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] granted, error in
            guard let self = self else { return }
            
            if granted, error == nil {
                self.scheduleNotification()
            }
        }
    }
}
