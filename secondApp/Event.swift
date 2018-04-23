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
    
    var title: String = ""
    var location: String?
    var date: Date
    var allDay: Bool?
    
    
    // MARK: - Static Methods
    
    static func dateToString(toBeConverted: Date, time: Bool) -> String {
        let dateFormatter = DateFormatter()
        
        if (time){
            dateFormatter.dateFormat = "dd. MMM yyy HH:mm"
        }
        else {
            dateFormatter.dateFormat = "dd. MMM yyy"
        }
        
        return dateFormatter.string(from: toBeConverted)
    }
    
    
    // MARK: - Initialization
    
    init?(title: String, location: String? = "", date: Date, allDay: Bool? = false){
        // besser convenience initializer für optional parameters statt default-wert?
        
        if title.isEmpty {
            return nil
        }
        
        self.title = title
        self.location = location
        self.date = date
        self.allDay = allDay
        
    }
}
