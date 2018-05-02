//
//  AlldaySwitchCell.swift
//  secondApp
//
//  Created by Nele Müller on 26.04.18.
//  Copyright © 2018 Nele Müller. All rights reserved.
//

import UIKit

class EventDetailAlldaySwitchCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet private weak var allDaySwitch: UISwitch!
    
    // MARK: - Properties
    
    private var onSwitchValueChangedHandler: ((Bool) -> Void)?

    // MARK: - Configuration
    
    func configure(switchIsOn: Bool, onSwitchValueChangedHandler: @escaping ((Bool) -> Void)) {
        self.allDaySwitch.isOn = switchIsOn
        self.onSwitchValueChangedHandler = onSwitchValueChangedHandler
    }

    // MARK: - Actions

    @IBAction func switchValueChanged(_ switcher: UISwitch) {
        self.onSwitchValueChangedHandler?(switcher.isOn)
    }
}
