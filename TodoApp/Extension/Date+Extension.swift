//
//  Date+Extension.swift
//  TodoApp
//
//  Created by EKbana on 21/09/2022.
//

import Foundation

extension Date {
    
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
       return formatter.string(from: self)
    }
}
