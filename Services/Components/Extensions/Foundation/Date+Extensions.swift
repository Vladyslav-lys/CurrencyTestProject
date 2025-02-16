//
//  Date+Extensions.swift
//  Services
//
//  Created by Vladyslav Lysenko on 16.02.2025.
//

import Foundation

extension Date {
    var startOfDay: Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .utc
        return calendar.startOfDay(for: self)
    }
}
