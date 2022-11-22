//
//  BookListViewControllerTests.swift
//  book-store-ccoliTests
//
//  Created by 최혜린 on 2022/11/22.
//

import XCTest
@testable import book_store_ccoli

final class BookListViewControllerTests: XCTestCase {
    
    var sut: BookListViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = BookListViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testController_whenNovelCellTapped_

    // 각 장르에 대한 액션 테스트
    // 비동기 테스트
    // 리스트가 없으면 엠티뷰를 보여준다
    // 리스트가 있으면 목록을 보여준다
    // 가격합계 잘 업데이트 되는지
    // 등록 이후 다시 리스트 화면으로 돌아가면 다시 목록을 불러온다 + 가격 잘 바뀌고 있는지 확인
    
//    소설를 누르면 - 핸드폰이 진동합니다.
//    기술를 누르면 - 뷰가 빨개졋다 돌아옵니다
//    경제를 누르면 - 아무일도 일어나지 않습니다.
//    시집를 누르면 - 알럿으로 "으악! 🧟" 이 표시됩니다.
}
