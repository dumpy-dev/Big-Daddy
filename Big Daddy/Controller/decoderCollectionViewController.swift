//
//  decoderCollectionViewController.swift
//  
//
//  Created by Georgie and Chris on 29/08/2018.
//

import UIKit

//private let reuseIdentifier = "Cell"

class decoderCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    var arrayOfImages = [UIImage]()
    var arrayOfIDs = [String]()
    var arrayOfTypes = [String]()
    var checklistID = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Setup array values on view loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfImages = [#imageLiteral(resourceName: "sand-clock"), #imageLiteral(resourceName: "briefcase"), #imageLiteral(resourceName: "dogTag"), #imageLiteral(resourceName: "hypnosis"), #imageLiteral(resourceName: "rating"), #imageLiteral(resourceName: "terms")]
        arrayOfIDs = ["Contraction Counter", "Hospital Bag", "Names", "Hypnobirthing", "Rate Us!", "T&Cs"]
        arrayOfTypes = ["Timer", "Checklist", "Checklist", "General", "General", "General"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Setup collection view count and image/text for cells
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! decoderCollectionViewCell
        
        cell.decoderImage.image = arrayOfImages[indexPath.row]
        //cell.toolsLabel.text = "test"
        
        return cell
    }
    
    // Setup segues for each collection view cell selection
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
            performSegue(withIdentifier: "ratingsSegue", sender: nil)
        } else if indexPath.row == 5 {
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
    
    
    
    
    
    
    
    
    
    
    
    

