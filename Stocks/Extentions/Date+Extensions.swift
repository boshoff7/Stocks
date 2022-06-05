//
//  Date+Extensions.swift
//  Stocks
//
//  Created by Chris Boshoff on 2022/06/04.
//

import Foundation

extension Date {
    
    var MMYYFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
