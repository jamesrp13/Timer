//
//  Timer.swift
//  Timer
//
//  Created by James Pacheco on 10/19/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class Timer: NSObject {

    static let TimerSecondTickNotification = "timerSecondTickNotification"
    static  let TimerCompleteNotification = "timerCompleteNotification"
    static let TimerLocalNotification = "timerLocalNotification"
    static let TimerTotalSeconds = "timerTotalSeconds"
    
    private(set) var seconds = NSTimeInterval(0)
    private(set) var totalSeconds = NSTimeInterval(0)
    private var timer: NSTimer?
    var isOn: Bool {
        get {
            if timer == nil {
                return false
            } else {
                return true
            }
        }
    }
    
    func setTime(seconds: NSTimeInterval, totalSeconds: NSTimeInterval) {
        self.seconds = seconds
        self.totalSeconds = totalSeconds
    }
    
    private var localNotification: UILocalNotification?
    
    func startTimer(){
        if (timer == nil) {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "secondTick", userInfo: nil, repeats: true)
            
            let alarmNotification = UILocalNotification()
            alarmNotification.fireDate = NSDate().dateByAddingTimeInterval(totalSeconds)
            alarmNotification.category = Timer.TimerLocalNotification
            alarmNotification.userInfo = [Timer.TimerTotalSeconds:totalSeconds]
            localNotification = alarmNotification
            UIApplication.sharedApplication().scheduleLocalNotification(alarmNotification)
        }
    }
    
    func stopTimer(){
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
            if let localNotification = localNotification {
                UIApplication.sharedApplication().cancelLocalNotification(localNotification)
            }
        }
    }
    
    func secondTick(){
        if timer != nil {
            seconds--;
            NSNotificationCenter.defaultCenter().postNotificationName(Timer.TimerSecondTickNotification, object: self)
            if seconds <= 0 {
                NSNotificationCenter.defaultCenter().postNotificationName(Timer.TimerCompleteNotification, object: self)
                stopTimer()
            }
        }
        
    }
    
    func timerString() -> String{
        let seconds = Int(self.seconds)
        let hours = seconds/(60*60)
        let minutes = (seconds - (hours*60*60))/60
        let secondsLeft = seconds - ((hours*60*60) + (minutes*60))
        return (String(format: "%02d : %02d : %02d", hours, minutes, secondsLeft))
    }
}
