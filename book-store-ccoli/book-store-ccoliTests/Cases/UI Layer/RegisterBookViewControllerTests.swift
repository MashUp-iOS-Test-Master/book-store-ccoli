//
//  RegisterBookViewControllerTests.swift
//  book-store-ccoliTests
//
//  Created by 최혜린 on 2022/11/22.
//

import XCTest
@testable import book_store_ccoli

final class RegisterBookViewControllerTests: XCTestCase {

    var sut: RegisterBookViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RegisterBookViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // 하나라도 빈 칸으로 넘겨두면 등록이 안된다
    // 등록화면에서 빈칸없이 모두 입력하면 등록이 된다
    
}
