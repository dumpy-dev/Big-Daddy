//
//  RatingsViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 29/07/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI


class RatingsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var timer : Timer?
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(likeWiggle), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Like Pressed - send user to App Store Ratings
    @IBAction func likePressed(_ sender: Any) {
        if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
        } else {
            print("ratings displayed more than 3 times")
        }
    }
    
    // Dislike Pressed - send user to write email feedback
    @IBAction func dislikePressed(_ sender: Any) {
        sendEmail()
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@thebigdaddyapp.com"])
            mail.setSubject("Feedback")
        //mail.setMessageBody("<p>Set default email text here as needed.</p>", isHTML: true)
            present(mail, animated: true, completion: nil)
        } else {
            print("send email doesn't work")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    @objc func likeWiggle() {
        likeButton.wiggle()
    }
}

extension UIButton {
   
    @objc func wiggle() {
        let wiggleAnim = CABasicAnimation(keyPath: "position")
        wiggleAnim.duration = 0.05
        wiggleAnim.repeatCount = 8
        wiggleAnim.autoreverses = true
        wiggleAnim.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
        wiggleAnim.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y)
        layer.add(wiggleAnim, forKey: "position")
    }
}


