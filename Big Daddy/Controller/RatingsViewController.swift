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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Like Pressed - send user to App Store Ratings
    @IBAction func likePressed(_ sender: Any) {
        if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
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
            mail.setToRecipients(["chrisjdeutsch@gmail.com"])
            mail.setSubject("Feedback")
            //mail.setMessageBody("<p>Have you thought about adding this new feature?</p>", isHTML: true)
            present(mail, animated: true, completion: nil)
        } else {
            print("send email doesn't work")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}


