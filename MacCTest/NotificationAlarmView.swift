//
//  NotificationAlarm.swift
//  MacCTest
//
//  Created by Yeji Seo on 10/27/24.
//

import SwiftUI

struct NotificationAlarm: View {
    var body: some View {
        VStack {
            Text("Alarm Setting")
                .padding()
            
            Button(action: {
                requestNotificationPermission()
                scheduleTestNotification()
            }) {
                Text("Set Alarm Sound")
            }
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permission granted")
            } else if let error = error {
                print("Permission denied: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test Alarm"
        content.body = "test notification!"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("Alarm.wav"))

        // 10초 후 알림
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    
}

#Preview {
    NotificationAlarm()
}
