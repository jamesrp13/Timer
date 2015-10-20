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
    static let TimerCompleteNotification = "timerCompleteNotification"
    
    private var seconds = NSTimeInterval(0)
    private var totalSeconds = NSTimeInterval(0)
    private var timer = NSTimer?()
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
    
    func startTimer(){
        if (timer == nil) {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "secondTick", userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer(){
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
            // Create notification about stop?
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
        let hours = self.seconds/(60*60)
        let minutes = (self.seconds - (hours*60*60))/60
        let seconds = self.seconds - ((hours*60*60) + (minutes*60))
        return String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }
}
