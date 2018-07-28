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
    
    @IBOutlet weak var checklistTable: UITableView!
    @IBOutlet var addPopupView: UIView!
    var checklistIdentifier : Int = 0
    
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
    

    
    // Setup table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        if checklistIdentifier == 1 {
        return self.itemChecklist.count
        } else {
            return self.nameList.count
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
        } else {
            
            let item = nameList[indexPath.row]
            
            bagCell.itemName.text = item.name
            bagCell.tick.image = nil
            bagCell.selectionStyle = .none

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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) && checklistIdentifier == 1 {
            let item = itemChecklist[indexPath.row]
            try! self.realm.write({
                self.realm.delete(item)
            })
        
            tableView.deleteRows(at:[indexPath], with: .automatic)
            tableView.reloadData()
        } else {
            let item = nameList[indexPath.row]
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
        
            // Setup the standard item list
        if itemChecklist.count == 0 && checklistIdentifier == 1 {
            print("nothing yet added, so defaults implemented")
            let defaultItemArray = ["Camera", "Nappies", "Car Keys", "Phone Charger", "x2 BabyGro", "Baby Hat", "Baby Gloves", "Breast Pads", "Pillow", "Speakers"]
            for item in defaultItemArray{
                print(item)
            let checklistItem = ChecklistRealm()
            checklistItem.item = item
            checklistItem.itemPacked = false
            try! self.realm.write({
                self.realm.add(checklistItem)
            })
            }
        } else if itemChecklist.count == 0 && checklistIdentifier == 2 {
            print("nothing yet added, so defaults implemented")
            let defaultItemArray = ["Freddy", "Poppy", "Aurora", "Maximus Decimus Meridius"]
            for item in defaultItemArray{
                print(item)
                let nameItem = NameRealm()
                nameItem.name = item
                try! self.realm.write({
                    self.realm.add(nameItem)
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
