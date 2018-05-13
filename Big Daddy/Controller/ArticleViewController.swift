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
    
     // var mother = UserDefaults.standard.object(forKey: "mother")
    
    // A dictionary of all of the article titles with their content
    
    let articles : [String : String] = [
        
        "Assisted Delivery" : "Try to avoid this...",
        "Caesarean Section" : """
        A caesarian section (AKA c-section or sunroof delivery) is a surgical procedure deliver a baby. They are very common - 20-25% of pregnant women in the UK have a c-section. There are two types of c-section:
        
        - Elective section. This is where the c-section is planned in advance. This might be where the mother has had a c-section before, she has a medical condition (such as gestational diabetes) which means that the baby needs to be delivered before a certain date, the baby is in an awkward position, or she would simply prefer to have a c-section.
        
        - Emergency section. This covers all non-planned c-sections, and isn’t just limited to blue-light emergency situations! An emergency section might be done where labour isn’t progressing, or where there’s a risk to the mum or baby of delaying the delivery.
        
        A c-section is occasionally carried out under either general anaesthetic (where the mother is completely asleep), but most often it’s done under spinal anaesthetic (where the mother is awake but can’t feel the lower part of her body).
        
        C-sections take place in an operating theatre, with a full team of doctors, anaesthetist and midwives. During the c-section, a screen is placed across the mother’s body so that she (and you!) can’t see what’s happening. The surgeons make a long cut (around 10-20cm) across the mother’s lower tummy and the baby is delivered straight from the womb. It’s an amazingly quick procedure - the whole thing (from numbing to stitching) takes around 40-50 minutes, but the baby is usually out within a few minutes of the first incision!
        
        Provided the mother is having a spinal anaesthetic (rather than a general anaesthetic), her partner is usually allowed to be by her side throughout the operation. Having a c-section can be nerve-wracking (for both parents!) so be sure to hold her hand and offer encouraging words of support throughout. Once the baby has been delivered, she’ll be cleaned up and passed over to her new parents while the mother is being stitched up. Don’t forget to get a photo of you all with you in your surgical gown!
        
        After the c-section, the mother will need to take it easy for a while. She’ll need to stay in hospital for a couple of days and will have pain in her tummy for a week or so. She won’t be allowed to drive or lift anything heavy for six weeks after the operation.
        
        
        "I ended up having an emergency c-section after 36 hours of labour. My temperature went up, and so did the baby’s heart rate, so the doctors told me I might have an infection and that it would be safest to have a c-section. By that point, I just wanted to get the baby out so was very happy to agree! The theatre team were so friendly, and explained everything really clearly. We had our music playing and my partner was holding my hand. It was all so calm. Although I always said that a c-section would be my worst-case scenario, it ended up being the highlight of my labour." - Harriet, London
        
        
        "I had a planned c-section as my baby was breech. Even though we knew the exact date she’d be born, nothing prepared me for caring for a newborn whilst recovering from a major operation. My tummy was so sore for the first few days that I struggled to get out of bed without support. My partner was amazing - whenever the baby cried, he would place her in my arms for feeding so that I didn’t have to get up, and brought me endless cups of tea and toast!"
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
        "Sleep Deprivation" : "Get used to it",
        "Stretch Marks" : "Try bio-oil",
        "Vitamin K" : "Probably for the best",
        "Vitamin Supplements" : "Don't forget folic acid"
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        articleTitle.text = articleID
        contentField.text = articles[articleID]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}


