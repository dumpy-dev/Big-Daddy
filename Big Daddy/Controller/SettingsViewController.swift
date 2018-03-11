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
    
    //Keys for UserDefaults:
    // DueDate - the due date as entered or as calculated from last period
    
    
    @IBOutlet weak var userNameEntered: UITextField!
    @IBOutlet weak var motherNameEntered: UITextField!
    @IBOutlet weak var babyNameEntered: UITextField!
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func resetPressed(_ sender: Any) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // let due = UserDefaults.standard.object(forKey: "DueDate")
        // print("This date has been retrieved from the default settings: \(due)")
        
     // datePicker.setDate(UserDefaults.standard.object(forKey: "DueDate") as! Date, animated: true)
        
      // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
 
    
    @IBAction func dueDatePicked(_ sender: UIDatePicker) {
        
        // Dates are calculated according to either the date of the last period or the known Due Date
        // dateSwitch isOn calculates according to last period
        
        if dateSwitch.isOn {
            
            let daysToAdd = 280
        
        var calculatedDueDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: sender.date)
            
            let now = Date()
            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate!).day
            let weeksLeft : Int = diffInDays!/7
            let weeksElapsed : Int = 40 - weeksLeft
           
            print("\(motherNameEntered.text)'s due date is \(calculatedDueDate!) which means she is \(weeksElapsed) weeks along")
        
            UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
            
//            let due = UserDefaults.standard.object(forKey: "DueDate")
//            print("This date has been saved to the default settings: \(due)")
            
        } else {
            
            // This calculates the time until the baby is born from a known due date
            
            // The number of days elapsed is calculated
            let now = Date()
            let calculatedDueDate = sender.date
            
            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate).day
            

            // The number of weeks and days is calculated from the number of days
            
            let weeksLeft : Int = diffInDays!/7
            let remainderDays : Int = diffInDays!%7
            print("You have \(weeksLeft) weeks and \(remainderDays) days to go!")
            
            // The number of weeks and days that have elapsed are calculated
            
            let weeksElapsed : Int = 40 - weeksLeft
            let remainderDaysElapsed : Int = 7 - remainderDays
            print("\(motherNameEntered.text) is \(weeksElapsed) weeks and \(remainderDaysElapsed) days along!")
            
            
            UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
            
            
        }
        
        
    }
    
    
    
   
    
   
    
    
    
    
    @IBAction func sexPicked(_ sender: UISegmentedControl) {
    
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    @IBAction func unitPicked(_ sender: UISegmentedControl) {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    


}
