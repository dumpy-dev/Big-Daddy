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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func likePressed(_ sender: Any) {

        if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
        
    }
    }
    
    @IBAction func dislikePressed(_ sender: Any) {
        sendEmail()
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["chrisjdeutsch@gmail.com"])
            mail.setSubject("Feedback")
            mail.setMessageBody("<p>Have you thought about adding this new feature?</p>", isHTML: true)
            
            present(mail, animated: true, completion: nil)
        } else {
            print("send email doesn't work")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIButton {
    // Animate a button, adding effect of "something went wrong". Useful for login button for example.
    func wiggle() {
        let wiggleAnim = CABasicAnimation(keyPath: "position")
        wiggleAnim.duration = 0.05
        wiggleAnim.repeatCount = 5
        wiggleAnim.autoreverses = true
        wiggleAnim.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
        wiggleAnim.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y)
        layer.add(wiggleAnim, forKey: "position")
    }
}
