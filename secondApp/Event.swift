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
    var date: String // TODO
    
    
    // MARK: - Initialization
    
    init?(title: String, location: String?, date: String){
        
        if title.isEmpty || date.isEmpty {
            return nil
        }
        
        self.title = title
        self.location = location
        self.date = date
    }
}
