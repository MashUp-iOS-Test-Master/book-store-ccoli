//
//  Book.swift
//  book-store-ccoli
//
//  Created by 최혜린 on 2022/10/25.
//

import Foundation

struct Book: Codable {
    var title: String = ""
    var category: Int = 0
    var publicationDate: Date = Date()
    var price: Int = 0
}
