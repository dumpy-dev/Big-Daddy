//
//  ContractionTimerViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 08/06/2019.
//  Copyright © 2019 Dumpy Developments. All rights reserved.
//

import UIKit
import RealmSwift

class ContractionTimerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var backgroundTask : UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    
    @IBOutlet weak var contractionTimer: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var strengthSlider: UISlider!
    @IBOutlet weak var strengthValue: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableAndTitleView: UIStackView!
    
    @IBOutlet var helpPopup: UIView!
    var timer = Timer()
    var bgtask = 0
    var timerStarted : Bool = false
    var fractions: Int = 0
    var seconds: Int = 0
    var minutes: Int = 0
    var currentContractionTime = ""
    var times : [String] = []
    var intervals : [String] = []
    var strengths : [String] = []
    var dates : [String] = []
    var timerStoppedTime = Date()
    var timerStartedTime = Date()
    var contractionInterval = ""
    @IBAction func helpPopupBackButton(_ sender: Any) {
        animateHelpOut()
    }
    let realm = try! Realm()
    var timerData:Results<ContractionCounterRealm> {
        get {
            return realm.objects(ContractionCounterRealm.self)
        }
    }
    
    func animateHelpIn() {
                self.view.addSubview(helpPopup)
                UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                     self.topView.alpha = 0.2
                     self.tableAndTitleView.alpha = 0.2
                }, completion: nil)
                helpPopup.center.x = self.view.center.x
                helpPopup.frame.origin.y = self.view.frame.height / 4
                helpPopup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
                helpPopup.alpha = 0
                UIView.animate(withDuration: 0.4) {
                    self.helpPopup.alpha = 1
                    self.helpPopup.transform = CGAffineTransform.identity
                    
                }
            }
    
            func animateHelpOut() {
                self.helpPopup.removeFromSuperview()
                UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    self.topView.alpha = 1.0
                   self.tableAndTitleView.alpha = 1.0
                }, completion: nil)
            }
    
    @IBAction func strengthSlider(_ sender: Any) {
        let strength = Int(strengthSlider.value)
        strengthValue.text = "\(strength)"
    }
    
    
    @IBAction func helpButtonPressed(_ sender: Any) {
        animateHelpIn()
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Reset", message: "This will reset all of the contraction times. Are you sure?", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Reset", style: UIAlertAction.Style.default){
                
                UIAlertAction in
                UserDefaults.standard.removeObject(forKey: "contractionInterval")
                let times = self.realm.objects(ContractionCounterRealm.self)
                    try! self.realm.write ({
                        self.realm.delete(times)
                    })
                // All code to reset timer to default status
                
                self.timerStarted = false
                self.timer.invalidate()
                self.endBackgroundTask()
                self.bgtask = 0
                self.contractionTimer.text = "00:00"
                self.fractions = 0
                self.seconds = 0
                self.minutes = 0
                self.times = []
                self.intervals = []
                self.dates = []
                self.strengths = []
                self.strengthSlider.value = 0
                self.strengthValue.text = "0"
                self.tableView.reloadData()
                self.startButton.setImage(UIImage(named: "playButton"), for: .normal)
                
                })
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func startPressed(_ sender: Any) {
       
        if timerStarted == false {
            
            // i.e. if play is pressed
            
            UIView.transition(with: sender as! UIView, duration: 0.4, options: .transitionFlipFromTop, animations: {
                (sender as AnyObject).setImage(UIImage(named: "stopButton"), for: .normal)
            }, completion: nil)
            
            if bgtask == 0 {
                bgtask = 1
                registerBackgroundTask()
            }
            
            timerStarted = true
            inBackground()
            timerStartedTime = Date()
            let date1 = timerStoppedTime
            let date2 = timerStartedTime
            let timeOffset = date2.offset(from: date1)
            contractionInterval = timeOffset
            intervals.append(contractionInterval)
            
            UserDefaults.standard.set(contractionInterval, forKey: "contractionInterval")
            
            // to be saved in User Defaults
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            dates.append(dateFormatter.string(from: timerStartedTime ))
            
            tableView.reloadData()
            
        } else {
            
            UIView.transition(with: sender as! UIView, duration: 0.4, options: .transitionFlipFromTop, animations: {
                (sender as AnyObject).setImage(UIImage(named: "playButton"), for: .normal)
            }, completion: nil)
            timerStarted = false
            currentContractionTime = contractionTimer.text ?? ""
            times.append(currentContractionTime)
            strengths.append("\(Int(strengthSlider.value))")
            
            let timerItem = ContractionCounterRealm()
            
            if let savedInterval = UserDefaults.standard.object(forKey: "contractionInterval") {
           
                timerItem.intervalString = savedInterval as! String
            } else {
                timerItem.intervalString = ""
            }
            
            timerItem.timeOfDay = Date()
            timerItem.lengthOfContraction = currentContractionTime
            timerItem.strengthOfContraction = Int(strengthSlider.value)
            try! self.realm.write({
                self.realm.add(timerItem)
            })
            
            strengthSlider.value = 0
            strengthValue.text = "0"
            timer.invalidate()
            endBackgroundTask()
            bgtask = 0
   
            tableView.reloadData()
      
            contractionTimer.text = "00:00"
            fractions = 0
            seconds = 0
            minutes = 0
            timerStoppedTime = Date()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContractionTimerTableCellView
  
        let time = timerData[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
            cell.contractionTimeLabel.text = "\(time.lengthOfContraction)"
            cell.timeLabel.text = "\(dateFormatter.string(from: time.timeOfDay! ))"
            cell.contractionStrengthLabel.text = "\(time.strengthOfContraction)"
                if indexPath.row == 0 {
                    cell.intervalTimeLabel.text = ""
                } else {
                    cell.intervalTimeLabel.text = "\(time.intervalString)"
                }
        if indexPath.row % 2 == 0 {
                        cell.contentView.backgroundColor = UIColor(red:0.04, green:0.41, blue:0.49, alpha:1.0)
                    } else {
                        cell.contentView.backgroundColor = UIColor(red:0.03, green:0.38, blue:0.49, alpha:1.0)
                    }
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year,.month,.weekOfMonth,.day,.hour,.minute,.second]
        dateComponentsFormatter.maximumUnitCount = 1
        dateComponentsFormatter.unitsStyle = .full
        dateComponentsFormatter.string(from: Date(), to: Date(timeIntervalSinceNow: 4000000))  // "1 month"
        tableView.reloadData()
        
    }
    
    func inBackground() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskIdentifier.invalid)
    }
    
    func endBackgroundTask() {
    UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskIdentifier.invalid
    }
    
    @objc func updateTimer(){
        
        seconds += 1
        if seconds == 60 {
            seconds = 0
            minutes += 1
        }
        
        let secStr: String = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minStr: String = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        contractionTimer.text = "\(minStr):\(secStr)"
    }

    

}

extension Date {
    
   
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 {
            let remainingSeconds = seconds(from: date) - 60 * (minutes(from: date))
            return "\(minutes(from: date))m \(remainingSeconds)s"
        }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}

