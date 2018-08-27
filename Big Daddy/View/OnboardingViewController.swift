//
//  OnboardingViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 14/08/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit
  import SwiftyOnboard

class OnboardingViewController: UIViewController, SwiftyOnboardDataSource, SwiftyOnboardDelegate {
    
        var swiftyOnboard: SwiftyOnboard!
        let colors:[UIColor] = [#colorLiteral(red: 0.02788124846, green: 0.4410022836, blue: 0.5705418906, alpha: 0.66),#colorLiteral(red: 0.03611627438, green: 0.5941812396, blue: 0.7784456025, alpha: 0.66),#colorLiteral(red: 1, green: 0.7970821868, blue: 0.4988624448, alpha: 1)]
        var titleArray: [String] = ["Welcome to Big Daddy!", "Loads of information", "Time to customise"]
        var subTitleArray: [String] = ["Congratulations!\n You’re going to be a BigDaddy.", "Keep track of how your baby\n is growing", "Get yourself Daddy-ready\n with our hospital bag checklist"]
        
        var gradiant: CAGradientLayer = {
            //Gradiant for the background view
            let blue = UIColor(red: 69/255, green: 127/255, blue: 202/255, alpha: 1.0).cgColor
            let purple = UIColor(red: 166/255, green: 172/255, blue: 236/255, alpha: 1.0).cgColor
            let gradiant = CAGradientLayer()
            gradiant.colors = [purple, blue]
            gradiant.startPoint = CGPoint(x: 0.5, y: 0.18)
            return gradiant
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            gradient()
            UIApplication.shared.statusBarStyle = .lightContent
            
            swiftyOnboard = SwiftyOnboard(frame: view.frame, style: .light)
            view.addSubview(swiftyOnboard)
            swiftyOnboard.dataSource = self as! SwiftyOnboardDataSource
            swiftyOnboard.delegate = self as! SwiftyOnboardDelegate
        }
        
        func gradient() {
            //Add the gradiant to the view:
            self.gradiant.frame = view.bounds
            view.layer.addSublayer(gradiant)
        }
        
    @objc func handleSkip() {
            swiftyOnboard?.goToPage(index: 2, animated: true)
        }
        
    @objc func handleContinue(sender: UIButton) {
            let index = sender.tag
        if index >= 2 {
            performSegue(withIdentifier: "onboardingSegue", sender: self)
        } else {
            swiftyOnboard?.goToPage(index: index + 1, animated: true)
        }
        
        }
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        //Number of pages in the onboarding:
        return 3
    }
    
    func swiftyOnboardBackgroundColorFor(_ swiftyOnboard: SwiftyOnboard, atIndex index: Int) -> UIColor? {
        //Return the background color for the page at index:
        return colors[index]
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = SwiftyOnboardPage()
        
        //Set the image on the page:
        view.imageView.image = #imageLiteral(resourceName: "seahorse")
        
        //Set the font and color for the labels:
        view.title.font = UIFont(name: "Gill Sans", size: 28)
        view.subTitle.font = UIFont(name: "Gill Sans", size: 22)
        
        //Set the text in the page:
        view.title.text = titleArray[index]
        view.subTitle.text = subTitleArray[index]
        
        //Return the page for the given index:
        return view
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        //Setup targets for the buttons on the overlay view:
        overlay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        
        //Setup for the overlay buttons:
        overlay.continueButton.titleLabel?.font = UIFont(name: "Gill Sans", size: 22)
        overlay.continueButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.titleLabel?.font = UIFont(name: "Gill Sans", size: 22)
        
        //Return the overlay view:
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        print(Int(currentPage))
        overlay.continueButton.tag = Int(position)
        
        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.continueButton.setTitle("Continue", for: .normal)
            overlay.skipButton.setTitle("Skip", for: .normal)
            overlay.skipButton.isHidden = false
        } else {
            overlay.continueButton.setTitle("Get Started!", for: .normal)
            overlay.skipButton.isHidden = true
        }
    }
    }
    

    
    
    
    

