//
//  ArticleViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 26/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    
    var articleID : String = ""
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleBodyLabel: UILabel!
    
    
 // A dictionary of all of the article titles with their content
    
    let articles : [String : String] = [
    
        "Assisted Delivery" : "Try to avoid this...",
        "Caesarean Section" : "The deivery method of choice for clever people",
        "Drinking" : "Don't drink",
        "Driving" : "Drive carefully",
        "Eating" : "You can eat these foods...",
        "Exercise" : "Do exercise",
        "First Aid" : "This is how to do first aid",
        "Holidays" : "Hooray for holidays!",
        "Migraines" : "Migraines aren't very nice",
        "Morning Sickness" : "Urgh",
        "Nose Bleeds" : "PANIC!",
        "Postnatal Depression" : "Watch out for these signs",
        "Pre-eclampsia" : "Better than eclampsia",
        "Sleep Deprivation" : "Get used to it",
        "Stretch Marks" : "Try bio-oil",
        "Vitamin K" : "Probably for the best",
        "Vitamin Supplements" : "Don't forget folic acid"
        
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        articleTitle.text = articleID
        articleBodyLabel.text = articles[articleID]
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
