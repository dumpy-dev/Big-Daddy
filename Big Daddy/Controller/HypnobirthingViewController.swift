//
//  HypnobirthingViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 13/06/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class HypnobirthingViewController: UIViewController {

    var scriptPositionCounter = 0
    
    let scriptDictionary : [Int:String] = [
    
        0 : "",
        1 : "You are getting sleepy",
        2 : "Very. very sleepy",
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
    
    
    
    @IBOutlet var infoPopupView: UIView!
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    var effect:UIVisualEffect!
    
    
    
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
        
        
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        infoPopupView.layer.cornerRadius = 5
    }

    
    func animateIn() {

        self.view.addSubview(infoPopupView)
        infoPopupView.center = self.view.center
        infoPopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        infoPopupView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
            self.infoPopupView.alpha = 1
            self.infoPopupView.transform = CGAffineTransform.identity
        }
        
    }
   
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        
        
    }
    
    @IBOutlet weak var scriptLabel: UILabel!
  
    @IBAction func textTapped(_ gestureRecognizer : UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.scriptLabel.alpha = 0.0
        }, completion: nil)
        
        scriptPositionCounter = scriptPositionCounter + 1
        
        self.scriptLabel.text = scriptDictionary[scriptPositionCounter]
        
        // Fade in
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.scriptLabel.alpha = 1.0
        }, completion: nil)
        
    }
    
    @IBAction func restartPressed(_ sender: Any) {
        
        scriptPositionCounter = 1
        
        self.scriptLabel.text = scriptDictionary[scriptPositionCounter]
        
        // Fade in
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.scriptLabel.alpha = 1.0
        }, completion: nil)


    }
    
    @IBAction func backPressed(_ sender: Any) {
 
        scriptPositionCounter = scriptPositionCounter - 1
        
        self.scriptLabel.text = scriptDictionary[scriptPositionCounter]
        
        // Fade in
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.scriptLabel.alpha = 1.0
        }, completion: nil)
    
    
    
    
    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        
        animateIn()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
