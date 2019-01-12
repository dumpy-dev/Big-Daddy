//
//  SettingsViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 05/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit
import RealmSwift

class SettingsViewController: UIViewController, UITextFieldDelegate {

    var dueDate = Date()
    let realm = try! Realm()
    
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
        let alertController = UIAlertController(title: "Reset", message: "Are you sure you want to reset everything?", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "Reset", style: UIAlertAction.Style.default){
                    UIAlertAction in
                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                    UserDefaults.standard.synchronize()
                        try! self.realm.write {
                            self.realm.deleteAll()
                        }
                    self.datePicker.setDate(Date() as Date, animated: true)
                    self.motherNameEntered.placeholder = nil
                    self.motherNameEntered.text = nil
                    self.babyNameEntered.placeholder = nil
                    self.babyNameEntered.text = nil
                })
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func donePressed(_ sender: Any) {
        let mothersName = motherNameEntered.text
        let babysName = babyNameEntered.text

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
            
            //TODO:- this isn't working!
            
            if weeksLeft >= 40 {
                let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be more than 9 months away, Einstein", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                self.datePicker.setDate(Date() as Date, animated: true)
            } else if weeksLeft < 0 {
                let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be more than 9 months away, Einstein", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                self.datePicker.setDate(Date() as Date, animated: true)
            } else {
                let dateEntered = datePicker.date
              UserDefaults.standard.set(dateEntered, forKey: "dateEntered")
                UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
            UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
               UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
                  tabBarController?.selectedIndex = 0
            }
            
            //            let due = UserDefaults.standard.object(forKey: "DueDate")
            //            print("This date has been saved to the default settings: \(due)")
            
        } else {
            
            // This calculates the time until the baby is born from a known due date
            let now = Date()
            let calculatedDueDate = datePicker.date
            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate).day
            let weeksLeft : Int = diffInDays!/7
            let remainderDays : Int = diffInDays!%7
            let weeksElapsed : Int = 40 - weeksLeft
            let remainderDaysElapsed : Int = 7 - remainderDays
                if weeksLeft >= 40 {
                    let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be more than 9 months away, Einstein", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    self.datePicker.setDate(Date() as Date, animated: true)
                } else if weeksLeft < 0 {
                    let displayWeeksLeft = -(weeksLeft)
                    print("this many weeks left: \(displayWeeksLeft)")
                    if weeksLeft >= -1 {
                    let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be in the past!", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    self.datePicker.setDate(Date() as Date, animated: true)
                    } else {
                        let alertController = UIAlertController(title: "Due Date", message: "Your baby should have been born \(displayWeeksLeft) weeks ago. Call a midwife!", preferredStyle: UIAlertController.Style.alert)
                        alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                        self.datePicker.setDate(Date() as Date, animated: true)
                    }
                } else {
                    let dateEntered = datePicker.date
                    UserDefaults.standard.set(dateEntered, forKey: "dateEntered")
                    UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
                    UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
                    UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
                    tabBarController?.selectedIndex = 0
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
            if let previouslyEnteredDueDate = UserDefaults.standard.object(forKey: "DueDate") {
                self.datePicker.setDate(previouslyEnteredDueDate as! Date, animated: false)
            } else {
                self.datePicker.setDate(Date(), animated: false)
        }
        
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
    }
  
}





//    override func viewWillAppear(_ animated: Bool) {
//        if let previouslyEnteredDate = UserDefaults.standard.object(forKey: "dateEntered") {
//        self.datePicker.setDate(previouslyEnteredDate as! Date, animated: true)
//        }
//    }
