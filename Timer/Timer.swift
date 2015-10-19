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
    var isOn: Bool
    
    init(seconds: NSTimeInterval, totalSeconds: NSTimeInterval, timer: NSTimer, isOn: Bool) {
        self.seconds = seconds
        self.totalSeconds = totalSeconds
        self.timer = timer
        self.isOn = isOn
    }
    
    func setTime(second: NSTimeInterval, totalSeconds: NSTimeInterval) {
        
    }
    
    func startTimer(){
        
    }
    
    func stopTimer(){
        
    }
    
    func secondTick(){
        
    }
    
    func timerString() -> String{
        let hours = self.seconds/(60*60)
        let minutes = (self.seconds - (hours*60*60))/60
        let seconds = self.seconds - ((hours*60*60) + (minutes*60))
        return String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }
}
