//
//  ToolsCollectionCollectionViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 07/04/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit


class ToolsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // Initialise arrays
    
    var arrayOfImages = [UIImage]()
    var arrayOfIDs = [String]()
    var arrayOfTypes = [String]()
    var checklistID = 0
    
    
    //Setup array values on view loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfImages = [#imageLiteral(resourceName: "sand-clock"), #imageLiteral(resourceName: "briefcase"), #imageLiteral(resourceName: "dogTag"), #imageLiteral(resourceName: "hypnosis"), #imageLiteral(resourceName: "search"), #imageLiteral(resourceName: "bodysuit"), #imageLiteral(resourceName: "rating"), #imageLiteral(resourceName: "terms")]
        arrayOfIDs = ["Contraction Counter", "Hospital Bag", "Names", "Hypnobirthing", "Baby Decoder", "Baby Checklist", "Rate Us!", "T&Cs"]
        arrayOfTypes = ["Timer", "Checklist", "Checklist", "General", "BabyDecoder", "BabyChecklist", "General", "General"]
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Setup collection view count and image/text for cells
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImages.count
    }
    
func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow
   let availableWidth = view.frame.width
    let cellWidth = availableWidth / 2 - 20
        return CGSize(width: cellWidth, height: cellWidth)
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
            checklistID = 1
            performSegue(withIdentifier: "toolsChecklistSegue", sender: nil)
        } else if indexPath.row == 2 {
            checklistID = 2
            performSegue(withIdentifier: "toolsChecklistSegue", sender: nil)
        } else if indexPath.row == 3 {
            performSegue(withIdentifier: "toolsGeneralSegue", sender: nil)
        } else if indexPath.row == 4 {
            performSegue(withIdentifier: "decoderSegue", sender: nil)
        } else if indexPath.row == 5 {
            performSegue(withIdentifier: "babyChecklistSegue", sender: nil)
        } else if indexPath.row == 6 {
            performSegue(withIdentifier: "ratingsSegue", sender: nil)
        } else if indexPath.row == 7 {
            performSegue(withIdentifier: "generalTextSegue", sender: nil)
        }
        

    }

    // Prepare for segues to pass data across
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toolsChecklistSegue" {
            let checklistSelected : ChecklistViewController = segue.destination as! ChecklistViewController
            checklistSelected.checklistIdentifier = checklistID
        }
    }
}
