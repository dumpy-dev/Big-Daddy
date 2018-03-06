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
    
    @IBOutlet weak var dateSwitch: UISwitch!
    
 
    
    @IBAction func dueDatePicked(_ sender: UIDatePicker) {
        
        // Dates are calculated according to either the date of the last period or the known Due Date
        // dateSwitch isOn calculates according to last period
        
        if dateSwitch.isOn {
            
            let daysToAdd = 280
        
        let calculatedDueDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: sender.date)
            
            let now = Date()
            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate!).day
            let weeksLeft : Int = diffInDays!/7
            let weeksElapsed : Int = 40 - weeksLeft
           
            print("Your partner's due date is \(calculatedDueDate!) which means your partner is \(weeksElapsed) weeks along")
        
        } else {
            
            // This calculates the time until the baby is born from a known due date
            
            // The number of days elapsed is calculated
            let now = Date()
            let dueDate = sender.date
            
            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: dueDate).day
            

            // The number of weeks and days is calculated from the number of days
            
            let weeksLeft : Int = diffInDays!/7
            let remainderDays : Int = diffInDays!%7
            print("You have \(weeksLeft) weeks and \(remainderDays) days to go!")
            
            // The number of weeks and days that have elapsed are calculated
            
            let weeksElapsed : Int = 40 - weeksLeft
            let remainderDaysElapsed : Int = 7 - remainderDays
            print("Your partner is \(weeksElapsed) weeks and \(remainderDaysElapsed) days along!")
            
        }
    }
    

    
    
    @IBAction func sexPicked(_ sender: UISegmentedControl) {
    
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    @IBAction func unitPicked(_ sender: UISegmentedControl) {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    


}
