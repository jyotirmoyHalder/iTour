//
//  Expense.swift
//  iTour
//
//  Created by jyotirmoy_halder on 19/11/25.
//

import Foundation
import SwiftData

@Model
class Expense {
    var name: String
    var date: Date
    var value: Double
    
    init(name: String, date: Date, value: Double) {
        self.name = name
        self.date = date
        self.value = value
    }
}
