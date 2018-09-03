
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




    @IBOutlet weak var onboardingImage: UIImageView!
    var swiftyOnboard: SwiftyOnboard!
    let colors:[UIColor] = [ #colorLiteral(red: 0.02745098039, green: 0.4392156863, blue: 0.568627451, alpha: 1),#colorLiteral(red: 0.02745098039, green: 0.4392156863, blue: 0.568627451, alpha: 1),#colorLiteral(red: 0.07843137255, green: 0.5607843137, blue: 0.6117647059, alpha: 1),#colorLiteral(red: 0.1568627451, green: 0.6470588235, blue: 0.6588235294, alpha: 1),#colorLiteral(red: 0.2352941176, green: 0.7209517336, blue: 0.7019607843, alpha: 1),#colorLiteral(red: 0.3137254902, green: 0.7776038476, blue: 0.7490196078, alpha: 1)]
    var titleArray: [String] = ["Congratulations!", "Swipe Right", "Swipe Down", "Get Reading", "Get Prepared", "Get Personal"]
        var subTitleArray: [String] = ["You’re going to be a BigDaddy.", "Swipe to see how your baby \nand the mum-to-be are getting \non this week, and to check out awesome articles and fun facts.", "There aren’t any pineapples or watermelons here. Swipe through the weeks to find out when your baby will be the size of an eyeball, a pint or a tomahawk steak.", "Check out our articles for useful information on everything from cravings to c-sections.", "Get yourself Daddy-ready in the Tools section with our hospital checklist, name list and baby decoder. \nAnd when the big day comes around, don’t forget to use the contraction timer!", "It’s time to get personal! \nAdd in a few details to help us \ntailor your BigDaddy experience \nand you’re all set. \nTo fatherhood and beyond!  "]
    var imageArray = [#imageLiteral(resourceName: "seahorse"), #imageLiteral(resourceName: "swipeToRight.png"), #imageLiteral(resourceName: "right-arrow"), #imageLiteral(resourceName: "articlesIcon"), #imageLiteral(resourceName: "toolsIcon"), #imageLiteral(resourceName: "settings@x3")]
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
            swiftyOnboard?.goToPage(index: 5, animated: true)
        }

    @objc func handleContinue(sender: UIButton) {
            let index = sender.tag
        if index >= 5 {
            performSegue(withIdentifier: "onboardingSegue", sender: self)
        } else {
            swiftyOnboard?.goToPage(index: index + 1, animated: true)
        }

        }
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        //Number of pages in the onboarding:
        return 6
    }

    func swiftyOnboardBackgroundColorFor(_ swiftyOnboard: SwiftyOnboard, atIndex index: Int) -> UIColor? {
        //Return the background color for the page at index:
        return colors[index]
    }

    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = SwiftyOnboardPage()

        //Set the image on the page:


        view.imageView.image = imageArray[index]


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

        if currentPage == 0.0 || currentPage == 1.0  || currentPage == 2.0 || currentPage == 3.0 || currentPage == 4.0  {
            overlay.continueButton.setTitle("Continue", for: .normal)
            overlay.skipButton.setTitle("Skip", for: .normal)
            overlay.skipButton.isHidden = false
        } else {
            overlay.continueButton.setTitle("Get Started!", for: .normal)
            overlay.skipButton.isHidden = true
        }
    }
    }







