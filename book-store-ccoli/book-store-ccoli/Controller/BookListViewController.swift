//
//  BookListViewController.swift
//  book-store-ccoli
//
//  Created by 최혜린 on 2022/10/24.
//

import UIKit
import SnapKit
// TODO: tableView Cell 디자인
// TODO: 가격 합계 label 따로 만들기
final class BookListViewController: UIViewController {
    
    let registerBookButton: UIButton = {
        let button = UIButton()
        button.setTitle("register", for: .normal)
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
    
    var registeredBookList: [Book] = []
//    {
//        didSet {
//            debugPrint(registeredBookList)
//            bookListTableView.reloadData()
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupView()
        loadRegisteredBookList()
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
        
        bookListTableView.delegate = self
        bookListTableView.dataSource = self
        
        bookListTableView.register(BookListTableViewCell.self, forCellReuseIdentifier: BookListTableViewCell.identifier)
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func loadRegisteredBookList() {
        if let loadedBookListData = UserDefaults.standard.object(forKey: UserDefaults.bookListKey) as? Data {
            if let registeredBookList = try? JSONDecoder().decode([Book].self, from: loadedBookListData) {
                self.registeredBookList = registeredBookList
            }
        }
    }
    
    @objc func registerBookButtonDidTap() {
        navigationController?.pushViewController(RegisterBookViewController(), animated: true)
    }
}

extension BookListViewController: UITableViewDelegate {
    
}

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registeredBookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookListTableViewCell.identifier, for: indexPath) as? BookListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.updateCell(registeredBookList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            registeredBookList.remove(at: indexPath.row)
            bookListTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
