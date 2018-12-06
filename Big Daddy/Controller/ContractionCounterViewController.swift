//
//  ContractionCounterViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 12/05/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit
import RealmSwift

class ContractionCounterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    // MARK:- Outlets and Variables added
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerTable: UITableView!
    @IBOutlet weak var strengthSlider: UISlider!
    @IBAction func strengthSlinder(_ sender: Any) {
        let strength = Int(strengthSlider.value)
            strengthLabel.text = "\(strength)"
    }
    @IBOutlet weak var strengthLabel: UILabel!
    var seconds = 0
    var secondarySeconds = 0
    var timer = Timer()
    var isTimerRunning = false
    var isSecondaryTimerRunning = false
    var min = 0
    var sec = 0
    var diffMins = 0
    var diffSecs = 0
   
    // MARK:- Realm setup
    let realm = try! Realm()
    var timerData:Results<ContractionCounterRealm> {
        get {
            return realm.objects(ContractionCounterRealm.self)
        }
    }
    var intervalData:Results<ContractionCounterIntervalRealm> {
        get {
            return realm.objects(ContractionCounterIntervalRealm.self)
        }
    }

    
    // MARK:- Timer functions set up
    func runTimer() {

        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ContractionCounterViewController.updateLabels(t:))), userInfo: nil, repeats: true)
         isTimerRunning = true
    }
    
    func runSecondaryTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ContractionCounterViewController.updateSecondaryTimer)), userInfo: nil, repeats: true)
        isSecondaryTimerRunning = true
    }
    
    @objc func updateTimer() {
        seconds += 1
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    @objc func updateSecondaryTimer() {
        secondarySeconds += 1
        
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
  @objc func pauseWhenBackground() {
   // if isTimerRunning == true {
        self.timer.invalidate()
        let strengthOfContraction = strengthSlider.value
        let shared = UserDefaults.standard
        shared.set(Date(), forKey: "savedTime")
        shared.set(strengthOfContraction, forKey: "strengthOfContraction")
        print("This is the saved time: \(Date())")
        print("this is the saved strength: \(UserDefaults.standard.object(forKey: "strengthOfContraction"))")
 //   }
    }
    
  @objc func willEnterForeground() {

    if isTimerRunning == true {
    if let savedDate = UserDefaults.standard.object(forKey: "savedTime") as? Date {
            (diffMins, diffSecs) = ContractionCounterViewController.getTimeDifference(startDate: savedDate)
            self.refresh(mins: diffMins, secs: diffSecs)
        }
        if let savedStrength = UserDefaults.standard.object(forKey: "strengthOfContraction") {
//            (diffMins, diffSecs) = ContractionCounterViewController.getTimeDifference(startDate: savedDate)
//            self.refresh(mins: diffMins, secs: diffSecs)
            strengthSlider.value = savedStrength as! Float
        }
    }
    //TODO:- add code here to update secondary contraction gap timer values on entering foreground
    }
    
    
    @objc func updateLabels(t: Timer) {
        
        if (self.sec == 59) {
            self.min += 1
            self.sec = 0
        } else {
            self.sec += 1
        }
        self.timerLabel.text = String(format: "%02i:%02i", self.min, self.sec)
    }
    
    static func getTimeDifference(startDate: Date) -> (Int, Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .second], from: startDate, to: Date())
        return(components.minute!, components.second!)
    }
    
    func refresh (mins: Int, secs: Int) {
       
        self.min += mins
        self.sec += secs
        self.timerLabel.text = String(format: "%02i:%02i", self.min, self.sec)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ContractionCounterViewController.updateLabels(t:))), userInfo: nil, repeats: true)
    }
    
    // Button actions
    
    @IBAction func stopPressed(_ sender: Any) {
        
        
        if isTimerRunning == true {
            self.timer.invalidate()
            min = 0
            sec = 0
            let timerItem = ContractionCounterRealm()
            timerItem.timeOfDay = Date()
            timerItem.lengthOfContraction = timerLabel.text!
            timerItem.strengthOfContraction = Int(strengthSlider.value)
            try! self.realm.write({
                self.realm.add(timerItem)
            })
            isTimerRunning = false
           
            runSecondaryTimer()
            timerTable.reloadData()
            timerLabel.text = "00:00"
            strengthSlider.value = 0
            strengthLabel.text = "0"
        } else {
            print("timer is already stopped")
        }
    }
    
    @IBAction func startPressed(_ sender: AnyObject) {
        
            timer.invalidate()
            runTimer()
            let timerItem = ContractionCounterIntervalRealm()
        print("\(secondarySeconds)")
        timerItem.interval = secondarySeconds
            try! self.realm.write({
                self.realm.add(timerItem)
            })
            isSecondaryTimerRunning = false
            secondarySeconds = 0
        }
    
    
    
    @IBAction func resetPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Reset", message: "This will reset all of your contraction times. Are you sure?", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Reset", style: UIAlertAction.Style.default){
            UIAlertAction in
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            
            let times = self.realm.objects(ContractionCounterRealm.self)
                try! self.realm.write ({
                    self.realm.delete(times)
                })
            
            let intervals = self.realm.objects(ContractionCounterIntervalRealm.self)
            try! self.realm.write ({
                self.realm.delete(intervals)
            })

            self.isTimerRunning = false
            self.timer.invalidate()
            self.seconds = 0
            self.min = 0
            self.sec = 0
            //self.realTimeArray.append(Date())
            self.timerTable.reloadData()
            self.timerLabel.text = "00:00"
//            self.realTimeArray = []
//            self.contractionTimeArray  = []
//            self.gapTimeArray = []
            self.timerTable.reloadData()
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
 
    
    // MARK:- View loading, appearing and disappearing functions
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(pauseWhenBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(_ animated: Bool) {
        willEnterForeground()
    }
    override func viewDidDisappear(_ animated: Bool) {
        pauseWhenBackground()
    }
    
    // MARK:- Setup the table for displaying results
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timerData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContractionCounterTableViewCell
        let time = timerData[indexPath.row]
        let interval = intervalData[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        cell.realTimeLabel.text = "\(dateFormatter.string(from: time.timeOfDay! ))"
         cell.contractionTimeLabel!.text = "\(time.lengthOfContraction) s"
        cell.contractionStrengthLabel!.text = "\(time.strengthOfContraction)"
        if indexPath.row == 0 {
            cell.contractionGapLabel!.text = "-"
        } else {
            let intervalSeconds = interval.interval
            let minutes = intervalSeconds/60
            let remainderSeconds = intervalSeconds % 60
            print("\(minutes)m and \(remainderSeconds)s")
            cell.contractionGapLabel!.text = ("\(minutes)m\(remainderSeconds)s")
        }
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor(red:0.04, green:0.41, blue:0.49, alpha:1.0)
        } else {
            cell.contentView.backgroundColor = UIColor(red:0.03, green:0.38, blue:0.49, alpha:1.0)
        }
        return cell
    }

}

class ContractionCounterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var realTimeLabel: UILabel!
    @IBOutlet weak var contractionTimeLabel: UILabel!
    @IBOutlet weak var contractionGapLabel: UILabel!

    @IBOutlet weak var contractionStrengthLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
