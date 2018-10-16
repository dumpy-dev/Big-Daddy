//
//  IntroScreenViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 12/08/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class IntroScreenViewController: UIViewController, UITextFieldDelegate {

    
    // Setup outlets
    
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var mothersName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var mothersTick: UIImageView!
    @IBOutlet weak var dueDateTick: UIImageView!
    @IBAction func skipPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "introSegue", sender: self)
        
    }
    @IBAction func donePressed(_ sender: Any) {
         performSegue(withIdentifier: "introSegue", sender: self)
        
UserDefaults.standard.set(mothersName.text, forKey: "mother")
        
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
        
             print("\(mothersName.text)'s due date is \(calculatedDueDate!) which means she is \(weeksElapsed) weeks along")
        
                    if weeksLeft >= 40 {
        
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
//                    print("\(motherNameEntered.text) is \(weeksElapsed) weeks and \(remainderDaysElapsed) days along!")
        
        
        
        
        
                    if weeksLeft >= 40 {
        
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
                    }
        
        
        
                }
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
        func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(IntroScreenViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
    
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        self.mothersName.delegate = self
        hideKeyboardWhenTappedAround()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
                return .lightContent
            }
}






//
//    var dueDate = Date()


//
//
//
//
//
//
//
//
//        if mothersName?.isEmpty == false {
//            UserDefaults.standard.set(mothersName, forKey: "mother")
//            motherNameEntered.placeholder = mothersName
//            motherNameEntered.text = nil
//        }
//
//        if babysName?.isEmpty == false {
//            UserDefaults.standard.set(babysName, forKey: "baby")
//            babyNameEntered.placeholder = babysName
//            babyNameEntered.text = nil
//        }
//
//
//
//
//
//    }
//
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        motherNameEntered.placeholder = UserDefaults.standard.object(forKey: "mother") as? String
//        babyNameEntered.placeholder = UserDefaults.standard.object(forKey: "baby") as? String
//

//
//        self.motherNameEntered.delegate = self
//        self.babyNameEntered.delegate = self
//
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//
//
//
//
//    @IBAction func dueDatePicked(_ sender: UIDatePicker) {
//
//        // Dates are calculated according to either the date of the last period or the known Due Date
//        // dateSwitch isOn calculates according to last period
//
//        //        if dateSwitch.isOn {
//        //
//        //            let daysToAdd = 280
//        //
//        //            let calculatedDueDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: sender.date)
//        //
//        //            let now = Date()
//        //            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate!).day
//        //            let weeksLeft : Int = diffInDays!/7
//        //            let weeksElapsed : Int = 40 - weeksLeft
//        //            let remainderDays : Int = diffInDays!%7
//        //            let remainderDaysElapsed : Int = 7 - remainderDays
//        //
//        //            print("\(motherNameEntered.text)'s due date is \(calculatedDueDate!) which means she is \(weeksElapsed) weeks along")
//        //
//        //            UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
//        //            UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
//        //         UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
//        //
//        //
//        //
//        ////            let due = UserDefaults.standard.object(forKey: "DueDate")
//        ////            print("This date has been saved to the default settings: \(due)")
//        //
//        //        } else {
//        //
//        //            // This calculates the time until the baby is born from a known due date
//        //            datePicker.minimumDate = Date()
//        //
//        //            // The number of days elapsed is calculated
//        //            let now = Date()
//        //            let calculatedDueDate = sender.date
//        //
//        //            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate).day
//        //
//        //
//        //            // The number of weeks and days is calculated from the number of days
//        //
//        //            let weeksLeft : Int = diffInDays!/7
//        //            let remainderDays : Int = diffInDays!%7
//        //            print("You have \(weeksLeft) weeks and \(remainderDays) days to go!")
//        //
//        //            // The number of weeks and days that have elapsed are calculated
//        //
//        //            let weeksElapsed : Int = 40 - weeksLeft
//        //            let remainderDaysElapsed : Int = 7 - remainderDays
//        //            print("\(motherNameEntered.text) is \(weeksElapsed) weeks and \(remainderDaysElapsed) days along!")
//        //
//        //
//        //            UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
//        //            UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
//        //         UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
//        //
//        //
//        //            if diffInDays! >= 560 {
//        //
//        //                let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be more than 9 months away...", preferredStyle: UIAlertControllerStyle.alert)
//        //
//        //                alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertActionStyle.default, handler: nil))
//        //                self.present(alertController, animated: true, completion: nil)
//        //
//        //
//        //
//        //                print("unacceptable!!")
//        //            }
//        //
//        //
//        //
//        //        }
//        //
//        //
//    }
//
//
//    override func viewWillAppear(_ animated: Bool) {
//        if let previouslyEnteredDate = UserDefaults.standard.object(forKey: "dateEntered") {
//            self.datePicker.setDate(previouslyEnteredDate as! Date, animated: true)
//        }
//    }
//

