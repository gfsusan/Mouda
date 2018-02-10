//
//  AlarmVC.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 10..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit
import UserNotifications

var dateFormatter:DateFormatter!
var pickerString: String?
var nowString: String?

var settingTimeKey = "settingTime"

class AlarmVC: UIViewController {

    @IBOutlet weak var alarmTimePicker: UIDatePicker!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        dateFormatter.amSymbol = "오전"
        dateFormatter.pmSymbol = "오후"
        
//        changedTimePicker()
    
        let userDefaultAlarm = UserDefaults.standard.array(forKey: settingTimeKey)
        if let date = dateFormatter.date(from: "오후 09:00") {
            if let settingDate = dateFormatter.date(from: settingTimeKey) {
                alarmTimePicker.date = settingDate
            }
            alarmTimePicker.date = date
        }
        
        let _ = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(settingTime), userInfo: userDefaultAlarm, repeats: false)
        
//        alarmTimeLabel.text = dateFormatter.string(from: alarmTimePicker.date)
//        alarmTimePicker.addTarget(self, action: #selector(AlarmVC.changedTimePicker(_:)), for: UIControlEvents.valueChanged)
        
        
        
//        let _ = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(changedTimePicker), userInfo: userDefaultAlarm, repeats: true)
        
        

//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
////        alarmTimePicker.addTarget(self, action: #selector(AlarmVC.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func settingTime() {
        pickerString = dateFormatter.string(from: alarmTimePicker.date)
        if let settingPicker = pickerString {
            UserDefaults.standard.set(pickerString, forKey: settingTimeKey)
            alarmTimeLabel.text = pickerString
        }
    }
    
//
//        let content = UNMutableNotificationContent()
//        content.title = "Title goes here"
//        content.body = "Main text goes here"
//        content.categoryIdentifier = "customIdentifier"
//        content.userInfo = ["customData" : "fizzbuzz"]
//        content.sound = UNNotificationSound.default()
//    }
//
//    @objc func scheduleLocal() {
//        let center = UNUserNotificationCenter.current()
//
//        let content = UNMutableNotificationContent()
//        content.title = "Late wake up call"
//        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
//        content.categoryIdentifier = "alarm"
//        content.userInfo = ["customData": "fizzbuzz"]
//        content.sound = UNNotificationSound.default()
//
//        var dateComponents = DateComponents()
//        dateComponents.hour = 10
//        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//        center.add(request)
//    }
    
    
    @IBAction func changedTimePicker() {
        
        pickerString = dateFormatter.string(from: alarmTimePicker.date)
        nowString = dateFormatter.string(from: Date())
        
        let settingTime = pickerString
        UserDefaults.standard.set(settingTime, forKey: settingTimeKey)
        
        guard let changedAlarm = pickerString else {
            return
        }
        
        alarmTimeLabel.text = changedAlarm
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .none
//        dateFormatter.timeStyle = .short
//
//        alarmTimeLabel.text = dateFormatter.string(from: alarmTimePicker.date)
//    }
//        func datePicker() {
//        alarmTimePicker.datePickerMode = UIDatePickerMode.time
    }
    
    
//    //알람
//    func defaultAlarm(date:String, time: String, subject: String) {
//
//        var dateString = date+" "+time
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//
//        let convertedDate = dateFormatter.date(from: dateString)!
//
//        let subtractTime = Calendar.current.date(byAdding: .minute, value: -10, to: convertedDate)
//
//        dateString = dateFormatter.string(from: subtractTime!)
//
//        var localTimeZoneName: String { return TimeZone.current.identifier }
//        var secondsFromGMT: Int {return TimeZone.current.secondsFromGMT() }
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//
//        let dateObj:Date = dateFormatter.date(from: dateString)!
//
//        print("alarm time: \(dateObj)")
//
//        let triggerDaily = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: dateObj)
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
//
//        let alarmId = UUID().uuidString
//
//        let content = UNMutableNotificationContent()
//        content.title = "오늘의 책을 기록하세요."
//
//        let request = UNNotificationRequest(identifier: alarmIdentifier, content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().delegate = self
//        UNUserNotificationCenter.current().add(request) {(error) in
//            if let error = error {
//                print("Uh oh! I had an error: \(error)")
//            }
//        }
//    }
    
    
//    func switchOn() {
//        print("Switch is On")
//        let content = UNMutableNotificationContent()
//        content.title = "오늘의 책을 기록하세요."
//        content.badge = 1
//
//        let triggerDate = Calendar.current.dateComponents([ .hour, .minute, .second], from: alarmTimePicker.date)
//
//        let triggerDaily = UNCalendarNotificationTrigger(dateMatching: triggerDate
//            , repeats: true)
//
//        let request = UNNotificationRequest(identifier: "timeDone", content: content, trigger: triggerDaily)
//
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
//            if let error = error {
//                print("Alarm Error")
//            }
//        })
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}
