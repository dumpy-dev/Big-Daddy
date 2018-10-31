//
//  babyChecklistCollectionViewController.swift
//  
//
//  Created by Georgie and Chris on 29/08/2018.
//

import UIKit

//private let reuseIdentifier = "Cell"

class babyChecklistCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    var arrayOfImages = [UIImage]()
    var arrayOfIDs = [String]()
    var arrayOfTypes = [String]()
    var checklistID = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Setup array values on view loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfImages = [#imageLiteral(resourceName: "checklistChecklist"),#imageLiteral(resourceName: "checklistChecklist"),#imageLiteral(resourceName: "nappyChecklist"),#imageLiteral(resourceName: "crossChecklist"),#imageLiteral(resourceName: "bathChecklist"),#imageLiteral(resourceName: "sleepChecklist"),#imageLiteral(resourceName: "bottleChecklist"),#imageLiteral(resourceName: "checklistChecklist"),#imageLiteral(resourceName: "checklistChecklist")]
        arrayOfIDs = ["Clothes", "Travel", "Nappy", "Health", "Bathtime", "Sleeping", "Feeding", "Misc", "To Do"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Setup collection view count and image/text for cells
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfIDs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! babyChecklistCollectionViewCell
        cell.decoderImage.image = arrayOfImages[indexPath.row]
        cell.categoryLabel.text = arrayOfIDs[indexPath.row]
        return cell
    }
    
    // Setup segues for each collection view cell selection
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
              checklistID = 3
            performSegue(withIdentifier: "babyChecklistListSegue", sender: nil)
        } else if indexPath.row == 1 {
            checklistID = 4
            performSegue(withIdentifier: "babyChecklistListSegue", sender: nil)
        } else if indexPath.row == 2 {
            checklistID = 5
            performSegue(withIdentifier: "babyChecklistListSegue", sender: nil)
        } else if indexPath.row == 3 {
            checklistID = 6
            performSegue(withIdentifier: "babyChecklistListSegue", sender: nil)
        } else if indexPath.row == 4 {
            checklistID = 7
            performSegue(withIdentifier: "babyChecklistListSegue", sender: nil)
        } else if indexPath.row == 5 {
            checklistID = 8
            performSegue(withIdentifier: "babyChecklistListSegue", sender: nil)
        } else if indexPath.row == 6 {
            checklistID = 9
            performSegue(withIdentifier: "babyChecklistListSegue", sender: nil)
        } else if indexPath.row == 7 {
            checklistID = 10
            performSegue(withIdentifier: "babyChecklistListSegue", sender: nil)
        } else if indexPath.row == 8 {
            checklistID = 11
            performSegue(withIdentifier: "babyChecklistListSegue", sender: nil)
        }
    }
    
    // Prepare for segues to pass data across
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "babyChecklistListSegue" {
            let checklistSelected : ChecklistViewController = segue.destination as! ChecklistViewController
            checklistSelected.checklistIdentifier = checklistID
            }
        }
}
    
    
    
    
    
    
    
    
    
    
    
    

