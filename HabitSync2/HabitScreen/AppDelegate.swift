//
//  AppDelegate.swift
//  HabitSync2
//
//  Created by Amaan Ghoghawala on 3/14/25.
//

import UIKit
import UserNotifications
import Firebase
import Foundation

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    // Called when the app is launched
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // noti permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
        
        
        UNUserNotificationCenter.current().delegate = self
        
        
        FirebaseApp.configure()

        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Display noti
        completionHandler([.banner, .sound])
    }
}

func trackHabitCompletion() {
    let currentDate = Date()
    
    // last completion date from UserDefaults
    if let lastCompletionDate = UserDefaults.standard.object(forKey: "lastCompletionDate") as? Date {
        
        // Calculate  difference in days
        let calendar = Calendar.current
        let daysDifference = calendar.dateComponents([.day], from: lastCompletionDate, to: currentDate).day
        
        // Check if the habit has been completed for 7 consecutive days
        if daysDifference == 7 {
            sendMilestoneNotification()
        }
    }
    UserDefaults.standard.set(currentDate, forKey: "lastCompletionDate")
}

func sendMilestoneNotification() {
    // Create the noti content
    let content = UNMutableNotificationContent()
    content.title = "Milestone Achieved!"
    content.body = "Congratulations! You've completed your habit for 7 days in a row."
    content.sound = .default

    // noti trigger (5 seconds)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

    // noti request
    let request = UNNotificationRequest(identifier: "milestoneAchieved", content: content, trigger: trigger)

    // Add to noti center
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error scheduling notification: \(error.localizedDescription)")
        } else {
            print("Milestone notification scheduled.")
        }
    }
}
