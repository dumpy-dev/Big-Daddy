//
//  ChecklistViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 30/06/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit
import RealmSwift

class ChecklistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    // Set up variables and defaults
    let mother = UserDefaults.standard.object(forKey: "mother") as? String ?? "your partner"
    var checklistIdentifier : Int = 0
    @IBOutlet weak var checklistTable: UITableView!
    @IBOutlet var addPopupView: UIView!
    
    
    // Set up Realm
    let realm = try! Realm()
    var itemChecklist:Results<ChecklistRealm> {
        get {
            return realm.objects(ChecklistRealm.self)
        }
    }
    var nameList:Results<NameRealm> {
        get {
            return realm.objects(NameRealm.self)
        }
    }
    var babyChecklist:Results<BabyChecklistRealm> {
        get {
            return realm.objects(BabyChecklistRealm.self)
        }
    }
    // Set up Baby Checklist Arrays
    var defaultArray : [String] = ["Vests", "Coat", "Sleepsuits", "Gloves", "Socks", "Daytime Outfits", "Hats", "Muslins", "Bibs", "Carseat", "Mirror", "Sunshade", "Pram (with bassinet)", " Travel Cot", "Baby carrier", "Changing bag", "Foldable Changing Mat"]
    let clothesArray : [String] = ["Vests", "Coat", "Sleepsuits", "Gloves", "Socks", "Daytime Outfits", "Hats", "Muslins", "Bibs"]
    let travelArray : [String] = ["Carseat", "Mirror", "Sunshade", "Pram (with bassinet)", " Travel Cot", "Baby carrier", "Changing bag", "Foldable Changing Mat"]
    let nappyArray : [String] = ["Nappies", "Nappy bags", "Wipes", "Bottom cream", "Changing Mat"]
    let healthArray : [String] = ["Thermometer", "Sudacrem", "Calpol", "Nail Scissors"]
    let bathArray : [String] = ["Bath Thermometer", "Towels", "Flannels", "Baby Bath", "Baby Bubblebath"]
    let sleepingArray : [String] = ["Cot", "Moses Basket", "Swaddling Blankets", "Comforter", "Sleeping Bag", "Sheets", "Waterproof Sheet", "Blanket", "White Noise", "Cot Mattress"]
    let feedingArray : [String] = ["Bottles", "Steriliser", "Formula", "Breast Pump", "Nipple Shield", "Nipple Barrier Cream", "Breast Feeding Cover"]
    let miscArray : [String] = ["Books", "Toys", "Dummy", "Teething Toys", "Non-Bio Washing Powder", "Sense of Humour"]
    let todoArray : [String] = ["Pack Hospital Bag", "Test Fire Alarm", "Test Carbon Monoxide Alarm", "Check Fuel in Car", "Test Route to Hospital", "Wash Baby Clothes", "Build Cot", "Construct Pram", "Fit Car Seat", "Practice Removing Car Seat", "Prepare or Buy Freezer Meals"]

    // Setup table
    func numberOfSections(in tableView: UITableView) -> Int {
        if checklistIdentifier <= 2 {
        return 1
        } else {
            return 9
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        if checklistIdentifier >= 3 {
        if section == 0 {
        return "Clothes"
        } else if section == 1 {
            return "Travel"
        } else if section == 2 {
            return "Nappy"
        }else if section == 3 {
            return "Health"
        }else if section == 4 {
            return "Bathtime"
        } else if section == 5 {
            return "Sleeping"
        } else if section == 6 {
            return "Feeding"
        }else if section == 7 {
            return "Miscellaneous"
        }else if section == 8 {
            return "To Do"
        }
    }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        if checklistIdentifier == 1 {
        return self.itemChecklist.count
        } else if checklistIdentifier == 2 {
            return self.nameList.count
        } else if checklistIdentifier >= 3 {
            if section == 0 {
        return self.clothesArray.count
        } else if section == 1 {
        return self.travelArray.count
        } else if section == 2  {
        return self.nappyArray.count
        } else if section == 3 {
        return self.healthArray.count
        } else if section == 4 {
        return self.bathArray.count
        } else if section == 5 {
        return self.sleepingArray.count
        } else if section == 6 {
        return self.feedingArray.count
        } else if section == 7 {
        return self.miscArray.count
        } else {
        return self.todoArray.count
        }
        } else {
            return 1
        }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let bagCell = tableView.dequeueReusableCell(withIdentifier: "checklistCell") as! HospitalBagTableViewCell
        
        if checklistIdentifier == 1 {
        let item = itemChecklist[indexPath.row]
    
        bagCell.itemName.text = item.item

        if item.itemPacked == true {
            bagCell.itemName.alpha = 0.3
            bagCell.tick.image = #imageLiteral(resourceName: "tickOrange")
            bagCell.tick.alpha = 0.3
        } else {
            bagCell.itemName.alpha = 1
            bagCell.tick.image = #imageLiteral(resourceName: "briefcase")
            bagCell.tick.alpha = 1
            }
        } else if checklistIdentifier == 2 {
            
            let item = nameList[indexPath.row]
            
            bagCell.itemName.text = item.name
            bagCell.tick.image = nil
            bagCell.selectionStyle = .none

          } else if checklistIdentifier == 3 {

                if indexPath.section == 0 {
                bagCell.itemName.text = clothesArray[indexPath.row]
                } else if indexPath.section == 1 {
                    bagCell.itemName.text = travelArray[indexPath.row]
                } else if indexPath.section == 2  {
                    bagCell.itemName.text = nappyArray[indexPath.row]
                } else if indexPath.section == 3 {
                    bagCell.itemName.text = healthArray[indexPath.row]
                } else if indexPath.section == 4 {
                    bagCell.itemName.text = bathArray[indexPath.row]
                } else if indexPath.section == 5 {
                    bagCell.itemName.text = sleepingArray[indexPath.row]
                } else if indexPath.section == 6 {
                    bagCell.itemName.text = feedingArray[indexPath.row]
                } else if indexPath.section == 7 {
                    bagCell.itemName.text = miscArray[indexPath.row]
                } else {
                    bagCell.itemName.text = todoArray[indexPath.row]
                }
            } else {
                return bagCell
            }
       
        if  bagCell.isSelected == true {
            print (indexPath.row)
        }
            
         // let item = babyChecklist[indexPath.row]
            
          //  bagCell.itemName.text = defaultArray[indexPath.row]
           
            
//            if item.itemCompleted == true {
//                bagCell.itemName.alpha = 0.3
//                bagCell.tick.image = #imageLiteral(resourceName: "tickOrange")
//                bagCell.tick.alpha = 0.3
//            } else {
//                bagCell.itemName.alpha = 1
//                bagCell.tick.image = #imageLiteral(resourceName: "briefcase")
//                bagCell.tick.alpha = 1
//            }
        
    
//    } else if checklistIdentifier == 4 {
//    return self.travelArray.count
//    } else if checklistIdentifier == 5 {
//    return self.nappyArray.count
//    } else if checklistIdentifier == 6 {
//    return self.healthArray.count
//    } else if checklistIdentifier == 7 {
//    return self.bathArray.count
//    } else if checklistIdentifier == 8 {
//    return self.sleepingArray.count
//    } else if checklistIdentifier == 9 {
//    return self.feedingArray.count
//    } else if checklistIdentifier == 10 {
//    return self.miscArray.count
//    } else {
//    return self.todoArray.count
//    }
        
        
        

        if indexPath.row % 2 == 0 {
            bagCell.contentView.backgroundColor = UIColor(red:0.04, green:0.41, blue:0.49, alpha:1.0)
        } else {
            bagCell.contentView.backgroundColor = UIColor(red:0.03, green:0.38, blue:0.49, alpha:1.0)
        }

        return bagCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
  
        
        if (editingStyle == .delete) && checklistIdentifier == 1 {
            let item = itemChecklist[indexPath.row]
            try! self.realm.write({
                self.realm.delete(item)
            })
        
            tableView.deleteRows(at:[indexPath], with: .automatic)
            tableView.reloadData()
        } else if (editingStyle == .delete) && checklistIdentifier == 2 {
            let item = nameList[indexPath.row]
            try! self.realm.write({
                self.realm.delete(item)
            })
            
            tableView.deleteRows(at:[indexPath], with: .automatic)
            tableView.reloadData()
        } else if (editingStyle == .delete) && checklistIdentifier != 1 && checklistIdentifier != 2 {
            let item = babyChecklist[indexPath.row]
            try! self.realm.write({
                self.realm.delete(item)
            })
            
            tableView.deleteRows(at:[indexPath], with: .automatic)
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if checklistIdentifier == 1 {
            let item = itemChecklist[indexPath.row]
            try! self.realm.write({
                if (item.itemPacked == false){
                    item.itemPacked = true
                }else{
                    item.itemPacked = false
                }
            })
        } else  if checklistIdentifier != 1 && checklistIdentifier != 2 {
            print(indexPath.row)
            let row = indexPath.row
            let section = indexPath.section
            
//            let item = babyChecklist[indexPath.row]
//            try! self.realm.write({
//                if (item.itemCompleted == false){
//                    item.itemCompleted = true
//                }else{
//                    item.itemCompleted = false
//                }
//            })
        }

            tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
        
    }
        
    
    // Setup functions
    
    func animateIn() {
    self.view.addSubview(addPopupView)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.checklistTable.alpha = 0.2
        }, completion: nil)
        addTextField.becomeFirstResponder()
    addPopupView.center.x = self.view.center.x
        addPopupView.frame.origin.y = self.view.frame.height / 4
    addPopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
   addPopupView.alpha = 0
    UIView.animate(withDuration: 0.4) {
    self.addPopupView.alpha = 1
    self.addPopupView.transform = CGAffineTransform.identity
    }
    }
    
    func animateOut() {
        self.addPopupView.removeFromSuperview()
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.checklistTable.alpha = 1.0
        }, completion: nil)
        addTextField.resignFirstResponder()
    }
    
    @IBOutlet weak var addTextField: UITextField!
    
    @IBAction func addPressed(_ sender: Any) {
        animateIn()
    }
    
    @IBAction func addCompleted(_ sender: Any) {
        if addTextField.text != "" && checklistIdentifier == 1 {
            
            let checklistItem = ChecklistRealm()
            checklistItem.item = addTextField.text!
            checklistItem.itemPacked = false
            try! self.realm.write({
                self.realm.add(checklistItem)
            })
        
        } else {
            let nameItem = NameRealm()
        nameItem.name = addTextField.text!
            try! self.realm.write({
                self.realm.add(nameItem)
            })
            
        }
            addTextField.text = ""
            animateOut()
            checklistTable.reloadData()
    
    }
    
    @IBAction func addCancelled(_ sender: Any) {
        animateOut()
    }
    

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if checklistIdentifier >= 3 {
            
           barButton.isEnabled = false
            barButton.tintColor = UIColor.clear
        } else {
            barButton.isEnabled = true
            barButton.tintColor = nil
        }
        
            // Setup the standard item list
        if itemChecklist.count == 0 && checklistIdentifier == 1 {
            print("nothing yet added, so defaults implemented")
            let defaultItemArray = ["Nappies (lots)", "Baby wipes", "Baby vests (x3)", "Baby sleepsuit (x3)", "Baby hats (x3)", "Baby socks", "Baby blanket", "Muslins", "Baby nail scissors", "Comfortable clothes (for \(mother))", "Slippers (for \(mother))", "Dressing gown (for \(mother))", "Pyjamas (for \(mother))", "Going home outfits (for everyone)", "Washbag", "Maternity pads", "Breast pads", "Snacks", "Phone chargers", "Speakers", "Change for parking", "Books/Magazines/iPad", "Blanket/Pillow for you", "Change of clothes for you", "Maternity notes"]
            for item in defaultItemArray{
                print(item)
            let checklistItem = ChecklistRealm()
            checklistItem.item = item
            checklistItem.itemPacked = false
            try! self.realm.write({
                self.realm.add(checklistItem)
            })
            }
        } else if nameList.count == 0 && checklistIdentifier == 2 {
            print("nothing yet added, so defaults implemented")
            let defaultItemArray = ["Maximus Decimus Meridius"]
            for item in defaultItemArray{
                print(item)
                let nameItem = NameRealm()
                nameItem.name = item
                try! self.realm.write({
                    self.realm.add(nameItem)
                })
            }
//        } else if babyChecklist.count == 0 && checklistIdentifier == 3 {
//            print("nothing yet added, so defaults implemented")
//            defaultArray = ["Vests", "Coat", "Sleepsuits", "Gloves", "Socks", "Daytime Outfits", "Hats", "Muslins", "Bibs", "test"]
//            for item in defaultArray {
//                print(item)
//                let babyItem = BabyChecklistRealm()
//                babyItem.name = item
//                try! self.realm.write({
//                    self.realm.add(babyItem)
//                })
//            }
  }
            // else if checklistIdentifier == 4 {
