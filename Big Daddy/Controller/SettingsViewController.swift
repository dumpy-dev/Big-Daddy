//
//  SettingsViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 05/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    var dueDate = Date()
    
    // Setup IBOutlets
    @IBOutlet weak var motherNameEntered: UITextField!
    @IBOutlet weak var babyNameEntered: UITextField!
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // Setup Reset fuction

    @IBAction func resetPressed(_ sender: Any) {
       
        let alertController = UIAlertController(title: "Reset", message: "Are you sure you want to reset everything?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Reset", style: UIAlertActionStyle.default){
            UIAlertAction in
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
           let daysToSubtract = -280
//            let dueDate = Calendar.current.date(byAdding: .day, value: 14, to: Date())
let dueDate = Date()
            UserDefaults.standard.set(dueDate, forKey: "DueDate")
            
            
            self.datePicker.setDate(Date() as Date, animated: true)
            self.motherNameEntered.placeholder = nil
            self.motherNameEntered.text = nil
            self.babyNameEntered.placeholder = nil
            self.babyNameEntered.text = nil
            
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        }
    
    @IBAction func donePressed(_ sender: Any) {
        let mothersName = motherNameEntered.text
        let babysName = babyNameEntered.text
        print("the selected date is \(self.datePicker.date)")

        if dateSwitch.isOn {
            
            datePicker.minimumDate = nil
            let daysToAdd = 280
            let calculatedDueDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: datePicker.date)
            let now = Date()
            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate!).day
            let weeksLeft : Int = diffInDays!/7
            let weeksElapsed : Int = 40 - weeksLeft
            let remainderDays : Int = diffInDays!%7
            let remainderDaysElapsed : Int = 7 - remainderDays
            
            print("\(motherNameEntered.text)'s due date is \(calculatedDueDate!) which means she is \(weeksElapsed) weeks along")
            
            if weeksLeft >= 40 {
                
                let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be more than 9 months away, Einstein", preferredStyle: UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                
                self.datePicker.setDate(Date() as Date, animated: true)
                
                
            } else {
                let dateEntered = datePicker.date
                UserDefaults.standard.set(dateEntered, forKey: "dateEntered")
                UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
                UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
                UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
            }
            
            //            let due = UserDefaults.standard.object(forKey: "DueDate")
            //            print("This date has been saved to the default settings: \(due)")
            
        } else {
            
            // This calculates the time until the baby is born from a known due date
            datePicker.minimumDate = Date()
            
            // The number of days elapsed is calculated
            let now = Date()
            let calculatedDueDate = datePicker.date
            
            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate).day
            
            
            // The number of weeks and days is calculated from the number of days
            
            let weeksLeft : Int = diffInDays!/7
            let remainderDays : Int = diffInDays!%7
            print("You have \(weeksLeft) weeks and \(remainderDays) days to go!")
            
            // The number of weeks and days that have elapsed are calculated
            
            let weeksElapsed : Int = 40 - weeksLeft
            let remainderDaysElapsed : Int = 7 - remainderDays
            print("\(motherNameEntered.text) is \(weeksElapsed) weeks and \(remainderDaysElapsed) days along!")
            
            
            
            
            
            if weeksLeft >= 40 {

                let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be more than 9 months away, Einstein", preferredStyle: UIAlertControllerStyle.alert)

                alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)

self.datePicker.setDate(Date() as Date, animated: true)

                
            } else {
                let dateEntered = datePicker.date
                UserDefaults.standard.set(dateEntered, forKey: "dateEntered")
                UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
                UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
                UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
            }
            
            
            
        }
        
        
        
        
        
        
        
        if mothersName?.isEmpty == false {
    UserDefaults.standard.set(mothersName, forKey: "mother")
        motherNameEntered.placeholder = mothersName
        motherNameEntered.text = nil
        }
        
        if babysName?.isEmpty == false {
        UserDefaults.standard.set(babysName, forKey: "baby")
        babyNameEntered.placeholder = babysName
        babyNameEntered.text = nil
        }
        
        
        
        
        
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motherNameEntered.placeholder = UserDefaults.standard.object(forKey: "mother") as? String
        babyNameEntered.placeholder = UserDefaults.standard.object(forKey: "baby") as? String
        
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        self.motherNameEntered.delegate = self
        self.babyNameEntered.delegate = self

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
  
    
 
    
    @IBAction func dueDatePicked(_ sender: UIDatePicker) {
        
        // Dates are calculated according to either the date of the last period or the known Due Date
        // dateSwitch isOn calculates according to last period
        
//        if dateSwitch.isOn {
//
//            let daysToAdd = 280
//
//            let calculatedDueDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: sender.date)
//
//            let now = Date()
//            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate!).day
//            let weeksLeft : Int = diffInDays!/7
//            let weeksElapsed : Int = 40 - weeksLeft
//            let remainderDays : Int = diffInDays!%7
//            let remainderDaysElapsed : Int = 7 - remainderDays
//
//            print("\(motherNameEntered.text)'s due date is \(calculatedDueDate!) which means she is \(weeksElapsed) weeks along")
//
//            UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
//            UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
//         UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
//
//
//
////            let due = UserDefaults.standard.object(forKey: "DueDate")
////            print("This date has been saved to the default settings: \(due)")
//
//        } else {
//
//            // This calculates the time until the baby is born from a known due date
//            datePicker.minimumDate = Date()
//
//            // The number of days elapsed is calculated
//            let now = Date()
//            let calculatedDueDate = sender.date
//
//            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate).day
//
//
//            // The number of weeks and days is calculated from the number of days
//
//            let weeksLeft : Int = diffInDays!/7
//            let remainderDays : Int = diffInDays!%7
//            print("You have \(weeksLeft) weeks and \(remainderDays) days to go!")
//
//            // The number of weeks and days that have elapsed are calculated
//
//            let weeksElapsed : Int = 40 - weeksLeft
//            let remainderDaysElapsed : Int = 7 - remainderDays
//            print("\(motherNameEntered.text) is \(weeksElapsed) weeks and \(remainderDaysElapsed) days along!")
//
//
//            UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
//            UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
//         UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
//
//
//            if diffInDays! >= 560 {
//
//                let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be more than 9 months away...", preferredStyle: UIAlertControllerStyle.alert)
//
//                alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertActionStyle.default, handler: nil))
//                self.present(alertController, animated: true, completion: nil)
//
//
//
//                print("unacceptable!!")
//            }
//
//
//
//        }
//
//
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let previouslyEnteredDate = UserDefaults.standard.object(forKey: "dateEntered") {
        self.datePicker.setDate(previouslyEnteredDate as! Date, animated: true)
        }
    }
    
    
    @IBAction func sexPicked(_ sender: UISegmentedControl) {
    
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        
        let babySex = sender.selectedSegmentIndex
        UserDefaults.standard.set(babySex, forKey: "BabySex")
        print(UserDefaults.standard.object(forKey: "BabySex"))
        
    }
    

}
