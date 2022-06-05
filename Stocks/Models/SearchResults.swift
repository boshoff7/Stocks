//
//  SearchResults.swift
//  Stocks
//
//  Created by Chris Boshoff on 2022/06/03.
//

import Foundation

struct SearchResults: Decodable {
    
    let items: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case items = "bestMatches"
    }
}

struct SearchResult: Decodable {
    let symbol: String
    let name: String
    let type: String
    let currency: String
    
    /// Reformat names to match JSON results
    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case currency = "8. currency"
    }
}


/// The JSON format result
//"1. symbol": "BA",
//"2. name": "Boeing Company",
//"3. type": "Equity",
//"4. region": "United States",
//"5. marketOpen": "09:30",
//"6. marketClose": "16:00",
//"7. timezone": "UTC-04",
//"8. currency": "USD",
//"9. matchScore": "1.0000"
