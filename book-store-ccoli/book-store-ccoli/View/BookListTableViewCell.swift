//
//  BookListTableViewCell.swift
//  book-store-ccoli
//
//  Created by 최혜린 on 2022/10/25.
//

import UIKit

import SnapKit

class BookListTableViewCell: UITableViewCell {
    
    static let identifier = "BookListTableViewCell"
    
    let bookInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    let titleLabel = UILabel()
    let categoryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .ccoliGreen
        button.layer.cornerRadius = 8
        return button
    }()
    let dateLabel = UILabel()
    let priceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureView()
    }
    
    private func configureView() {
        addSubview(bookInfoStackView)
        
        [titleLabel, categoryButton, dateLabel, priceLabel].forEach {
            bookInfoStackView.addArrangedSubview($0)
        }
        
        bookInfoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func updateCell(_ book: Book) {
        titleLabel.text = book.title
        let category = Category(rawValue: book.category) ?? .novel
        categoryButton.setTitle("\(category)", for: .normal)
        dateLabel.text = book.publicationDate.dateToString()
        priceLabel.text = "\(book.price)원"
    }

}
