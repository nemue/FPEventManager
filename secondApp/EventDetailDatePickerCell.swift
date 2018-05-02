//
//  EventDetailDatePickerCell.swift
//  secondApp
//
//  Created by Nele Müller on 30.04.18.
//  Copyright © 2018 Nele Müller. All rights reserved.
//

import UIKit

class EventDetailDatePickerCell: UITableViewCell {
    
    private var dateChangedHandler: ((Date) -> Void)?

    @IBOutlet private weak var datePicker: UIDatePicker!
    
    func configure(onDateChangedHandler: @escaping ((Date) -> Void)) {
        self.dateChangedHandler = onDateChangedHandler
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        self.dateChangedHandler?(sender.date)
    }
}
