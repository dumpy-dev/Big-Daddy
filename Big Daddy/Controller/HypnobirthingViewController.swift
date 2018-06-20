//
//  HypnobirthingViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 13/06/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class HypnobirthingViewController: UIViewController {

    // Setup variables and dictionary
    
    var scriptPositionCounter = 0
    let scriptDictionary : [Int:String] = [
        0 : "",
        1 : "You are feeling sleepy",
        2 : "Very, very sleepy",
        3 : "Close your eyes",
        4 : "Drift off to sleep",
        5 : "When you wake up",
        6: "Well you know I'm gonna be",
        7: "I'm gonna be",
        8 : "The man who wakes up",
        9 : "Next to you",
        10: "When I go out, well you know I'm gonna be, I'm gonna be the man",
        11 : "Who goes along with you"
    ]
    
    //Setup outlets
  
    @IBOutlet var infoPopupView: UIView!
    @IBOutlet weak var scriptLabel: UILabel!
    
    //Load the view and setup functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if scriptPositionCounter == 0 {
            scriptPositionCounter = scriptPositionCounter + 1
            UIView.animate(withDuration: 3.0, delay: 2.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.scriptLabel.alpha = 1.0
            }, completion: nil)
                } else {
            scriptLabel.text = scriptDictionary[scriptPositionCounter]
            UIView.animate(withDuration: 3.0, delay: 2.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.scriptLabel.alpha = 1.0
            }, completion: nil)
        }
        infoPopupView.layer.cornerRadius = 5
    }

    
    func animateIn() {
        self.view.addSubview(infoPopupView)
    
        UIView.animate(withDuration: 2.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.scriptLabel.alpha = 0.3
        }, completion: nil)
        
        infoPopupView.center = self.view.center
        infoPopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        infoPopupView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            
            self.infoPopupView.alpha = 1
            self.infoPopupView.transform = CGAffineTransform.identity
  
        }
        
    }
   
    // Functionality of info popup
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        animateIn()
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.infoPopupView.removeFromSuperview()
        UIView.animate(withDuration: 1.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.scriptLabel.alpha = 1.0
        }, completion: nil)
    }
    
    // Functionality of script presentation
  
    @IBAction func textTapped(_ gestureRecognizer : UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.scriptLabel.alpha = 0.0
        }, completion: nil)
        
        scriptPositionCounter = scriptPositionCounter + 1
        
        self.scriptLabel.text = scriptDictionary[scriptPositionCounter]
    
        UIView.animate(withDuration: 1.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.scriptLabel.alpha = 1.0
        }, completion: nil)
        
    }
    
    @IBAction func restartPressed(_ sender: Any) {
        
        UIView.animate(withDuration: 2.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.scriptLabel.alpha = 0.3
        }, completion: nil)
        
        scriptPositionCounter = 1
        
        self.scriptLabel.text = scriptDictionary[scriptPositionCounter]
        
        // Fade in
        UIView.animate(withDuration: 2.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.scriptLabel.alpha = 1.0
        }, completion: nil)


    }
    
    @IBAction func backPressed(_ sender: Any) {
        print(scriptPositionCounter)
        if scriptPositionCounter == 1 {
            print("already at start")
               self.scriptLabel.text = scriptDictionary[scriptPositionCounter]
            
        } else {
        UIView.animate(withDuration: 2.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.scriptLabel.alpha = 0.3
        }, completion: nil)
        
        scriptPositionCounter = scriptPositionCounter - 1
        
        self.scriptLabel.text = scriptDictionary[scriptPositionCounter]
        
    
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.scriptLabel.alpha = 1.0
        }, completion: nil)
        }
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
    

    }
