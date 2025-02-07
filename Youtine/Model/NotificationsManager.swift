//
//  NotificationsManager.swift
//  Youtine
//
//  Created by Bobby Guerra on 2/7/25.
//

import UserNotifications

class NotificationsManager {
    func addNotification(id: String, index: Int, startTime: String) {
        let content = UNMutableNotificationContent()
        let title = ManageRoutineView.getRoutineTitle(index: index)
        let subtitle = startTime
        
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default
        
        let date = ContentView.getDateFromString(timeString: startTime)
        let dateComponents = getDateComponents(date: date)

        // Create a calendar-based trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // choose a random identifier
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
    
    func getDateComponents(date: Date) -> DateComponents {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: date)
        return dateComponents
    }
    
    
}
