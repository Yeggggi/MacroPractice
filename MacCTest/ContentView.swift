//
//  ContentView.swift
//  MacCTest
//
//  Created by Yeji Seo on 9/22/24.
//

import Foundation
import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Set Alarm")
                .padding()
            
            Button(action: {
                requestNotificationPermission()
                scheduleTestNotification()
            }) {
                Text("Set Alarm with Sound and Vibration")
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
        content.body = "This is a test notification!"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("Playtime.wav"))

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
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "It's time to wake up!"
        
        // 기본 알림 소리 추가
        content.sound = UNNotificationSound.default

        // 알림 시간 설정 (예: 오전 7시)
        var dateComponents = DateComponents()
        dateComponents.hour = 22
        dateComponents.minute = 27

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
