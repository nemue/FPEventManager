//
//  EventDetailDatePickerCell.swift
//  secondApp
//
//  Created by Nele Müller on 30.04.18.
//  Copyright © 2018 Nele Müller. All rights reserved.
//

import UIKit

class EventDetailDatePickerCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    // MARK: - Properties
    
    private var dateChangedHandler: ((Date) -> Void)?
    
    // MARK: - Configuration
    
    func configure(onDateChangedHandler: @escaping ((Date) -> Void)) {
        self.dateChangedHandler = onDateChangedHandler
    }
    
    // MARK: - Actions
    
    @IBAction func dateChanged(_ datePicker: UIDatePicker) {
        self.dateChangedHandler?(datePicker.date)
    }
}
