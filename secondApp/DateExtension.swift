//
//  DateExtension.swift
//  secondApp
//
//  Created by Nele Müller on 23.04.18.
//  Copyright © 2018 Nele Müller. All rights reserved.
//

import Foundation

extension Date {
    
    func toStringIncludedTime(_ time: Bool) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = (time) ? "dd.MM.yyyy HH:mm" : "dd.MM.yyyy"

        return dateFormatter.string(from: self)
    }
}
