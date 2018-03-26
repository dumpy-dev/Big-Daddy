//
//  ArticlesTableViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 14/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController {

    var articlesArray = [String]()
    
    override var prefersStatusBarHidden: Bool {
        
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        
        articlesArray = ["Drinking","Foods to avoid","Morning sickness","Driving","Holidays","Babymoon","Caesarean section", "assisted delivery","vitamin K","sleep deprivation","first aid","vitamins","migraines","stretch marks","exercise","nose bleeds","preeclampsia","postnatal depression"]
        
        tableView.reloadData()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articlesArray.count
    }

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! ArticlesCustomTableViewCell
    let text = articlesArray[indexPath.row]
    cell.articleLabel.text = text
    
    if indexPath.row % 2 == 0 {
        cell.contentView.backgroundColor = UIColor(red:0.04, green:0.41, blue:0.49, alpha:1.0)
    } else {
        cell.contentView.backgroundColor = UIColor(red:0.03, green:0.38, blue:0.49, alpha:1.0)
    }
    
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("\(indexPath)")
    }
    
    
    

}
