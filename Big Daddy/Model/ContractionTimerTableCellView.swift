//
//  ContractionTimerTableCellView.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 08/06/2019.
//  Copyright © 2019 Dumpy Developments. All rights reserved.
//

import UIKit

class ContractionTimerTableCellView: UITableViewCell {

    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var contractionTimeLabel: UILabel!
    
    @IBOutlet weak var contractionStrengthLabel: UILabel!
    @IBOutlet weak var intervalTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
