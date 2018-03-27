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
    
    // Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // The viewDidLoad will load the array of articles and reload the table view
    override func viewDidLoad() {
        super.viewDidLoad()
        articlesArray = ["Assisted Delivery","Caesarean Section","Drinking","Driving","Eating","Exercise","First Aid","Holidays","Migraines","Morning Sickness","Nose Bleeds","Postnatal Depression","Pre-eclampsia","Sleep Deprivation","Stretch Marks","Vitamin K","Vitamin Supplements",]
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
    
    
    
    // This is the segue to the article view to display the chosen article and pass the data to the new view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "articleSelectedSegue" {
            
        var selectedRowIndex = self.tableView.indexPathForSelectedRow
            var articleSelected : ArticleViewController = segue.destination as! ArticleViewController
            articleSelected.articleID = articlesArray[selectedRowIndex!.row]
            
            print("This is the selected article \(articlesArray[(selectedRowIndex?.row)!])")
      
    }
    
}
}
