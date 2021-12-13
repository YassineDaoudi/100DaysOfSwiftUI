//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Yassine DAOUDI on 10/11/2021.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}
