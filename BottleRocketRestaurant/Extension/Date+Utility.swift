//
//  Date+Utility.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

extension Date {
    
    static private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    
    static func dateToString(_ date: Date) -> String? {
        return dateFormatter.string(from: date)
    }
    
    
    static func shortTime(from dateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        let date = isoFormatter.date(from: dateString)!
        
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
}
