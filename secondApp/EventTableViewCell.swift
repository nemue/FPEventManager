//
//  EventTableViewCell.swift
//  secondApp
//
//  Created by Nele Müller on 16.04.18.
//  Copyright © 2018 Nele Müller. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventAllDaySwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
