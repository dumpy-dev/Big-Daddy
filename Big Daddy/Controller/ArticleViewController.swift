//
//  ArticleViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 26/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleBodyLabel: UILabel!
    @IBOutlet weak var contentField: UITextView!
    
    
    var articleID : String = ""
    
  var mother = UserDefaults.standard.object(forKey: "mother") ?? "mother"
    
    // A dictionary of all of the article titles with their content
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let articles : [String : String] = [
            
            "Assisted Delivery" : "Try to avoid this...",
            "Announcing The Pregnancy" : "Test",
            "Caesarean Section" : """
             See HTML article
            """,
            "Drinking" : """
            Don't drink
            Don't drive
            
            """,
            "Driving" : "Drive carefully, please look after your baby!",
            "Eating" : "You can eat these foods...",
            "Exercise" : "Do exercise",
            "First Aid" : "This is how to do first aid",
            "Holidays" : "<p>Looking for a way to celebrate reaching the end of the first trimester, with its sickness, tiredness and unexpected mood swings (and that’s before we even come on to mother)’s symptoms)? The second trimester is the perfect time to go on holiday, when (mother) is feeling at her best and isn’t so big that they’ll need to redistribute the weight on the plane…<p> <b>Flying \n The good news is, flying is totally safe during pregnancy! Most airlines won’t let (mother) travel after around 34 weeks, and may require a doctor’s letter confirming the due date, so make sure you check this with the airline before booking. <n> There’s a slightly increased risk of (mother) getting a deep vein thrombosis on long haul flights, but the risk is still low. Pick up a pair of compression stockings to reduce the risk further.",
            "Migraines" : "Migraines aren't very nice",
            "Morning Sickness" : "Urgh",
            "Nose Bleeds" : "PANIC!",
            "Postnatal Depression" : "Watch out for these signs",
            "Pre-eclampsia" : "Better than eclampsia",
            "Signs of Labour" : """

            \(mother)
            The hospital bag is packed, the cot is assembled (after a minor argument over some missing screws and only a few tears), and the bump is BIG. But how do you know when it’s all about to kick off?
            To help prepare you for that oh-my-god-we’re-having-a-baby-actually-right-now-and-I’m-a-bit-scared moment, here’s a list of signs and symptoms that labour is on the way. Don’t forget that every woman is different, and \(mother) may end up having all, some or none of these symptoms!
            
            - Waters breaking. This may happen in a gush in the frozen vegetable aisle in Sainsbury’s, or it might just be a slow trickle over a few hours. If she suspects her waters have broken, \(mother) should call her maternity unit right away. Sometimes, the waters don’t break until the woman is about to give birth. Occasionally, the baby is born with the amniotic sac intact - this is called being born “en caul” and is very rare.
            
            - Contractions starting. If it’s labour for real (rather than those pesky Braxton Hicks), the contractions will be painful and increase in intensity, although they might still stop and start a little. You might find it helpful to use our contraction timer to keep track of contractions.
            
            - Persistent lower back pain or tummy cramps.
            - A brownish or blood-tinged mucus discharge.
            - A funny tummy
            - Disrupted sleep
            
            As a general rule, midwives like you to come in once the contractions are painful and happening at least every five minutes, with each one lasting at least a minute. However, each midwife unit or hospital will have its own set of rules, so it’s important for you or \(mother) to call in once you think labour is starting (or if her waters have broken) and they will be able to give you advice on what to do next. Once you get the go ahead, leave the house and take the cannoli! Or jelly babies, if you prefer. It’s nearly time to say hello to your little friend!
            """,
            "Sleep Deprivation" : "Get used to it",
            "Stretch Marks" : "Try bio-oil",
            "Vitamin K" : "Probably for the best",
            "Vitamin Supplements" : "Don't forget folic acid"
            
        ]

       // articleTitle.text = articleID
        // contentField.text = articles[articleID]
        
//        if let html = Bundle.main.path(forResource: "\(articleID)", ofType: "html") {
//            let urlToLoad = URL(fileURLWithPath: html)
//        let data = NSData(contentsOf: urlToLoad)
//
//        if let attributedString = try? NSAttributedString(data: data as! Data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
//
//            contentField.attributedText = attributedString
//            let mother = "Georgie"
//        }
       
    
        if let htmlURL = Bundle.main.url(forResource: articleID, withExtension: "html") {
            do {
                let data = try Data(contentsOf: htmlURL)
                
                let attributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                
                //### When you want to compare the result...
                //originalText.attributedText = attributedString
                let mother : String = UserDefaults.standard.object(forKey: "mother") as! String ?? "mother"
                let regex = try! NSRegularExpression(pattern: "\\(mother\\)")
                let range = NSRange(0..<attributedString.string.utf16.count)
                let matches = regex.matches(in: attributedString.string, range: range)
                for match in matches.reversed() {
                    attributedString.replaceCharacters(in: match.range, with: mother)
                }
                
                contentField.attributedText = attributedString
            } catch {
                // Do error processing here...
                print(error)
            }
      
    } else {
            
            contentField.text = articles[articleID]
        }
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}


