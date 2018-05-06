//
//  ArticlesCustomTableViewCell.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 14/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class ArticlesCustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var suggestedReadingLabel: UILabel!
    @IBOutlet weak var articleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
