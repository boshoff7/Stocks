//
//  APIService.swift
//  Stocks
//
//  Created by Chris Boshoff on 2022/06/03.
//

import Foundation
import Combine

/// Created more than 1 API key for testing
//    let API_KEY = "8XQCVRNUJK47I6M7"
//    let API_KEY2 = "JY4Y9P4ZMIMYKF7G"
//    let API_KEY3 = "HTZE6XANVONH2Y1W"

struct APIService {
    
    enum APIServiceError: Error {
        case encoding
        case badRequest
    }
    
    /// Randomise API Keys
    var API_KEY: String {
        /// Returns optional string, return default empty string
        return keys.randomElement() ?? ""
    }
    
    /// API Keys array, to randomise them during testing
    let keys = ["8XQCVRNUJK47I6M7","JY4Y9P4ZMIMYKF7G","HTZE6XANVONH2Y1W"]
    
    /// Create an API Call using Combine
    func fetchSymbolPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        
        guard let keywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return Fail(error: APIServiceError.encoding).eraseToAnyPublisher()
        }
        
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: APIServiceError.badRequest).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            /// Only interested in the Data
            .map({ $0.data })
            /// Decode the Data
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            /// Want o receive on the main thread
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
    func fetchTimeSeriesMonthlyAdjustedPublisher(keywords: String) -> AnyPublisher<TimeSeriesMonthlyAdjusted, Error> {
        
        guard let keywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return Fail(error: APIServiceError.encoding).eraseToAnyPublisher()
        }
        
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(keywords)&apikey=\(API_KEY)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: APIServiceError.badRequest).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            /// Only interested in the Data
            .map({ $0.data })
            /// Decode the Data
            .decode(type: TimeSeriesMonthlyAdjusted.self, decoder: JSONDecoder())
            /// Want o receive on the main thread
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
