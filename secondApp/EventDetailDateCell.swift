//
//  EventDetailDateCell.swift
//  secondApp
//
//  Created by Nele Müller on 26.04.18.
//  Copyright © 2018 Nele Müller. All rights reserved.
//

import UIKit

class EventDetailDateCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Configuration
    
    func configure(showDate: Date, isAllDayEvent: Bool) {
        self.dateLabel.text = showDate.toStringIncludedTime(!isAllDayEvent)
    }
}

