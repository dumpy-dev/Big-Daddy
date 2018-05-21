//
//  ContractionCounterViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 12/05/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class ContractionCounterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    // Add outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerTable: UITableView!

    // Arrays set up
    var realTimeArray : [Date] = []
    var contractionTimeArray : [Int] = []
    var gapTimeArray : [Int] = []
    
    var seconds = 0
    var secondarySeconds = 0
    var timer = Timer()
    var isTimerRunning = false
    var isSecondaryTimerRunning = false
    
    
    // Timer functions set up
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ContractionCounterViewController.updateTimer)), userInfo: nil, repeats: true)
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
        //timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    
    @IBAction func startPressed(_ sender: AnyObject) {
        
        if isTimerRunning == false {
            
           timer.invalidate()
     runTimer()
            sender.setTitle("STOP", for: [])
            isSecondaryTimerRunning = false
            gapTimeArray.append(secondarySeconds)
            secondarySeconds = 0
           
            
        } else if isTimerRunning == true {
            
            
            contractionTimeArray.append(seconds)
            sender.setTitle("START", for: [])
            isTimerRunning = false
            timer.invalidate()
            runSecondaryTimer()
            seconds = 0
             realTimeArray.append(Date())
            
            timerTable.reloadData()
            timerLabel.text = "00:00:00"
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realTimeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContractionCounterTableViewCell


        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        
        cell.realTimeLabel!.text = "\(dateFormatter.string(from: realTimeArray[indexPath.row] ))"
        cell.contractionTimeLabel!.text = "\(contractionTimeArray[indexPath.row]) sec"
       
        
        if indexPath.row == 0 {
            cell.contractionGapLabel!.text = "0"
        } else {
            cell.contractionGapLabel!.text = "\(gapTimeArray[indexPath.row]) sec"
        }
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor(red:0.04, green:0.41, blue:0.49, alpha:1.0)
        } else {
            cell.contentView.backgroundColor = UIColor(red:0.03, green:0.38, blue:0.49, alpha:1.0)
        }
        return cell
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class ContractionCounterTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var realTimeLabel: UILabel!
    @IBOutlet weak var contractionTimeLabel: UILabel!
    @IBOutlet weak var contractionGapLabel: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
