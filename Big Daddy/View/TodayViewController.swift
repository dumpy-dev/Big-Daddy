//
//  TodayViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 12/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

      @IBOutlet weak var babyAgeLabel: UILabel!
    @IBOutlet weak var remainderDays: UILabel!
    
    @IBOutlet weak var babySizeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let weeksElapsed = UserDefaults.standard.object(forKey: "WeeksElapsed") {
            babyAgeLabel.text = "\(weeksElapsed)"
        } else {
            babyAgeLabel.text = "  ?"
        }
        if let remainderDaysText = UserDefaults.standard.object(forKey: "RemainderDaysElapsed") {
            remainderDays.text = "+ \(remainderDaysText)"
            } else {
            remainderDays.text = ""
        }
        
        //currently working on setting the baby sex according to the segmented selection
        if let babySizeText : Int = UserDefaults.standard.integer(forKey: "BabySex") {
        
        if babySizeText == 0 {
                        babySizeLabel.text = "she is the size of a pint of beer"
        } else if babySizeText == 1 {
            
                babySizeLabel.text = "he is the size of a pint of beer"
            
            } else if babySizeText == 2 {
    babySizeLabel.text = " your baby is the size of a pint of beer "
                }
            }
            }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
  
    
    
    
    let babyAgeLabel1 : String = "This is test text"
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
