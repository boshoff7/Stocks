//
//  TimeSeriesMonthlyAdjusted.swift
//  Stocks
//
//  Created by Chris Boshoff on 2022/06/03.
//

import Foundation

struct MonthInfo {
    let date: Date
    let adjustedOpen: Double
    let adjustedClose: Double
}

struct TimeSeriesMonthlyAdjusted: Decodable {
    
    let meta: Meta
    let timeSeries: [String: OHLC]
    enum CodingKeys: String, CodingKey {
        case meta = "Meta Data"
        case timeSeries = "Monthly Adjusted Time Series"
    }
    
    func getMonthInfo() -> [MonthInfo] {
        
        var monthInfos: [MonthInfo] = []
        let sortedTimeSeries = timeSeries.sorted(by: { $0.key > $1.key})
        print("sorted: \(sortedTimeSeries)")
        sortedTimeSeries.forEach { dateString, ohlc in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)!
            let adjustedOpen = getAdjustedOpen(ohlc: ohlc)
            let monthInfo = MonthInfo(date: date, adjustedOpen: adjustedOpen, adjustedClose: Double(ohlc.adjustedClose)!)
            monthInfos.append(monthInfo)
        }
        return monthInfos
    }
    
    private func getAdjustedOpen(ohlc: OHLC) -> Double {
        return Double(ohlc.open)! * (Double(ohlc.adjustedClose)! / Double(ohlc.close)!)
    }
}

struct Meta: Decodable {
    let symbol: String
    enum CodingKeys: String, CodingKey {
        case symbol = "2. Symbol"
    }
}

struct OHLC: Decodable {
    let open: String
    let close: String
    let adjustedClose: String
    
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case close = "4. close"
        case adjustedClose = "5. adjusted close"
    }
}





/// JSON format  results
//"Meta Data": {
//"1. Information": "Monthly Adjusted Prices and Volumes",
//"2. Symbol": "IBM",
//"3. Last Refreshed": "2022-06-02",
//"4. Time Zone": "US/Eastern"
//},
//"Monthly Adjusted Time Series": {
//"2022-06-02": {
//"1. open": "139.6700",
//"2. high": "140.4699",
//"3. low": "136.8500",
//"4. close": "140.1500",
//"5. adjusted close": "140.1500",
//"6. volume": "7531300",
//"7. dividend amount": "0.0000"
