//
//  WeekCollectionViewCell.swift
//  
//
//  Created by Georgie and Chris on 22/08/2018.
//

import UIKit

class WeekCollectionViewCell: UICollectionViewCell {
    
   var rightPressed : Bool = false
    @IBAction func rightArrowPressed(_ sender: Any) {
       skipCell()
    }
    
    @IBOutlet weak var rightArrow: UIButton!
    @IBOutlet weak var babyImage: UIImageView!
    @IBOutlet weak var babyWeight: UILabel!
    @IBOutlet weak var babyHeight: UILabel!
    @IBOutlet weak var weeksElapsed: UILabel!
    @IBOutlet weak var babySize: UILabel!
    @IBOutlet weak var visibilityView: UIView!
    
    func skipCell() {
        print("skip cell")
    }
    
}
