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

    @IBOutlet private weak var eventTitleLabel: UILabel!
    @IBOutlet private weak var eventDateLabel: UILabel!
    @IBOutlet private weak var eventAllDaySwitch: UISwitch!

    func configureCell(eventInRow: Event) {
        var textForCell = eventInRow.title ?? ""
        
        if ((eventInRow.location) != nil){
            if (!eventInRow.location!.isEmpty) {
                textForCell += ", " + eventInRow.location!
            }
        }
        
        eventTitleLabel.text =  textForCell
        eventAllDaySwitch.isOn = eventInRow.allDay ?? false
        eventDateLabel.text = eventInRow.date.toStringIncludedTime(!eventAllDaySwitch.isOn)
    }
}

