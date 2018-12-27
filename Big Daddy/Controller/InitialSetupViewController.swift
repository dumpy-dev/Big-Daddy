//
//  InitialSetupViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 06/11/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class InitialSetupViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var pageControl = UIPageControl()
    
    // MARK: UIPageViewControllerDataSource
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "setupVC1"),
                self.newVc(viewController: "setupVC2"),
                self.newVc(viewController: "setupVC3"),
                self.newVc(viewController: "setupVC4"),
                self.newVc(viewController: "setupVC5"),
                self.newVc(viewController: "setupVC6")]
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        configurePageControl()
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor(red:0.93, green:0.93, blue:0.92, alpha:1.0)
        self.pageControl.currentPageIndicatorTintColor = UIColor(red:0.18, green:0.22, blue:0.25, alpha:1.0)
        self.view.addSubview(pageControl)
    }
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    // MARK: Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    
}

class setupVC1 : UIViewController {
    @IBAction func skipButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "skipSegue", sender: self)
        
    }
    
}

class setupVC5 : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var partnersName: UITextField!
    @IBAction func partnersNameEntered(_ sender: Any) {
        UserDefaults.standard.set(partnersName.text, forKey: "mother")
    }
    
    override func viewDidLoad() {
        partnersName.delegate = self
    }
    
    func textFieldShouldReturn(_ partnersName: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
}

class setupVC6 : UIViewController {
    
    @IBOutlet weak var dueDateSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePicked(_ sender: Any) {
    }
    override func viewDidLoad() {
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        
        if dueDateSwitch.isOn {
            datePicker.minimumDate = nil
            let daysToAdd = 280
            let calculatedDueDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: datePicker.date)
            let now = Date()
            let diffInDays = Calendar.current.dateComponents([.day], from: now, to: calculatedDueDate!).day
            let weeksLeft : Int = diffInDays!/7
            let weeksElapsed : Int = 40 - weeksLeft
            let remainderDays : Int = diffInDays!%7
            let remainderDaysElapsed : Int = 7 - remainderDays
         
            if weeksLeft >= 40 {
                let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be more than 9 months away, Einstein", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                self.datePicker.setDate(Date() as Date, animated: true)
            } else if remainderDays < 0 || weeksLeft < 0 {
                
                print("this are \(remainderDaysElapsed) remaninder days left")
                let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be in the past", preferredStyle: UIAlertController.Style.alert)
                
                alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                
                self.datePicker.setDate(Date() as Date, animated: true)
            
            }   else {
                let dateEntered = datePicker.date
              //  UserDefaults.standard.set(dateEntered, forKey: "dateEntered")
                UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
             //   UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
              //  UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
                  performSegue(withIdentifier: "homeSegue", sender: self)
            }
        
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

            } else if remainderDays < 0 || weeksLeft < 0 {

                print("this are \(remainderDaysElapsed) remaninder days left")
                let alertController = UIAlertController(title: "Due Date", message: "Your due date can't be in the past", preferredStyle: UIAlertController.Style.alert)

                alertController.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)

                self.datePicker.setDate(Date() as Date, animated: true)
            } else {
                let dateEntered = datePicker.date
            //    UserDefaults.standard.set(dateEntered, forKey: "dateEntered")
                UserDefaults.standard.set(calculatedDueDate, forKey: "DueDate")
               // UserDefaults.standard.set(weeksElapsed, forKey: "WeeksElapsed")
              //  UserDefaults.standard.set(remainderDaysElapsed, forKey: "RemainderDaysElapsed")
                  performSegue(withIdentifier: "homeSegue", sender: self)
            }
            
        }
    }
}
