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
                return articles.keyword.lowercased().contains(searchText.lowercased())
            })
            tableView.reloadData()
        }
    
        func isFiltering() -> Bool {
            return searchController.isActive && !searchBarIsEmpty()
        }

    //Hide the status bar
    override func viewDidAppear(_ animated: Bool) {
         var prefersStatusBarHidden: Bool {
            return true
        }
        
    }
    // The viewDidLoad will load the array of articles and reload the table view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting the search bar attributes
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        searchController.searchBar.tintColor = .white
        
        //Setup the arrays
        
        articlesArray = [
            Article(keyword:"assisted delivery ventouse suction theatre", name:"Assisted Delivery"),
            Article(keyword:"caesarian c-section operation theatre surgery gestational diabetes breech emergency procedure labour progressing vaginal birth baby pre-eclampsia recovery plan pain anaesthetic general spinal infection delivery sunroof alien scar tummy hospital", name:"Caesarean Section"),
            Article(keyword:"drinking alcohol beer wine syndrome FAS units", name:"Drinking"),
            Article(keyword:"driving car license seatbelt", name:"Driving"),
            Article(keyword:"eating food egg cheese pate fish salami sushi brie peanut liquorice feta mozzarella pizza cured meats smoked salmon seafood shellfish prawns", name:"Eating"),
            Article(keyword:"exercise", name:"Exercise"),
            Article(keyword:"first aid injury bleeding breathing not heart emergency", name:"First Aid"),
            Article(keyword:"holidays vacation flying aeroplane airplane boat skiing", name:"Holidays"),
            Article(keyword:"migraines headaches sick", name:"Migraines"),
            Article(keyword:"morning sickness vomiting nausea queasy ginger", name:"Morning Sickness"),
            Article(keyword:"nose bleeds epistaxis", name:"Nose Bleeds"),
            Article(keyword:"postnatal depression PND low mood down", name:"Postnatal Depression"),
            Article(keyword:"pre-eclampsia hypertension blood pressure", name: "Pre-eclampsia"),
            Article(keyword:"signs of labour cot hospital bag big bump kick off prepare get ready signs symptoms on the way waters breaking gush suspect maternity unit birth en caul amniotic sac intact very rare contractions starting braxton hicks real fake practice painful increase intensity stop start timer keep track persistent lower back pain tummy cramps brownish blood tinged mucus discharge funny disrupted sleep midwife midwives five minutes rules call telephone starting advice cannoli jelly baby babies scarface godfather", name: "Signs of Labour"),
            Article(keyword:"sleep deprivation tired sleepy nap", name:"Sleep Deprivation"),
            Article(keyword:"stretch marks scar moisturiser moisturizer", name:"Stretch Marks"),
            Article(keyword:"vitamin k injection tablet birth", name:"Vitamin K"),
             Article(keyword:"vitamin supplements tablet a c d folic acid iron calcium", name:"Vitamin Supplements")
            ]
        tableView.reloadData()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "is it me you're looking for?"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        if indexPath.row % 2 == 0 {
                    cell.contentView.backgroundColor = UIColor(red:0.04, green:0.41, blue:0.49, alpha:1.0)
                } else {
                    cell.contentView.backgroundColor = UIColor(red:0.03, green:0.38, blue:0.49, alpha:1.0)
                }
        return cell
    }
    
    // This is the segue to the article view to display the chosen article and pass the data to the new view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "articleSelectedSegue" {

            let article: Article
         
        var selectedRowIndex = self.tableView.indexPathForSelectedRow
            
            if isFiltering() {
                
                article = filteredArticles[selectedRowIndex!.row]
            } else {
            article = articlesArray[selectedRowIndex!.row]
            }
            
            let articleSelected : ArticleViewController = segue.destination as! ArticleViewController
            articleSelected.articleID = article.name

    }

}
}

extension ArticlesTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
      filterContentForSearchText(searchController.searchBar.text!)
    }
}
