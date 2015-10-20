//
//  AlarmViewController.swift
//  Timer
//
//  Created by James Pacheco on 10/19/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {

    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var alarmSetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var alarmButton: UIButton!
    
    let alarm = Alarm()
    
    func setAlarm() {
        let fireDate = datePickerView.date
        alarm.arm(fireDate)
    }
    func switchToPickerView() {
       dateLabel.hidden = true
        alarmButton.setTitle("Set Alarm", forState: .Normal)
        alarmSetLabel.text = "Your Alarm Is Not Set"
    }
    
    func switchToAlarmView(fireDate: NSDate) {
        dateLabel.hidden = false
        alarmButton.setTitle("Cancel Alarm", forState: .Normal)
        alarmSetLabel.text = "Your Alarm Is Set"
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .ShortStyle
        dateLabel.text = formatter.stringFromDate(fireDate)
    }
    
    @IBAction func alarmButtonTapped(sender: AnyObject) {
        if alarm.isArmed {
            switchToPickerView()
            alarm.cancel()
        } else {
            let fireDate = datePickerView.date
            switchToAlarmView(fireDate)
            alarm.arm(fireDate)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerView.minimumDate = NSDate()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchToPickerView", name: Alarm.kAlarmCompleteNotification, object: nil)
    
        alarm.cancel()
        if let notifications = UIApplication.sharedApplication().scheduledLocalNotifications {
            for notification in notifications {
                if notification.category == Alarm.kAlarmAlert {
                    if let newAlarmDate = notification.fireDate{
                    alarm.arm(newAlarmDate)
                    switchToAlarmView(newAlarmDate)
                    }
                    UIApplication.sharedApplication().cancelLocalNotification(notification)
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
