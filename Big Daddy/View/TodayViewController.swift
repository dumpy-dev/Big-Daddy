//
//  TodayViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 12/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    


    // Setup the IB outlets
    @IBOutlet weak var babyAgeLabel: UILabel!
    @IBOutlet weak var remainderDays: UILabel!
    @IBOutlet weak var babySizeLabel: UILabel!
    @IBOutlet weak var babySizeImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Setup the arrays
    let babySizeImageArray = ["week1", "week2", "week3", "week4", "week5", "week6", "week7", "week8", "week9", "week10", "week11", "week12", "week13", "week14", "week15", "week16", "week17", "week18", "week19", "week20", "week21", "week22", "week23", "week24", "week25", "week26", "week27", "week28", "week29", "week30", "week31", "week32", "week33", "week34", "week35", "week36", "week37", "week38", "week39", "week40", "week41", "week42"]
    
    let iconArray = ["fetusIcon", "femaleIcon", "articlesIcon", "factIcon"]
    
    // viewDidLoad and viewWillAppear
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        //update the image
        updateBabySizeImages()
        
        //update the age label text
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
        
        //set the baby sex according to the segmented selection
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

    
   //Additional functions
    
    func updateBabySizeImages() {
        let weeksElapsedInt : Int = UserDefaults.standard.object(forKey: "WeeksElapsed") as! Int
        babySizeImage.image = UIImage(named: babySizeImageArray[weeksElapsedInt - 1])
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! TodayCollectionViewCell
        cell.iconImage.image = UIImage(named:iconArray[indexPath.row])
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "articleSelectedSegue" {
//
//            var selectedRowIndex = self.collectionView.indexPath(for: UICollectionViewCell)
//            var articleSelected : TodayDetailViewController = segue.destination as! TodayDetailViewController
//            //articleSelected.articleID = articlesArray[selectedRowIndex!.row]
//
//
//        }
//        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
