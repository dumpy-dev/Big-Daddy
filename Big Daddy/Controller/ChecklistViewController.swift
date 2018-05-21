//
//  ChecklistViewController.swift
//  
//
//  Created by Georgie and Chris on 19/05/2018.
//

import UIKit

class ChecklistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var checklistTableView: UITableView!
    var babyNamesArray : [String] = []
    var hospitalBagArray : [String] = ["Camera", "Baby clothes", "Phone charger", "Blanket", "Car seat", "House key", "Speaker", "Breast pads", "Book", "car keys", "house keys", "nappies", "change of clothes", "snacks"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checklistTableView.delegate = self
        checklistTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitalBagArray.count
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bagCell") as! HospitalBagTableViewCell
        
        cell.bagItemLabel.text = hospitalBagArray[indexPath.row]
        //cell.checkButton.isHighlighted = false
       
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor(red:0.04, green:0.41, blue:0.49, alpha:1.0)
        } else {
            cell.contentView.backgroundColor = UIColor(red:0.03, green:0.38, blue:0.49, alpha:1.0)
        }
        
        
return cell
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! HospitalBagTableViewCell
    
        if cell.checkImage.image == UIImage(named: "tickOrange") {
                 cell.checkImage.image = UIImage(named: "tickBlue")
        } else {
            cell.checkImage.image = UIImage(named: "tickOrange")
        }
   
        
   
    }
        
        
        
        
    
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


class HospitalBagTableViewCell: UITableViewCell {
    
    

    
    @IBOutlet weak var bagItemLabel: UILabel!
    
    @IBOutlet weak var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
}
