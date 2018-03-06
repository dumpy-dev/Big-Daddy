//
//  SettingsViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 05/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var dueDate = Date()
    var weeksElapsed : Int = 0
    
    @IBOutlet weak var userNameEntered: UITextField!
    @IBOutlet weak var motherNameEntered: UITextField!
    @IBOutlet weak var babyNameEntered: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    
    @IBAction func dueDatePicked(_ sender: UIDatePicker) {
        
     // The number of days elapsed is calculated
        let now = Date()
        let dueDate = sender.date

        let diffInDays = Calendar.current.dateComponents([.day], from: now, to: dueDate).day
        
        print("There are \(diffInDays) days until the baby is born!")
        
        // The number of weeks and days is calculated from the number of days
        
        let weeksLeft : Int = diffInDays!/7
        let remainderDays : Int = diffInDays!%7
        print("You have \(weeksLeft) weeks and \(remainderDays) days to go!")
        
        // The number of weeks and days that have elapsed are calculated
        
        let weeksElapsed : Int = 40 - weeksLeft
        let remainderDaysElapsed : Int = 7 - remainderDays
        print("Your partner is \(weeksElapsed) weeks and \(remainderDaysElapsed) days along!")
        }
    

    
    
    @IBAction func sexPicked(_ sender: UISegmentedControl) {
    
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    @IBAction func unitPicked(_ sender: UISegmentedControl) {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    


}
