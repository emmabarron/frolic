//
//  AdventureTableViewCell.swift
//  frolic
//
//  Created by Huda T on 10/26/19.
//  Copyright © 2019 adventurers. All rights reserved.
//

import UIKit

class AdventureTableViewCell: UITableViewCell {

    @IBOutlet weak var theNumber: UILabel!
    @IBOutlet weak var theTitle: UILabel!
    @IBOutlet weak var theParagraph: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
