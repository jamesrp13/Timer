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
    @IBOutlet weak var timerProgressView: NSLayoutConstraint!
    @IBOutlet weak var hourPickerView: UIPickerView!
    @IBOutlet weak var minutePickerView: UIPickerView!
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    let timer = Timer()

    @IBAction func pauseButtonTapped(sender: AnyObject) {
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
    }
    
    func switchToTimerView() {
        pickerStackView.hidden = true
    }
    
    func updateTimerLabel() {
        timerLabel.text = timer.timerString()
    }
    
    func updateProgressView() {

        
    }
    
    func updateTimerBasedViews(){
        updateTimerLabel()
        updateProgressView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
