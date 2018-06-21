//
//  TodayViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 12/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var selectedPerson = ""
    var selectionTag = 0
    
    // Setup the IB outlets
    @IBOutlet weak var babyAgeLabel: UILabel!
    @IBOutlet weak var weekCollectionView: UICollectionView!
    @IBOutlet weak var babySizeLabel: UILabel!
    
    //Setup the arrays
    let babySizeImageArray = ["week1", "week2", "week3", "week4", "week5", "week6", "week7", "week8", "week9", "week10", "week11", "week12", "week13", "week14", "week15", "week16", "week17", "week18", "week19", "week20", "week21", "week22", "week23", "week24", "week25", "week26", "week27", "week28", "week29", "week30", "week31", "week32", "week33", "week34", "week35", "week36", "week37", "week38", "week39", "week40", "week41", "week42"]
    
    let babySizeLabelArray = ["1", "2", "3", "4", "5", "6", "7", "8", "size of a mini pretzel", "size of a poker chip", "size of a golf ball", "12", "13", "size of a chicken nugget", "15", "size of a pack of cards", "17", "18", "size of a pint", "height of a beer bottle", "the size of a big mac", "22", "length of a tube of pringles", "24", "25", "weight of a basketball", "27", "28", "29", "weight of a rack of ribs", "31", "32", "33", "weight of a roast chicken", "35", "36", "37", "38", "39", "40"]
    
    let weightArray = ["week1", "week2", "week3", "week4", "week5", "week6", "week7", "week8", "week9", "week10", "week11", "week12", "week13", "week14", "week15", "week16", "week17", "week18", "week19", "week20", "week21", "week22", "week23", "week24", "week25", "week26", "week27", "week28", "week29", "week30", "week31", "week32", "week33", "week34", "week35", "week36", "week37", "week38", "week39", "week40", "week41", "week42"]
    
    let lengthArray = ["0mm/0", "0mm/0", "0mm/0", "0mm/0", "week5", "week6", "week7", "week8", "week9", "week10", "week11", "week12", "week13", "week14", "week15", "week16", "week17", "week18", "week19", "week20", "week21", "week22", "week23", "week24", "week25", "week26", "week27", "week28", "week29", "week30", "week31", "week32", "week33", "week34", "week35", "week36", "week37", "week38", "week39", "week40", "week41", "week42"]
    
    
    
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
        
        selectionTag = 0
        print("the new selection tag = \(selectionTag)")
        self.navigationController?.isNavigationBarHidden = true
        selectedPerson = ""
        
        //update the age label text
        if let weeksElapsed = UserDefaults.standard.object(forKey: "WeeksElapsed") {
            babyAgeLabel.text = "your baby is \(weeksElapsed) weeks old"
        } else {
            babyAgeLabel.text = "  ?"
        }
        
        // set the collection view to the correct baby age
   let weeksElapsed : Int = UserDefaults.standard.object(forKey: "WeeksElapsed") as! Int - 1
        let indexPath = IndexPath(row: weeksElapsed, section: 0)
        weekCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
       
        
        
        
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
            return babySizeImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell:WeeksCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "weeksCell", for: indexPath) as! WeeksCollectionViewCell
            cell.weeksIcon.image = UIImage(named:babySizeImageArray[indexPath.row])
            cell.weeksElapsed.text = String(indexPath.row + 1)
            
            
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
             cell.babySize.text = "the \(sizeComparison)"
//                    }

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
        self.decelerationRate = UIScrollViewDecelerationRateFast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
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



