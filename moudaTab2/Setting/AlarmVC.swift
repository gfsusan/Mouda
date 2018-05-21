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

struct Alarm {
    enum AlarmSetting:String {
        case Time
    }
}

var settingTimeKey = "settingTime"

class AlarmVC: UIViewController {
    
    var settingDelegate:SettingTableVC?

    @IBOutlet weak var alarmTimePicker: UIDatePicker!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        dateFormatter.amSymbol = "오전"
        dateFormatter.pmSymbol = "오후"
        
        
        //default data
        if let date = dateFormatter.date(from: "오후 09:00") {
            alarmTimePicker.date = date
        }
        
//        if let time = UserDefaults.standard.value(forKey: Alarm.AlarmSetting.Time.rawValue) {
//            print("setting Date")
//            self.alarmTimePicker.date = time as! Date
//        } else {
//            //default data
//            if let date = dateFormatter.date(from: "오후 09:00") {
//                alarmTimePicker.date = date
//            }
//
//        }
        
        settingTime()
        alarmTimeLabel.text = dateFormatter.string(from: alarmTimePicker.date)
        
        var userDefaultAlarm = alarmTimeLabel.text
        let _ = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(changedTimePicker), userInfo: userDefaultAlarm, repeats: true)
    }
    
    func settingTime() {
        let userDefaults = UserDefaults.standard
        
        if let time = userDefaults.value(forKey: Alarm.AlarmSetting.Time.rawValue) {
            print("setted alarm")
            self.alarmTimePicker.date = time as! Date
        }
        alarmTimeLabel.text = dateFormatter.string(from: alarmTimePicker.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let settedTime = segue.destination as? SettingTableVC {
            print("settedTime")
            settedTime.alarmDelegate = self
        }
    }
    
    
    @IBAction func changedTimePicker() {
        UserDefaults.standard.set(alarmTimePicker.date, forKey: Alarm.AlarmSetting.Time.rawValue)
        
        let settingTime = dateFormatter.string(from: alarmTimePicker.date)
        UserDefaults.standard.set(settingTime, forKey: settingTimeKey)
        
        alarmTimeLabel.text = settingTime
    }
    
    func switchOn() {
        print("Switch is On")
        let content = UNMutableNotificationContent()
        content.title = "오늘의 책을 기록하세요."
        content.badge = 1

        let triggerDate = Calendar.current.dateComponents([ .hour, .minute, .second], from: alarmTimePicker.date)

        let triggerDaily = UNCalendarNotificationTrigger(dateMatching: triggerDate
            , repeats: true)

        let request = UNNotificationRequest(identifier: "timeDone", content: content, trigger: triggerDaily)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("Alarm Error")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
