//
//  Event.swift
//  secondApp
//
//  Created by Nele Müller on 16.04.18.
//  Copyright © 2018 Nele Müller. All rights reserved.
//

import UIKit

class Event {
    
    // MARK: - Properties
    
    var title: String?
    var location: String?
    var date: Date
    var allDay: Bool?

    // MARK: - Initialization
    
    init(title: String? = "", location: String? = "", date: Date, allDay: Bool? = false) {
        
        self.title = title
        self.location = location
        self.date = date
        self.allDay = allDay
    }

}
