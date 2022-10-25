//
//  Book.swift
//  book-store-ccoli
//
//  Created by 최혜린 on 2022/10/25.
//

import Foundation

struct Book {
    var title: String = ""
    var category: Category = .novel
    var publicationDate: Date = Date()
    var price: Int = 0
}
