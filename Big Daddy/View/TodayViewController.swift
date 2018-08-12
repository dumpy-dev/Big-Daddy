//
//  TodayViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 12/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // Setup the IB outlets and initial variables
    @IBOutlet weak var babyAgeLabel: UILabel!
    @IBOutlet weak var weekCollectionView: UICollectionView!
    @IBOutlet weak var babySizeLabel: UILabel!
   
    var selectedPerson = ""
    var selectionTag = 0
    
    //Setup the arrays
    let babySizeImageArray = ["week1to3", "week4", "week5", "week6", "week7", "week8", "week9", "week10", "week11", "week12", "week13", "week14", "week15", "week16", "week17", "week18", "week19", "week20", "week21", "week22", "week23", "week24", "week25", "week26", "week27", "week28", "week29", "week30", "week31", "week32", "week33", "week34", "week35", "week36", "week37", "week38", "week39", "week40", "week41", "week42"]
    let babySizeLabelArray = ["still in beta", "the size of X", "the size of X", "the size of a snowflake", "the size of a peanut", "the size of X", "the size of an eyeball", "the size of a birdseye chilli", "the size of a poker chip", "the size of a chicken nugget", "the size of X", "the size of a deck of cards", "the size of a big mac", "the size of a can of coke", "the size of a razor", "the size of an iPhone 8", "the size of a pint", "the height of a beer bottle", "the length of a tube of pringes", "the size of X", "the size of X", "the height of a bottle of wine", "the size of X", "the weight of a basketball", "the weight of War and Peace", "the size of X", "the weight of a tomahawk steak", "the size of a steering wheel", "the weight of an adult brain", "the weight of a roast chicken", "the size of a vinyl player", "the size of a dartboard", "the size of a small octopus", "the size of X", "the size of a car tyre", "the size of X", "the size of X", "the length of a full rack of ribs"]
    let weightArray = ["week1to3", "0.01g", "0.2g", "0.4g", "0.8g", "1g", "2g", "4g", "8g", "14g", "23g", "45g", "70g", "100g", "140g", "190g", "240g", "300g", "360g", "430g", "500g", "600g", "660g", "760g", "875g", "1kg", "1.1kg", "1.3kg", "1.5kg", "1.7kg", "1.9kg", "2.1kg", "2.4kg", "2.6kg", "2.9kg", "3.1kg", "3.3kg", "3.5kg", "3.5kg", "3.5kg"]
    let lengthArray = ["week1to3", "1mm", "2mm", "4mm", "8mm", "1.6cm", "2.3cm", "3.4cm", "4.1cm", "5.4cm", "7.4cm", "8.5cm", "10.1cm", "11.6cm", "12.9cm", "14.2cm", "15cm", "25.6cm", "26.6cm", "27.8cm", "29cm", "30cm", "34.6cm", "35.6cm", "36.6cm", "37.6cm", "38.6cm", "39.9cm", "41.1cm", "42.4cm", "43.7cm", "45cm", "46.2cm", "47.4cm", "48.6cm", "49.8cm", "50.6cm", "51.2cm", "51.2cm", "51.2cm"]
    
    
    // viewDidLoad and viewWillAppear
 override var prefersStatusBarHidden: Bool {
       return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      weekCollectionView.delegate = self
        weekCollectionView.dataSource = self
       self.navigationController?.isNavigationBarHidden = true
        weekCollectionView.allowsSelection = false
          weekCollectionView?.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dueDate = UserDefaults.standard.object(forKey: "DueDate") as! Date
        let now = Date()
        let diffInDays = Calendar.current.dateComponents([.day], from: now, to: dueDate).day
        
        let weeksLeft : Int = diffInDays!/7
        let remainderDays : Int = diffInDays!%7
        let weeksElapsed : Int = 40 - weeksLeft
        let remainderDaysElapsed : Int = 7 - remainderDays
        print("Your partner is \(weeksElapsed) weeks and \(remainderDaysElapsed) days along!")
        print("this is the due date: \(dueDate)")
        weekCollectionView.reloadData()
        
        selectionTag = 0
        print("the new selection tag = \(selectionTag)")
        self.navigationController?.isNavigationBarHidden = true
        selectedPerson = ""

        let displayedWeeksElapsed = weeksElapsed - 3 ?? 0
        
        if displayedWeeksElapsed <= 40 && displayedWeeksElapsed >= 4 {
        let indexPath = IndexPath(row: displayedWeeksElapsed, section: 0)
        weekCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        } else if displayedWeeksElapsed <= 3 {
            let indexPath = IndexPath(row: 0, section: 0)
             weekCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
//        if displayedWeeksElapsed  {
//            babyAgeLabel.text = "your baby is \(weeksElapsed) weeks old"
//        } else {
//            babyAgeLabel.text = "  ?"
//        }
            }

    @IBAction func fetusPressed(_ sender: Any) {
        selectionTag = 1
        performSegue(withIdentifier: "thisWeekSegue", sender: nil)
    }
    
    @IBAction func femalePressed(_ sender: Any) {
        selectionTag = 2
        performSegue(withIdentifier: "thisWeekSegue", sender: nil)
    }
    
    @IBAction func articlesPressed(_ sender: Any) {
        selectionTag = 3
        performSegue(withIdentifier: "articlesSegue", sender: nil)
    }
    
    @IBAction func factsPressed(_ sender: Any) {
        selectionTag = 4
        performSegue(withIdentifier: "thisWeekSegue", sender: (Any).self)
    }
    
    
    
   //Additional functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 38
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell:WeeksCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "weeksCell", for: indexPath) as! WeeksCollectionViewCell
        
        
        cell.weeksIcon.image = UIImage(named:babySizeImageArray[indexPath.row])
        
        let babyWeight = weightArray[indexPath.row]
        let babyLength = lengthArray[indexPath.row]
        
        
        if indexPath.row != 0 {
        cell.weeksElapsed.text = String(indexPath.row + 3)
            cell.babyLength.text = babyLength
            cell.babyWeight.text = babyWeight
        } else {
            cell.weeksElapsed.text = "0-3"
            cell.babyLength.text = "0g/0oz"
            cell.babyWeight.text = "0cm/0in"
        }
        
            
//            if let babySizeText : Int = UserDefaults.standard.integer(forKey: "BabySex") {
//            var babySex = "your baby"
//            if babySizeText == 0 {
//                        babySex = "she"
//                    } else if babySizeText == 1 {
//                        babySex = "he"
//                        } else if babySizeText == 2 {
//                            babySex = "your baby"
//                            }
            let sizeComparison = babySizeLabelArray[indexPath.row]
        
        let baby = UserDefaults.standard.string(forKey: "baby") ?? "your baby"
        
        if baby.isEmpty == true {
            cell.babySize.text = "your baby is \(sizeComparison)"
        } else {
        cell.babySize.text = "\(baby) is \(sizeComparison)"
        }
//                    }
//
            return cell

        
}
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is articlesForTodayViewController {
            print("to articles")
        } else {
            let tag = segue.destination as? ThisWeekViewController
            tag?.selectedTag = selectionTag
        }
    }


    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.weekCollectionView.scrollToNearestVisibleCollectionViewCell()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.weekCollectionView.scrollToNearestVisibleCollectionViewCell()
        }
    }
   
  
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollViewDecelerationRateNormal
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 100))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 100)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}



