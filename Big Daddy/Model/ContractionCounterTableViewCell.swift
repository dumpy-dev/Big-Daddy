//
//  ContractionCounterTableViewCell.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 12/05/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class ContractionCounterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var realTimeLabel: UILabel!
    @IBOutlet weak var contractionTimeLabel: UILabel!
    @IBOutlet weak var contractionGapLabel: UILabel!
    
//    @IBOutlet weak var contractionGapLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
