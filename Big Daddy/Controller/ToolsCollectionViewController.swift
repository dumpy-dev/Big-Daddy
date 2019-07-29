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
    
    @IBOutlet var upgradePopup: UIView!
    var arrayOfImages = [UIImage]()
    var arrayOfLockedImages = [UIImage]()
    var arrayOfIDs = [String]()
    var arrayOfTypes = [String]()
    var checklistID = 0
    var textID = 0
   // var fullVersionUnlocked = UserDefaults.standard.bool(forKey: "fullVersionUnlocked")
    
  //  var fullVersionUnlocked = true
    var fullVersionUnlocked = false
    
    @IBAction func upgradePressed(_ sender: Any) {
        self.upgradePopup.removeFromSuperview()
         performSegue(withIdentifier: "upgradeSegue", sender: self)
        
    }
    @IBOutlet var upgradeButton: UIButton!
    //Setup array values on view loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfImages = [#imageLiteral(resourceName: "sand-clock"), #imageLiteral(resourceName: "briefcase"), #imageLiteral(resourceName: "dogTag"), #imageLiteral(resourceName: "search"), #imageLiteral(resourceName: "bodysuit"), #imageLiteral(resourceName: "ratingStars"), #imageLiteral(resourceName: "terms"), #imageLiteral(resourceName: "credits")]
        arrayOfLockedImages = [#imageLiteral(resourceName: "sandTimerLocked"), #imageLiteral(resourceName: "suitcaseLocked"), #imageLiteral(resourceName: "dogtagsLocked"), #imageLiteral(resourceName: "magnifyingGlassLocked"), #imageLiteral(resourceName: "babyBodysuitLocked"), #imageLiteral(resourceName: "ratingStars"), #imageLiteral(resourceName: "terms"), #imageLiteral(resourceName: "credits")]
        arrayOfIDs = ["Contraction Counter", "Hospital Bag", "Names", "Baby Decoder", "Baby Checklist", "Rate Us!", "T&Cs", "Credits"]
        arrayOfTypes = ["Timer", "Checklist", "Checklist", "BabyDecoder", "BabyChecklist", "General", "General", "General", "General"]
        
        if fullVersionUnlocked == false {
            self.navigationController?.view.addSubview(upgradePopup)
            upgradePopup.center.x = self.view.center.x
            upgradePopup.frame.origin.y = self.view.frame.height / 1.2
            upgradePopup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            upgradePopup.alpha = 0
            UIView.animate(withDuration: 0.8) {
                self.upgradePopup.alpha = 1
                self.upgradePopup.transform = CGAffineTransform.identity
                
            }
        }
        }
    override func viewDidAppear(_ animated: Bool) {
        if fullVersionUnlocked == true {
            self.upgradePopup.removeFromSuperview()
        } else {
            self.navigationController?.view.addSubview(upgradePopup)
            upgradePopup.center.x = self.view.center.x
            upgradePopup.frame.origin.y = self.view.frame.height / 1.2
            upgradePopup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            upgradePopup.alpha = 0
            UIView.animate(withDuration: 0.8) {
                self.upgradePopup.alpha = 1
                self.upgradePopup.transform = CGAffineTransform.identity
            }
        }
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
        cell.toolsLabel.text = arrayOfIDs[indexPath.row]
        if fullVersionUnlocked == true {
            cell.toolsIcon.image = arrayOfImages[indexPath.row]
        } else {
            if 0 ... 4 ~= indexPath.row {
                cell.toolsLabel.alpha = 0.6
            }
            cell.toolsIcon.image = arrayOfLockedImages[indexPath.row]
        }
        return cell
    }
    
    // Setup segues for each collection view cell selection
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if fullVersionUnlocked == true {
                performSegue(withIdentifier: "toolsTimerSegue", sender: nil)
            } else {
               upgradeButton.wiggle()
            }
        } else if indexPath.row == 1 {
            checklistID = 1
            if fullVersionUnlocked == true {
                performSegue(withIdentifier: "toolsChecklistSegue", sender: nil)
            } else {
               upgradeButton.wiggle()
            }
        } else if indexPath.row == 2 {
            checklistID = 2
            if fullVersionUnlocked == true {
                performSegue(withIdentifier: "toolsChecklistSegue", sender: nil)
            } else {
               upgradeButton.wiggle()
            }
        } else if indexPath.row == 3 {
            if fullVersionUnlocked == true {
                performSegue(withIdentifier: "decoderSegue", sender: nil)
            } else {
               upgradeButton.wiggle()
            }
        } else if indexPath.row == 4 {
            if fullVersionUnlocked == true {
                performSegue(withIdentifier: "babyChecklistSegue", sender: nil)
            } else {
               upgradeButton.wiggle()
            }
        }
        else if indexPath.row == 5 {
            performSegue(withIdentifier: "ratingsSegue", sender: nil)
        } else if indexPath.row == 6 {
            textID = 1
            performSegue(withIdentifier: "generalTextSegue", sender: nil)
        } else if indexPath.row == 7 {
            textID = 2
            performSegue(withIdentifier: "generalTextSegue", sender: nil)
        }
        

    }

    // Prepare for segues to pass data across
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toolsChecklistSegue" {
            let checklistSelected : ChecklistViewController = segue.destination as! ChecklistViewController
            checklistSelected.checklistIdentifier = checklistID
        }
        
        if segue.identifier == "generalTextSegue" {
            print("This is the textID: \(textID)")
            let textSelected : TermsAndConditionsViewController = segue.destination as! TermsAndConditionsViewController
            textSelected.textIdentifier = textID
        }
        
    }
}

