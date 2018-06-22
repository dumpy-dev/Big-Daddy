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
    // WeeksElapsed - the number of week elapsed
    
    
    @IBOutlet weak var userNameEntered: UITextField!
    @IBOutlet weak var motherNameEntered: UITextField!
    @IBOutlet weak var babyNameEntered: UITextField!
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func resetPressed(_ sender: Any) {
       
        let alertController = UIAlertController(title: "Reset", message: "Are you sure you want to reset everything?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Reset", style: UIAlertActionStyle.default){
            UIAlertAction in
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            
            self.datePicker.setDate(Date() as Date, animated: true)
            
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        }
    
    @IBAction func donePressed(_ sender: Any) {
        
        let mothersName = motherNameEntered.text
        let babysName = babyNameEntered.text
        
    UserDefaults.standard.set(mothersName, forKey: "mother")
        UserDefaults.standard.set(babysName, forKey: "baby")
        
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        if let due = UserDefaults.standard.object(forKey: "DueDate"){
            datePicker.setDate(UserDefaults.standard.object(forKey: "DueDate") as! Date, animated: true)
        } else {
            let due = Date()
            print("no date has been entered yet")
        }
        
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
        
            let calculatedDueDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: sender.date)
            
            let now = Date()
            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate!).day
            let weeksLeft : Int = diffInDays!/7
            let weeksElapsed : Int = 40 - weeksLeft
            let remainderDays : Int = diffInDays!%7
            let remainderDaysElapsed : Int = 7 - remainderDays
           
            print("\(motherNameEntered.text)'s due date is \(calculatedDueDate!) which means she is \(weeksElapsed) weeks along")
        
            UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
            UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
         UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
            
            
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
            UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
         UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
        }
        
        
    }
    
    
    
   
    
   
    
    
    
    
    @IBAction func sexPicked(_ sender: UISegmentedControl) {
    
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        
        let babySex = sender.selectedSegmentIndex
        UserDefaults.standard.set(babySex, forKey: "BabySex")
        print(UserDefaults.standard.object(forKey: "BabySex"))
        
    }
    
    @IBAction func unitPicked(_ sender: UISegmentedControl) {
       
        let unitPicked = sender.selectedSegmentIndex
        
         UserDefaults.standard.set(unitPicked, forKey: "Unit")
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    


}
