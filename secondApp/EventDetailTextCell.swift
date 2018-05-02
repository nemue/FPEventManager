//
//  EventDetailTextCell.swift
//  secondApp
//
//  Created by Nele Müller on 24.04.18.
//  Copyright © 2018 Nele Müller. All rights reserved.
//

import UIKit

class EventDetailTextCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet private weak var textField: UITextField!
    
    
    // MARK: - Configuration
    
    func configure(textFieldDelegate: UITextFieldDelegate, text: String, tag: Int) {
        self.textField.delegate = textFieldDelegate
        self.textField.text = text
        self.textField.tag = tag
    }

}
