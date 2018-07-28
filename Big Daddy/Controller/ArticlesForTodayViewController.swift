//
//  articlesForTodayViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 30/04/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class articlesForTodayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articlesArray : [Int : [String]] = [Int:[String]]()
    
    let weeksElapsed : Int = UserDefaults.standard.integer(forKey: "WeeksElapsed") ?? 1


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        articlesArray = [1: ["Drinking", "Driving", "Eating"], 2:["Caesarean Section", "Exercise", "First Aid"], 3:["Morning Sickness", "Migraines"], 4:["First Aid", "Holidays"], 5: ["Drinking", "Driving", "Eating"], 6: ["Drinking", "Driving", "Eating"], 7: ["Drinking", "Driving", "Eating"], 8: ["Drinking", "Driving", "Eating"], 9: ["Drinking", "Driving", "Eating"], 10: ["Drinking", "Driving", "Eating"], 11: ["Drinking", "Driving", "Eating"], 12: ["Drinking", "Driving", "Eating"], 13: ["Drinking", "Driving", "Eating"], 14: ["Drinking", "Driving", "First Aid"], 15: ["Drinking", "Driving", "Eating"], 16: ["Drinking", "Driving", "Eating"], 17: ["Drinking", "Driving", "Eating"], 18: ["Drinking", "Driving", "Eating"], 19: ["Drinking", "Driving", "Eating"], 20: ["Drinking", "Driving", "Eating"], 21: ["Drinking", "Driving", "Eating"], 22: ["Drinking", "Driving", "Eating"], 23: ["Drinking", "Driving", "Eating"], 24: ["Drinking", "Driving", "Eating"], 25: ["Drinking", "Driving", "Eating"], 26: ["Drinking", "Driving", "Eating"], 27: ["Drinking", "Driving", "Eating"], 28: ["Drinking", "Driving", "Eating"], 29: ["Drinking", "Driving", "Eating"], 30: ["Drinking", "Driving", "Eating"], 31: ["Drinking", "Driving", "Eating"], 32: ["Drinking", "Driving", "Eating"], 33: ["Drinking", "Driving", "Eating"], 34: ["Drinking", "Driving", "Eating"], 35: ["Drinking", "Driving", "Eating"], 36: ["Drinking", "Driving", "Eating"], 37: ["Drinking", "Driving", "Eating"], 38: ["Drinking", "Driving", "Eating"], 39: ["Drinking", "Driving", "Eating"], 40: ["Drinking", "Driving", "Eating"], 41: ["Drinking", "Driving", "Eating"], 42: ["Drinking", "Driving", "Eating"]]
            
        tableView.reloadData()
        
        self.navigationController?.isNavigationBarHidden = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
  
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articlesArray[weeksElapsed]!.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "suggestedReadingCell") as! ArticlesCustomTableViewCell
        let text = articlesArray[weeksElapsed]![indexPath.row]
        cell.suggestedReadingLabel.text = text
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor(red:0.04, green:0.41, blue:0.49, alpha:1.0)
        } else {
            cell.contentView.backgroundColor = UIColor(red:0.03, green:0.38, blue:0.49, alpha:1.0)
        }
        
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell selected")
    }
    
    
    // This is the segue to the article view to display the chosen article and pass the data to the new view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "suggestedReadingSegue" {

            var selectedRowIndex = self.tableView.indexPathForSelectedRow
            let articleSelected : ArticleViewController = segue.destination as! ArticleViewController
            articleSelected.articleID = articlesArray[weeksElapsed]![selectedRowIndex!.row]

        }

    }

}

