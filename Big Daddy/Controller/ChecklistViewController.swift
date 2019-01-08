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
    
    // MARK:- Setup variables and defaults
    let mother = UserDefaults.standard.object(forKey: "mother") as? String ?? "your partner"
    var checklistIdentifier : Int = 0
    @IBOutlet weak var checklistTable: UITableView!
    @IBOutlet var addPopupView: UIView!
    
    // MARK:- Setup Realm
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
    var clothesDatabase:Results<BabyChecklistRealm> {
        get {
            return realm.objects(BabyChecklistRealm.self).filter("category = 'clothes'")
        }
    }
    var travelDatabase:Results<BabyChecklistRealm> {
        get {
            return realm.objects(BabyChecklistRealm.self).filter("category = 'travel'")
        }
    }
    var nappyDatabase:Results<BabyChecklistRealm> {
        get {
            return realm.objects(BabyChecklistRealm.self).filter("category = 'nappy'")
        }
    }
    var healthDatabase:Results<BabyChecklistRealm> {
        get {
            return realm.objects(BabyChecklistRealm.self).filter("category = 'health'")
        }
    }
    var bathDatabase:Results<BabyChecklistRealm> {
        get {
            return realm.objects(BabyChecklistRealm.self).filter("category = 'bath'")
        }
    }
    var sleepDatabase:Results<BabyChecklistRealm> {
        get {
            return realm.objects(BabyChecklistRealm.self).filter("category = 'sleep'")
        }
    }
    var feedingDatabase:Results<BabyChecklistRealm> {
        get {
            return realm.objects(BabyChecklistRealm.self).filter("category = 'feeding'")
        }
    }
    var miscDatabase:Results<BabyChecklistRealm> {
        get {
            return realm.objects(BabyChecklistRealm.self).filter("category = 'misc'")
        }
    }
    var todoDatabase:Results<BabyChecklistRealm> {
        get {
            return realm.objects(BabyChecklistRealm.self).filter("category = 'todo'")
        }
    }
   
    
    // MARK:- Set up Baby Checklist Arrays
    let clothesArray : [String] = ["Vests", "Coat", "Sleepsuits", "Gloves", "Socks", "Daytime Outfits", "Hats", "Muslins", "Bibs"]
    let travelArray : [String] = ["Carseat", "Mirror", "Sunshade", "Pram (with Bassinet)", " Travel Cot", "Baby Carrier", "Changing Bag", "Foldable Changing Mat"]
    let nappyArray : [String] = ["Nappies", "Nappy Bags", "Wipes", "Bottom Cream", "Changing Mat"]
    let healthArray : [String] = ["Thermometer", "Sudocrem", "Calpol", "Nail Scissors"]
    let bathArray : [String] = ["Bath Thermometer", "Towels", "Flannels", "Baby Bath", "Baby Bubblebath"]
    let sleepingArray : [String] = ["Cot", "Moses Basket", "Swaddling Blankets", "Comforter", "Sleeping Bag", "Sheets", "Waterproof Sheet", "Blanket", "White Noise", "Cot Mattress"]
    let feedingArray : [String] = ["Bottles", "Steriliser", "Formula", "Breast Pump", "Nipple Shield", "Nipple Barrier Cream", "Breast Feeding Cover"]
    let miscArray : [String] = ["Books", "Toys", "Dummy", "Teething Toys", "Non-Bio Washing Powder", "Sense of Humour"]
    let todoArray : [String] = ["Pack Hospital Bag", "Test Fire Alarm", "Test Carbon Monoxide Alarm", "Check Fuel in Car", "Test Route to Hospital", "Wash Baby Clothes", "Build Cot", "Construct Pram", "Fit Car Seat", "Practice Removing Car Seat", "Prepare or Buy Freezer Meals"]

    // Setup table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if checklistIdentifier == 1 {
                return self.itemChecklist.count
        } else if checklistIdentifier == 2 {
                return self.nameList.count
        } else if checklistIdentifier == 3 {
                return clothesDatabase.count
        } else if checklistIdentifier == 4 {
                return travelDatabase.count
        } else if checklistIdentifier == 5 {
                return nappyDatabase.count
        } else if checklistIdentifier == 6 {
                return healthDatabase.count
        } else if checklistIdentifier == 7 {
                return bathDatabase.count
        } else if checklistIdentifier == 8 {
                return sleepDatabase.count
        } else if checklistIdentifier == 9 {
                return feedingDatabase.count
        } else if checklistIdentifier == 10 {
                return miscDatabase.count
        } else {
                return todoDatabase.count
        }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bagCell = tableView.dequeueReusableCell(withIdentifier: "checklistCell") as! HospitalBagTableViewCell
        
        bagCell.tick.image = nil
        func babyChecklistUpdate(){
            let primaryKey = bagCell.itemName.text
            let babyChecklistItem = realm.object(ofType: BabyChecklistRealm.self, forPrimaryKey: primaryKey)
            if babyChecklistItem?.itemCompleted == true {
                bagCell.itemName.alpha = 0.3
                bagCell.tick.image = #imageLiteral(resourceName: "tickOrange")
                bagCell.tick.alpha = 0.3
            } else {
                bagCell.itemName.alpha = 1
                bagCell.tick.alpha = 1
            }
        }
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
            let item = clothesDatabase[indexPath.row]
            bagCell.itemName.text = item.name
            babyChecklistUpdate()
        } else if checklistIdentifier == 4 {
            let item = travelDatabase[indexPath.row]
            bagCell.itemName.text = item.name
            babyChecklistUpdate()
        } else if checklistIdentifier == 5 {
            let item = nappyDatabase[indexPath.row]
            bagCell.itemName.text = item.name
            babyChecklistUpdate()
        } else if checklistIdentifier == 6 {
            let item = healthDatabase[indexPath.row]
            bagCell.itemName.text = item.name
            babyChecklistUpdate()
        } else if checklistIdentifier == 7 {
            let item = bathDatabase[indexPath.row]
            bagCell.itemName.text = item.name
            babyChecklistUpdate()
        } else if checklistIdentifier == 8 {
            let item = sleepDatabase[indexPath.row]
            bagCell.itemName.text = item.name
            babyChecklistUpdate()
        } else if checklistIdentifier == 9 {
            let item = feedingDatabase[indexPath.row]
            bagCell.itemName.text = item.name
            babyChecklistUpdate()
        } else if checklistIdentifier == 10 {
            let item = miscDatabase[indexPath.row]
            bagCell.itemName.text = item.name
            babyChecklistUpdate()
        } else if checklistIdentifier == 11 {
            let item = todoDatabase[indexPath.row]
            bagCell.itemName.text = item.name
            babyChecklistUpdate()
            } else {
                return bagCell
            }
       
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
  
        
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
            let selectedCell = tableView.cellForRow(at: indexPath) as! HospitalBagTableViewCell
            let primaryKey = selectedCell.itemName.text
            let item = realm.object(ofType: BabyChecklistRealm.self, forPrimaryKey: primaryKey)
            try! self.realm.write({
                self.realm.delete(item!)
            })
            tableView.deleteRows(at:[indexPath], with: .automatic)
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        func babyChecklistCheck(){
            let babyChecklistItem = BabyChecklistRealm()
            let selectedCell = tableView.cellForRow(at: indexPath) as! HospitalBagTableViewCell
            let cellText = selectedCell.itemName.text
            print("cell selected")
            babyChecklistItem.name = cellText!
           
            let primaryKey = selectedCell.itemName.text
            let babyChecklistItem2 = realm.object(ofType: BabyChecklistRealm.self, forPrimaryKey: primaryKey)
            if babyChecklistItem2?.itemCompleted == true {
                selectedCell.itemName.alpha = 0.3
                selectedCell.tick.image = #imageLiteral(resourceName: "tickOrange")
                selectedCell.tick.alpha = 0.3
            } else {
                selectedCell.itemName.alpha = 1
                selectedCell.tick.image = #imageLiteral(resourceName: "briefcase")
                selectedCell.tick.alpha = 1
            }
            try! realm.write {
                if babyChecklistItem2?.itemCompleted == false {
                    babyChecklistItem2?.itemCompleted = true
                }else{
                    babyChecklistItem2?.itemCompleted = false
                }
                realm.add(babyChecklistItem2!, update: true)
            }
            
            
        }
        
        if checklistIdentifier == 1 {
            let item = itemChecklist[indexPath.row]
            try! self.realm.write({
                if (item.itemPacked == false){
                    item.itemPacked = true
                }else{
                    item.itemPacked = false
                }
            })
        }  else if checklistIdentifier >= 3 {
            babyChecklistCheck()
        }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
        
    
    // MARK:- Functions for animating and adding values
    
    func animateIn() {
        self.view.addSubview(addPopupView)
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
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
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.checklistTable.alpha = 1.0
        }, completion: nil)
        addTextField.resignFirstResponder()
    }
    
    @IBOutlet weak var addTextField: UITextField!
    
    @IBAction func addPressed(_ sender: Any) {
        animateIn()
    }
    
    @IBAction func addCompleted(_ sender: Any) {
        if addTextField.text != "" {
            if checklistIdentifier == 1 {
            let checklistItem = ChecklistRealm()
            checklistItem.item = addTextField.text!
            checklistItem.itemPacked = false
            try! self.realm.write({
                self.realm.add(checklistItem)
            })
        } else if checklistIdentifier == 2 {
            let nameItem = NameRealm()
        nameItem.name = addTextField.text!
            try! self.realm.write({
                self.realm.add(nameItem)
            })
            } else if checklistIdentifier == 3 {
                let checklistItem = BabyChecklistRealm()
                checklistItem.name = addTextField.text!
                checklistItem.itemCompleted = false
                checklistItem.category = "clothes"
                try! self.realm.write({
                    self.realm.add(checklistItem)
                })
            } else if checklistIdentifier == 4 {
                let checklistItem = BabyChecklistRealm()
                checklistItem.name = addTextField.text!
                checklistItem.itemCompleted = false
                checklistItem.category = "travel"
                try! self.realm.write({
                    self.realm.add(checklistItem)
                })
            } else if checklistIdentifier == 5 {
                let checklistItem = BabyChecklistRealm()
                checklistItem.name = addTextField.text!
                checklistItem.itemCompleted = false
                checklistItem.category = "nappy"
                try! self.realm.write({
                    self.realm.add(checklistItem)
                })
            } else if checklistIdentifier == 6 {
                let checklistItem = BabyChecklistRealm()
                checklistItem.name = addTextField.text!
                checklistItem.itemCompleted = false
                checklistItem.category = "health"
                try! self.realm.write({
                    self.realm.add(checklistItem)
                })
            } else if checklistIdentifier == 7 {
                let checklistItem = BabyChecklistRealm()
                checklistItem.name = addTextField.text!
                checklistItem.itemCompleted = false
                checklistItem.category = "bath"
                try! self.realm.write({
                    self.realm.add(checklistItem)
                })
            } else if checklistIdentifier == 8 {
                let checklistItem = BabyChecklistRealm()
                checklistItem.name = addTextField.text!
                checklistItem.itemCompleted = false
                checklistItem.category = "sleep"
                try! self.realm.write({
                    self.realm.add(checklistItem)
                })
            } else if checklistIdentifier == 9 {
                let checklistItem = BabyChecklistRealm()
                checklistItem.name = addTextField.text!
                checklistItem.itemCompleted = false
                checklistItem.category = "feeding"
                try! self.realm.write({
                    self.realm.add(checklistItem)
                })
            } else if checklistIdentifier == 10 {
                let checklistItem = BabyChecklistRealm()
                checklistItem.name = addTextField.text!
                checklistItem.itemCompleted = false
                checklistItem.category = "misc"
                try! self.realm.write({
                    self.realm.add(checklistItem)
                })
            } else if checklistIdentifier == 11 {
                let checklistItem = BabyChecklistRealm()
                checklistItem.name = addTextField.text!
                checklistItem.itemCompleted = false
                checklistItem.category = "todo"
                try! self.realm.write({
                    self.realm.add(checklistItem)
                })
            }
        }
            addTextField.text = ""
            animateOut()
            checklistTable.reloadData()
    }
    
    @IBAction func addCancelled(_ sender: Any) {
        animateOut()
    }
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", realm.configuration.fileURL!)
     
        barButton.isEnabled = true
        barButton.tintColor = nil
        
        // MARK:- Setup the standard item list for:
            // Hopsital bag checklist
        if itemChecklist.count == 0 && checklistIdentifier == 1 {
            let defaultItemArray = ["Nappies (lots)", "Baby wipes", "Baby vests (x3)", "Baby sleepsuit (x3)", "Baby hats (x3)", "Baby socks", "Baby blanket", "Muslins", "Baby nail scissors", "Comfortable clothes (for \(mother))", "Slippers (for \(mother))", "Dressing gown (for \(mother))", "Pyjamas (for \(mother))", "Going home outfits (for everyone)", "Washbag", "Maternity pads", "Breast pads", "Snacks", "Phone chargers", "Speakers", "Change for parking", "Books/Magazines/iPad", "Blanket/Pillow for you", "Change of clothes for you", "Maternity notes"]
            for item in defaultItemArray{
            let checklistItem = ChecklistRealm()
            checklistItem.item = item
            checklistItem.itemPacked = false
            try! self.realm.write({
                self.realm.add(checklistItem)
            })
            }
            // Name list
        } else if nameList.count == 0 && checklistIdentifier == 2 {
            let defaultItemArray = ["Maximus Decimus Meridius", "The Artist Formerly Known as Prince"]
            for item in defaultItemArray{
                let nameItem = NameRealm()
                nameItem.name = item
                try! self.realm.write({
                    self.realm.add(nameItem)
                })
            }
        } else if clothesDatabase.count == 0 && checklistIdentifier == 3 {
            
            print("nothing yet added, so defaults implemented")
            let defaultArray = clothesArray
            for item in defaultArray {
                let babyItem = BabyChecklistRealm()
                babyItem.name = item
                babyItem.itemCompleted = false
                babyItem.category = "clothes"
                try! self.realm.write({
                    self.realm.add(babyItem)
                })
            }
        } else if travelDatabase.count == 0 && checklistIdentifier == 4 {
            print("nothing yet added, so defaults implemented")
            let defaultArray = travelArray
            for item in defaultArray {
                print(item)
                let babyItem = BabyChecklistRealm()
                babyItem.name = item
                babyItem.itemCompleted = false
                babyItem.category = "travel"
                try! self.realm.write({
                    self.realm.add(babyItem)
                })
            }
        } else if nappyDatabase.count == 0 && checklistIdentifier == 5  {
            print("nothing yet added, so defaults implemented")
            let defaultArray = nappyArray
            for item in defaultArray {
                print(item)
                let babyItem = BabyChecklistRealm()
                babyItem.name = item
                babyItem.itemCompleted = false
                babyItem.category = "nappy"
                try! self.realm.write({
                    self.realm.add(babyItem)
                })
            }
        } else if healthDatabase.count == 0 &&  checklistIdentifier == 6 {
            print("nothing yet added, so defaults implemented")
            let defaultArray = healthArray
            for item in defaultArray{
                print(item)
                let babyItem = BabyChecklistRealm()
                babyItem.name = item
                babyItem.itemCompleted = false
                babyItem.category = "health"
                try! self.realm.write({
                    self.realm.add(babyItem)
                })
            }
        } else if bathDatabase.count == 0 &&  checklistIdentifier == 7 {
            print("nothing yet added, so defaults implemented")
            let defaultArray = bathArray
            for item in defaultArray{
                print(item)
                let babyItem = BabyChecklistRealm()
                babyItem.name = item
                babyItem.itemCompleted = false
                babyItem.category = "bath"
                try! self.realm.write({
                    self.realm.add(babyItem)
                })
            }
        } else if sleepDatabase.count == 0 &&  checklistIdentifier == 8 {
            print("nothing yet added, so defaults implemented")
            let defaultArray = sleepingArray
            for item in defaultArray{
                print(item)
                let babyItem = BabyChecklistRealm()
                babyItem.name = item
                babyItem.itemCompleted = false
                babyItem.category = "sleep"
                try! self.realm.write({
                    self.realm.add(babyItem)
                })
            }
        } else if feedingDatabase.count == 0 &&  checklistIdentifier == 9 {
            print("nothing yet added, so defaults implemented")
            let defaultArray = feedingArray
            for item in defaultArray{
                print(item)
                let babyItem = BabyChecklistRealm()
                babyItem.name = item
                babyItem.itemCompleted = false
                babyItem.category = "feeding"
                try! self.realm.write({
                    self.realm.add(babyItem)
                })
            }
        } else if miscDatabase.count == 0 &&  checklistIdentifier == 10 {
            print("nothing yet added, so defaults implemented")
            let defaultArray = miscArray
            for item in defaultArray{
                print(item)
                let babyItem = BabyChecklistRealm()
                babyItem.name = item
                babyItem.itemCompleted = false
                babyItem.category = "misc"
                try! self.realm.write({
                    self.realm.add(babyItem)
                })
            }
        } else if todoDatabase.count == 0 &&  checklistIdentifier == 11 {
            print("nothing yet added, so defaults implemented")
            let defaultArray = todoArray
            for item in defaultArray{
                print(item)
                let babyItem = BabyChecklistRealm()
                babyItem.name = item
                babyItem.itemCompleted = false
                babyItem.category = "todo"
                try! self.realm.write({
                    self.realm.add(babyItem)
                })
            }
            }
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

