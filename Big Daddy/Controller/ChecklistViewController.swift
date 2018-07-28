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
    let realm = try! Realm()
    var itemChecklist:Results<ChecklistRealm> {
        get {
            return realm.objects(ChecklistRealm.self)
        }
    }
    

    
    // Setup table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemChecklist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let bagCell = tableView.dequeueReusableCell(withIdentifier: "checklistCell") as! HospitalBagTableViewCell
        
        let item = itemChecklist[indexPath.row]
        bagCell.itemName.text = item.name

        if item.itemPacked == true {
            print("\(item.name) is already packed")
            bagCell.itemName.alpha = 0.3
            bagCell.tick.image = #imageLiteral(resourceName: "tickOrange")
            bagCell.tick.alpha = 0.3
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
        
        if (editingStyle == .delete){
            let item = itemChecklist[indexPath.row]
            try! self.realm.write({
                self.realm.delete(item)
            })
            
            tableView.deleteRows(at:[indexPath], with: .automatic)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let item = itemChecklist[indexPath.row]
            try! self.realm.write({
                if (item.itemPacked == false){
                    item.itemPacked = true
                }else{
                    item.itemPacked = false
                }
            })
            tableView.reloadRows(at: [indexPath], with: .automatic)
        
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
        if addTextField.text != "" {
            
            print("You added \(addTextField.text)")
            let checklistItem = ChecklistRealm()
            checklistItem.name = addTextField.text!
            checklistItem.itemPacked = false
            try! self.realm.write({
                self.realm.add(checklistItem)
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
        if itemChecklist.count == 0 {
            print("nothing yet added, so defaults implemented")
            let defaultItemArray = ["Camera", "Nappies", "Car Keys", "Phone Charger", "x2 BabyGro", "Baby Hat", "Baby Gloves", "Breast Pads", "Pillow", "Speakers"]
            for item in defaultItemArray{
                print(item)
            let checklistItem = ChecklistRealm()
            checklistItem.name = item
            checklistItem.itemPacked = false
            try! self.realm.write({
                self.realm.add(checklistItem)
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
