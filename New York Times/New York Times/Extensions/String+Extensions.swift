//
//  String+Extensions.swift
//  New York Times
//
//  Created by Binnilal on 28/07/2021.
//

import Foundation

extension String {
    func monthAndDayFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MMM dd"
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
