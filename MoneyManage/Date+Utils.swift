//
//  Date+Utils.swift
//  MoneyManage
//
//  Created by Rahmetullah on 5.07.2022.
//


import Foundation

extension Date {
    static var moneyManageDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date.moneyManageDateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
