//
//  DecimalUtils.swift
//  MoneyManage
//
//  Created by Rahmetullah on 4.07.2022.
//

import Foundation
extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
