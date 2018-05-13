//
//  ContractionCounterViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 12/05/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class ContractionCounterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerTable: UITableView!

    var timer = Timer()
    var time = 1
    var timerIsRunning : Bool = false
    
    @objc func increaseTimer() {
            time += 1
            timerLabel.text = String(time)
        timerIsRunning = true
        }
        
    
    
    
    
    @IBAction func startPressed(_ sender: AnyObject) {
        
        if timerIsRunning == false {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ContractionCounterViewController.increaseTimer), userInfo: nil, repeats: true)
            sender.setTitle("STOP", for: [])
        } else {
            sender.setTitle("START", for: [])
            timer.invalidate()
            timerIsRunning = false
        }
        
    }
    
    
        
        
    

    
    
//
//    let stopwatch = Stopwatch()
//
//
//    @IBAction func startPressed(_ sender: UIButton) {
//        Timer.scheduledTimer(timeInterval: 0.1, target: self,
//                             selector: #selector(ContractionCounterViewController.updateElapsedTimeLabel(_:)), userInfo: nil, repeats: true)
//        stopwatch.start()
//    }
//
//    @IBAction func stopButtonTapped(_ sender: UIButton) {
//        stopwatch.stop()
//    }
//
//    @objc func updateElapsedTimeLabel(_ timer: Timer) {
//        if stopwatch.isRunning {
//            timerLabel.text = stopwatch.elapsedTimeAsString
//            print(stopwatch.elapsedTimeAsString)
//        } else {
//            timer.invalidate()
//        }
//    }
//
//
//
//
//
//
    
//
//    var seconds = 60
//    var contractionTimer = Timer()
//    var isTimerRunning = false
//
//    @IBAction func startPressed(_ sender: UIButton) {
//        runTimer()
//    }
//
//
//
//
//    func runTimer() {
//        contractionTimer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ContractionCounterViewController.updateTimer)), userInfo: nil, repeats: true)
//        isTimerRunning = true
//    }
//
//    @objc func updateTimer() {
//        seconds -= 1     //This will decrement(count down)the seconds.
//        timer.text = "\(seconds)" //This will update the label.
//    }
    
   
    
    
    
    
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contractionCounterCell") as! ContractionCounterTableViewCell
//        let article: Article
//        if isFiltering() {
//            article = filteredArticles[indexPath.row]
//        } else {
//            article = articlesArray[indexPath.row]
//        }
//        cell.articleLabel!.text = article.name
        
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
