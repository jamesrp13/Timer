//
//  TimerViewController.swift
//  Timer
//
//  Created by James Pacheco on 10/19/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerStackView: UIStackView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerProgressView: UIProgressView!
    @IBOutlet weak var hourPickerView: UIPickerView!
    @IBOutlet weak var minutePickerView: UIPickerView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    let timer = Timer()
    var isPaused = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTimerBasedViews", name: Timer.TimerSecondTickNotification, object: timer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "timerComplete", name: Timer.TimerCompleteNotification, object: timer)
        
    }
    
    @IBAction func pauseButtonTapped(sender: AnyObject) {
        if isPaused {
            timer.startTimer()
            pauseButton.setTitle("Pause", forState: .Normal)
            isPaused = false
        } else {
            timer.stopTimer()
            isPaused = true
            pauseButton.setTitle("Resume", forState: .Normal)
        }
    }
    
    @IBAction func startButtonTapped(sender: AnyObject) {
        self.toggleTimer()
    }
    
    func toggleTimer() {
        if timer.isOn {
            timer.stopTimer()
            switchToPickerView()
        } else {
            switchToTimerView()
            let totalSeconds = (hourPickerView.selectedRowInComponent(0)*60*60) + (minutePickerView.selectedRowInComponent(0)*60)
            let totalSecondsOnTimer = NSTimeInterval(totalSeconds)
            
            timer.setTime(totalSecondsOnTimer, totalSeconds: totalSecondsOnTimer)
            updateTimerBasedViews()
            timer.startTimer()
        }
    }
    
    func switchToPickerView() {
        pickerStackView.hidden = false
        timerLabel.hidden = true
        timerProgressView.hidden = true
        startButton.setTitle("Start", forState: .Normal)
    }
    
    func switchToTimerView() {
        pickerStackView.hidden = true
        timerLabel.hidden = false
        timerProgressView.hidden = false
        timerProgressView.setProgress(0.0, animated: false)
        startButton.setTitle("Cancel", forState: .Normal)
        isPaused = false
    
    }
    
    func updateTimerLabel() {
        let timeAsString = timer.timerString()
        timerLabel.text = timeAsString
    }
    
    func updateProgressView() {
        let timeElapsed = timer.totalSeconds - timer.seconds
        let percentDone = Float(timeElapsed/timer.totalSeconds)
        timerProgressView.setProgress(percentDone, animated: true)
        
    }
    
    func updateTimerBasedViews(){
        updateTimerLabel()
        updateProgressView()
    }
    

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == hourPickerView {
            return 24
        } else {
            return 60
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let rowLabel = UILabel()
        rowLabel.text = "\(row)"
        return rowLabel
    }
    
    func timerComplete() {
        switchToPickerView()
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
