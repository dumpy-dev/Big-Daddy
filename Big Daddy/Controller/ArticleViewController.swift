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
        "Driving" : "Drive carefully, please look after your baby!",
        "Eating" : "You can eat these foods...",
        "Exercise" : "Do exercise",
        "First Aid" : "This is how to do first aid",
        "Holidays" : "<p>Looking for a way to celebrate reaching the end of the first trimester, with its sickness, tiredness and unexpected mood swings (and that’s before we even come on to (mother)’s symptoms)? The second trimester is the perfect time to go on holiday, when (mother) is feeling at her best and isn’t so big that they’ll need to redistribute the weight on the plane…<p> <b>Flying \n The good news is, flying is totally safe during pregnancy! Most airlines won’t let (mother) travel after around 34 weeks, and may require a doctor’s letter confirming the due date, so make sure you check this with the airline before booking. <n> There’s a slightly increased risk of (mother) getting a deep vein thrombosis on long haul flights, but the risk is still low. Pick up a pair of compression stockings to reduce the risk further.",
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
