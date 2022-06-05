//
//  String+Extentions.swift
//  Stocks
//
//  Created by Chris Boshoff on 2022/06/04.
//

import Foundation

extension String {
    
    func addBrackets() -> String {
        return "(\(self))"
    }
    
    func prefix(withText text: String)  -> String {
        return text + self
    }
    
    var addDollarSign: String {
        return "$ \(self)"
    }
  
}
