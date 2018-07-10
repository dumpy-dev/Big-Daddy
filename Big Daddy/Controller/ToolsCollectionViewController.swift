//
//  ToolsCollectionCollectionViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 07/04/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class ToolsCollectionViewController: UICollectionViewController {

    // Initialise arrays
    
    var arrayOfImages = [UIImage]()
    var arrayOfIDs = [String]()
    var arrayOfTypes = [String]()
    
    
    //Setup array values on view loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfImages = [#imageLiteral(resourceName: "sand-clock"), #imageLiteral(resourceName: "briefcase"), #imageLiteral(resourceName: "dogTag"), #imageLiteral(resourceName: "hypnosis")]
        arrayOfIDs = ["Contraction Counter", "Hospital Bag", "Names", "Hypnobirthing"]
        arrayOfTypes = ["Timer", "Checklist", "Checklist", "General"]
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Setup collection view count and image/text for cells
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "toolsCell", for: indexPath) as! ToolsCollectionViewCell
        
        cell.toolsIcon.image = arrayOfImages[indexPath.row]
        cell.toolsLabel.text = arrayOfIDs[indexPath.row]
        
        return cell
    }
    
    // Setup segues for each collection view cell selection
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.row == 0 {
            print("tool selected index path 0")
            performSegue(withIdentifier: "toolsTimerSegue", sender: nil)
        } else if indexPath.row == 1 {
            print("tool selected index path 1")
            performSegue(withIdentifier: "toolsChecklistSegue", sender: nil)
        } else if indexPath.row == 2 {
            performSegue(withIdentifier: "toolsChecklistSegue", sender: nil)
        } else if indexPath.row == 3 {
            performSegue(withIdentifier: "toolsGeneralSegue", sender: nil)
        }
    }

    // Prepare for segues to pass data across
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
    }
   
    
    
}




// Below are probably all extraneous experimental blocks of code!




//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let storyboardType = arrayOfTypes[indexPath.row]
//
//        let viewController = storyboard?.instantiateViewController(withIdentifier: storyboardType)
//
//        self.navigationController?.pushViewController(viewController!, animated: true)
//
//print(indexPath.row)
//
//    }






    
//    var toolName = String()
//    let toolsArray = ["week19", "fetusIcon", "femaleIcon", "fetusIcon", "factsIcon", "articlesIcon", "week19"]
//
//
//    var cellSelected : Int = 0
//
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//
//    }
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "toolSelectedSegue" {
//
//          var selectedRowIndex = self.collectionView!.indexPathsForSelectedItems![0]
//            var toolSelected : ToolsViewController = segue.destination as! ToolsViewController
//
//
//         print(selectedRowIndex)
//toolSelected.toolName = toolsArray[selectedRowIndex]
//        }
//
//    }
//
//
//
//
//
//
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return toolsArray.count
//
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "toolsCell", for: indexPath) as! ToolsCollectionViewCell
//
//       cell.toolsIcon.image = UIImage(named:toolsArray[indexPath.row])
//        cell.toolsLabel.text = "testing"
//
//        return cell
//    }
//
//
//
//    // MARK: UICollectionViewDelegate
//
//    /*
//    // Uncomment this method to specify if the specified item should be highlighted during tracking
//    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    */
//
//    /*
//    // Uncomment this method to specify if the specified item should be selected
//    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    */
//
//    /*
//    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//        return false
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//        return false
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//
//    }
//    */
//
//}


