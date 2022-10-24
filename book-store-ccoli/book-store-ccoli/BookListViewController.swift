//
//  BookListViewController.swift
//  book-store-ccoli
//
//  Created by 최혜린 on 2022/10/24.
//

import UIKit
import SnapKit

final class BookListViewController: UIViewController {
    
    let registerBookButton: UIButton = {
        let button = UIButton()
        button.setTitle("가격 합계", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .ccoliGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return button
    }()
    
    let bookListTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupView()
    }
    
    private func configureView() {
        navigationItem.title = "book store"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        [bookListTableView, registerBookButton].forEach {
            view.addSubview($0)
        }
        
        bookListTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(registerBookButton.snp.top).offset(-20)
        }
        
        registerBookButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalToSuperview().multipliedBy(0.06)
        }
        
        let registerBookGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(registerBookButtonDidTap))
        registerBookButton.addGestureRecognizer(registerBookGestureRecognizer)
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    @objc func registerBookButtonDidTap() {

    }
}