//            print("nothing yet added, so defaults implemented")
//            defaultArray = ["Carseat", "Mirror", "Sunshade", "Pram (with bassinet)", " Travel Cot", "Baby carrier", "Changing bag", "Foldable Changing Mat"]
//            for item in defaultArray {
//                print(item)
//                let babyItem = BabyChecklistRealm()
//                babyItem.name = item
//                try! self.realm.write({
//                    self.realm.add(babyItem)
//                })
//            }
//        } else if checklistIdentifier == 5  {
//            print("nothing yet added, so defaults implemented")
//            defaultArray = ["Nappies", "Nappy bags", "Wipes", "Bottom cream", "Changing Mat"]
//            for item in defaultArray {
//                print(item)
//                let babyItem = BabyChecklistRealm()
//                babyItem.name = item
//                try! self.realm.write({
//                    self.realm.add(babyItem)
//                })
//            }
//        } else if checklistIdentifier == 6 {
//            print("nothing yet added, so defaults implemented")
//            let defaultArray = ["Thermometer", "Sudacrem", "Calpol", "Nail Scissors"]
//            for item in defaultArray{
//                print(item)
//                let babyItem = BabyChecklistRealm()
//                babyItem.name = item
//                try! self.realm.write({
//                    self.realm.add(babyItem)
//                })
//            }
//        }else if checklistIdentifier == 7 {
//            print("nothing yet added, so defaults implemented")
//            let defaultArray = ["Bath Thermometer", "Towels", "Flannels", "Baby Bath", "Baby Bubblebath"]
//            for item in defaultArray{
//                print(item)
//                let babyItem = BabyChecklistRealm()
//                babyItem.name = item
//                try! self.realm.write({
//                    self.realm.add(babyItem)
//                })
//            }
//        }else if checklistIdentifier == 8 {
//            print("nothing yet added, so defaults implemented")
//            let defaultArray = ["Cot", "Moses Basket", "Swaddling Blankets", "Comforter", "Sleeping Bag", "Sheets", "Waterproof Sheet", "Blanket", "White Noise", "Cot Mattress"]
//            for item in defaultArray{
//                print(item)
//                let babyItem = BabyChecklistRealm()
//                babyItem.name = item
//                try! self.realm.write({
//                    self.realm.add(babyItem)
//                })
//            }
//        } else if checklistIdentifier == 9 {
//            print("nothing yet added, so defaults implemented")
//            let defaultArray = ["Bottles", "Steriliser", "Formula", "Breast Pump", "Nipple Shield", "Nipple Barrier Cream", "Breast Feeding Cover"]
//            for item in defaultArray{
//                print(item)
//                let babyItem = BabyChecklistRealm()
//                babyItem.name = item
//                try! self.realm.write({
//                    self.realm.add(babyItem)
//                })
//            }
//        } else if checklistIdentifier == 10 {
//            print("nothing yet added, so defaults implemented")
//            let defaultArray = ["Books", "Toys", "Dummy", "Teething Toys", "Non-Bio Washing Powder", "Sense of Humour"]
//            for item in defaultArray{
//                print(item)
//                let babyItem = BabyChecklistRealm()
//                babyItem.name = item
//                try! self.realm.write({
//                    self.realm.add(babyItem)
//                })
//            }
//        } else if checklistIdentifier == 11 {
//            print("nothing yet added, so defaults implemented")
//            let defaultArray = ["Pack Hospital Bag", "Test Fire Alarm", "Test Carbon Monoxide Alarm", "Check Fuel in Car", "Test Route to Hospital", "Wash Baby Clothes", "Build Cot", "Construct Pram", "Fit Car Seat", "Practice Removing Car Seat", "Prepare or Buy Freezer Meals"]
//            for item in defaultArray{
//                print(item)
//                let babyItem = BabyChecklistRealm()
//                babyItem.name = item
//                try! self.realm.write({
//                    self.realm.add(babyItem)
//                })
//            }
        
        
        
        
        
        
        
        
        
        
        checklistTable.reloadData()
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

class HospitalBagTableViewCell : UITableViewCell {
    
    @IBOutlet weak var tick: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class addItemTableViewCell : UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
