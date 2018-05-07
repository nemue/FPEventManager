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
    
    // MARK: - Properties
    
    var textFieldChangedHandler: ((String?) -> Void)?
    
    // MARK: - Configuration
    
    func configure(text: String?, tag: Int, forEventInfo eventInfo: EventInfo,
                   textFieldChangedHandler: @escaping ((String?) -> Void)) {
        
        self.textFieldChangedHandler = textFieldChangedHandler        
        self.textField.placeholder = eventInfo.placeHolderText()
        self.textField.text = text
        self.textField.tag = tag
    }
    
    // MARK: - Actions

    @IBAction func textFieldTextDidChange(_ textField: UITextField) {
        self.textFieldChangedHandler?(textField.text)
    }
}
