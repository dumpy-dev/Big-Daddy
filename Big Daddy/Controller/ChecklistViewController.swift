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
    
    var itemArray = ["camera", "phone", "nappies", "food", "charger"]
    
    // Setup table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let bagCell = tableView.dequeueReusableCell(withIdentifier: "checklistCell") as! HospitalBagTableViewCell
        
        let text = itemArray[indexPath.row]
        bagCell.itemName.text = text

        return bagCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let bagCell = tableView.dequeueReusableCell(withIdentifier: "checklistCell") as! HospitalBagTableViewCell
//        bagCell.alpha = 0.1
        print("cell selected")
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
        itemArray.append(addTextField.text!)
            addTextField.text = ""
            animateOut()
            checklistTable.reloadData() }
    }
    
    @IBAction func addCancelled(_ sender: Any) {
        animateOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
