//
//  NotificationController.swift
//  MedeeCall WatchKit Extension
//
//  Created by Nothing2saY on 2021/02/02.
//

import WatchKit
import SwiftUI
import UserNotifications

class NotificationController: WKUserNotificationHostingController<NotificationView> {

    override var body: NotificationView {
        return NotificationView()
    }

    override func willActivate() {
  
        super.willActivate()
    }

    override func didDeactivate() {
      
        super.didDeactivate()
    }

    override func didReceive(_ notification: UNNotification) {
   
    }
}
