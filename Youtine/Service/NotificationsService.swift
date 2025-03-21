//
//  NotificationsManager.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/7/25.
//

import UserNotifications

struct NotificationsService {
    // ???: Function is static so it can be invoked after a user signs in without creating a NotificationService Instance
    static func promptNotificationsGrant() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notifications prompt finished!")
            } else if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addNotification(id: String, index: Int, startTime: String) {
        let content = UNMutableNotificationContent()
        let title = getRoutineTitle(index: index)
        let body = "Begin your \(getRoutineTitle(index: index).lowercased()) now!"
        
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let date = getDateFromString(timeString: startTime)
        let dateComponents = getDateComponents(date: date)

        // Create a calendar-based trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // Provision notification request
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    func updateNotification(id: String, index: Int, newStartTime: String) {
        // Remove the existing notification
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])

        // Re-add the notification with the new start time
        addNotification(id: id, index: index, startTime: newStartTime) // Adjust index if needed
    }
    
    func deleteNotification(id: String) {
        // Remove the existing notification
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