class TermsAndConditionsViewController : UIViewController {
    
    var textIdentifier : Int = 0
    @IBOutlet weak var contentField: UITextView!
    
    
    override func viewDidLoad() {
        contentField.setContentOffset(CGPoint.zero, animated: false)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if textIdentifier == 1 {
            contentField.text = """
            The Big Daddy
            Version 2.0.0
            © Copyright 2019 Dumpy Devs Ltd
            
            
            Medical information disclaimer
            
            1.    Credit
            1.1    This document was created using a template from SEQ Legal (https://seqlegal.com).
            
            2.    No advice
            2.1    Our app contains general medical information.
            2.2    The medical information is not advice and should not be treated as such.
            
            3.    No warranties
            3.1    The medical information on our app is provided without any representations or warranties, express or implied.
            3.2    Without limiting the scope of Section 3.1, we do not warrant or represent that the medical information on this app:
            (a)    will be constantly available, or available at all; or
            (b)    is true, accurate, complete, current or non-misleading.
            
            4.    Medical assistance
            4.1    You must not rely on the information on our app as an alternative to medical advice from your doctor or other professional healthcare provider.
            4.2    If you have any specific questions about any medical matter, you should consult your doctor or other professional healthcare provider.
            4.3    If you think you may be suffering from any medical condition, you should seek immediate medical attention.
            4.4    You should never delay seeking medical advice, disregard medical advice or discontinue medical treatment because of information on our app.
            
            5.    Limits upon exclusions of liability
            5.1    Nothing in this disclaimer will:
            (a)    limit or exclude any liability for death or personal injury resulting from negligence;
            (b)    limit or exclude any liability for fraud or fraudulent misrepresentation;
            (c)    limit any liabilities in any way that is not permitted under applicable law; or
            (d)    exclude any liabilities that may not be excluded under applicable law.
            """
        } else if textIdentifier == 2 {
            contentField.text = """
            The Big Daddy
            Version 2.0.0
            © Copyright 2019 Dumpy Devs Ltd
            
            
            Image Credits
            
            Icons by:
                - Freepik
                - Smashicon
                - Pixel Perfect
                - Pixel Buddha
                - Roundicons
            
            at www.flaticon.com

            """
        } else {
            contentField.text = ""
        }
    }
    
    
}
