//
//  Alarm.swift
//  Timer
//
//  Created by James Pacheco on 10/20/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class Alarm: NSObject {
    
    static let kAlarmCompleteNotification = "kAlarmCompleteNotification"
    static let kAlarmAlert = "kAlarmAlert"
    
    private var alarmDate: NSDate?
    
    var isArmed: Bool {
        get {
            if alarmDate != nil {
                return true
            } else {
                return false
            }
        }
    }

    private var localAlarmNotification: UILocalNotification?
    
    func arm(fireDate: NSDate) {
        alarmDate = fireDate
        let alarmNotification = UILocalNotification()
        alarmNotification.alertBody = "Time for something...You set an alarm for now...So make it happen."
        alarmNotification.fireDate = fireDate
        alarmNotification.soundName = "sms-received3.caf"
        alarmNotification.category = Alarm.kAlarmAlert
        UIApplication.sharedApplication().scheduleLocalNotification(alarmNotification)
    }
    
    func cancel() {
        alarmDate = nil
        if let localNotification = localAlarmNotification {
            UIApplication.sharedApplication().cancelLocalNotification(localNotification)
        }
    }
    
    static func alarmComplete() {
        NSNotificationCenter.defaultCenter().postNotificationName(kAlarmCompleteNotification, object: self)
    }
    
}














