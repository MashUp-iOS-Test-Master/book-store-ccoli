//
//  Date+Extension.swift
//  book-store-ccoli
//
//  Created by 최혜린 on 2022/10/25.
//

import Foundation

extension Date {
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        return dateFormatter.string(from: self)
    }
}
