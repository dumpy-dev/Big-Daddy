//
//  SettingsViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 05/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit
import RealmSwift
import SAConfettiView

class SettingsViewController: UIViewController, UITextFieldDelegate {

    
    var dueDate = Date()
    let realm = try! Realm()
    var fullVersionUnlocked = UserDefaults.standard.bool(forKey: "fullVersionUnlocked")
    // var fullVersionUnlocked = true
    // var fullVersionUnlocked = false
 
    @IBOutlet weak var motherNameEntered: UITextField!
    @IBOutlet weak var babyNameEntered: UITextField!
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var genderSelector: UISegmentedControl!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func genderSelected(_ sender: Any) {
        let confettiView = SAConfettiView(frame: self.view.bounds)
        confettiView.type = .Star
        func runConfetti(){
            self.view.addSubview(confettiView)
            confettiView.startConfetti()
            UIView.animate(withDuration: 2.5) {
                confettiView.alpha = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                confettiView.stopConfetti()
                confettiView.removeFromSuperview()
            }
        }
        switch genderSelector.selectedSegmentIndex {
            case 0:
                confettiView.colors = [UIColor(red:1.00, green:0.95, blue:0.95, alpha:1.0),UIColor(red:0.96, green:0.66, blue:0.65, alpha:1.0), UIColor(red:1.00, green:0.94, blue:1.00, alpha:1.0)]
                runConfetti()
            case 1:
                confettiView.colors = [UIColor(red:0.69, green:0.88, blue:0.90, alpha:1.0), UIColor(red:0.34, green:0.63, blue:0.92, alpha:1.0), UIColor(red:0.54, green:0.72, blue:0.70, alpha:1.0)]
                runConfetti()
        case 2:
               break
            default:
                break
        }
    }
    
    @IBAction func upgradePressed(_ sender: Any) {
        performSegue(withIdentifier: "settingsUpgradeSegue", sender: self)
    }
    @IBAction func restorePressed(_ sender: Any) {
        performSegue(withIdentifier: "settingsUpgradeSegue", sender: self)
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
                datePicker.datePickerMode = UIDatePicker.Mode.date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy"
                let selectedDate = dateFormatter.string(from: datePicker.date)
                print(selectedDate)
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
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
            if let previouslyEnteredDueDate = UserDefaults.standard.object(forKey: "DueDate") {
                self.datePicker.setDate(previouslyEnteredDueDate as! Date, animated: false)
            } else {
                self.datePicker.setDate(Date(), animated: false)
            }
        self.motherNameEntered.delegate = self
        self.babyNameEntered.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if fullVersionUnlocked == false {
            motherNameEntered.placeholder = "Upgrade to unlock!"
            motherNameEntered.isEnabled = false
            babyNameEntered.placeholder = "Upgrade to unlock!"
            babyNameEntered.isEnabled = false
        } else {
            
            motherNameEntered.placeholder = UserDefaults.standard.object(forKey: "mother") as? String
            babyNameEntered.placeholder = UserDefaults.standard.object(forKey: "baby") as? String
        }
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

