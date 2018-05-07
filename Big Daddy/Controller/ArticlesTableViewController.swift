//
//  ArticlesTableViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 14/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController {

  
    var articlesArray = [Article]()
    
    var filteredArticles = [Article]()
 let searchController = UISearchController(searchResultsController: nil)
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
        func filterContentForSearchText(_ searchText: String, scope: String = "All") {
            filteredArticles = articlesArray.filter({( articles : Article) -> Bool in
                return articles.name.lowercased().contains(searchText.lowercased())
            })
            
            tableView.reloadData()
        }
        
        
        func isFiltering() -> Bool {
            return searchController.isActive && !searchBarIsEmpty()
        }
    
        
    
    
    // Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // The viewDidLoad will load the array of articles and reload the table view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        articlesArray = [
            
            Article(category:"Chocolate", name:"Assisted Delivery"),
            Article(category:"Chocolate", name:"Caesarean Section"),
            Article(category:"Chocolate", name:"Drinking"),
            Article(category:"Hard", name:"Driving"),
            Article(category:"Hard", name:"Eating"),
            Article(category:"Hard", name:"Exercise"),
            Article(category:"Other", name:"First Aid"),
            Article(category:"Other", name:"Holidays"),
            Article(category:"Other", name:"Migraines"),
            Article(category:"Other", name:"Morning Sickness"),
            Article(category:"Chocolate", name:"Nose Bleeds"),
            Article(category:"Chocolate", name:"Postnatal Depression"),
            Article(category:"Other", name: "Pre-eclampsia"),
            Article(category:"Other", name:"Sleep Deprivation"),
            Article(category:"Hard", name:"Stretch Marks"),
            Article(category:"Hard", name:"Vitamin K"),
             Article(category:"Hard", name:"Vitamin Supplements")
            
            
            
            
//            "Assisted Delivery","Caesarean Section","Drinking","Driving","Eating","Exercise","First Aid","Holidays","Migraines","Morning Sickness","Nose Bleeds","Postnatal Depression","Pre-eclampsia","Sleep Deprivation","Stretch Marks","Vitamin K","Vitamin Supplements"
            ]
        tableView.reloadData()
        
       
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // MARK: - Private instance methods
        
       
            
        }
        
        
        
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filteredArticles.count
        }
        
        return articlesArray.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! ArticlesCustomTableViewCell
        let article: Article
        if isFiltering() {
            article = filteredArticles[indexPath.row]
        } else {
            article = articlesArray[indexPath.row]
        }
        cell.articleLabel!.text = article.name
        
        return cell
    }
    
    
//override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! ArticlesCustomTableViewCell
//    let articles = articlesArray[indexPath.row]
//    cell.articleLabel!.text = articles.name
//
//    if indexPath.row % 2 == 0 {
//        cell.contentView.backgroundColor = UIColor(red:0.04, green:0.41, blue:0.49, alpha:1.0)
//    } else {
//        cell.contentView.backgroundColor = UIColor(red:0.03, green:0.38, blue:0.49, alpha:1.0)
//    }
//
//        return cell
//    }
//
   

    
    // This is the segue to the article view to display the chosen article and pass the data to the new view controller
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "articleSelectedSegue" {
//
//        var selectedRowIndex = self.tableView.indexPathForSelectedRow
//            let articleSelected : ArticleViewController = segue.destination as! ArticleViewController
//            articleSelected.articleID = articlesArray[selectedRowIndex!.row]
//
//    }
//
//}
}

extension ArticlesTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
      filterContentForSearchText(searchController.searchBar.text!)
    }
}
