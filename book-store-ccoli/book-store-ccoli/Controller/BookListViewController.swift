//
//  BookListViewController.swift
//  book-store-ccoli
//
//  Created by 최혜린 on 2022/10/24.
//

import UIKit

import SnapKit

final class BookListViewController: UIViewController {
    
    let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.backgroundColor = UIColor.ccoliGray
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
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
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    var registeredBookList: [Book] = [] {
        didSet {
            updateTotalPrice()
        }
    }

    let totalPriceLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupView()
        loadRegisteredBookList()
    }

    private func configureView() {
        navigationItem.title = "book store"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        [bookListTableView, registerBookButton, totalPriceLabel, indicatorView].forEach {
            view.addSubview($0)
        }
        
        bookListTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        totalPriceLabel.snp.makeConstraints {
            $0.top.equalTo(bookListTableView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(registerBookButton.snp.top).offset(-20)
        }
        
        registerBookButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalToSuperview().multipliedBy(0.06)
        }
        
        indicatorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
    
    private func updateTotalPrice() {
        let totalPrice = registeredBookList.map { $0.price }.reduce(0, +)
        totalPriceLabel.text = "총 합계: \(totalPrice)원"
    }
    
    private func loadRegisteredBookList() {
        if let loadedBookListData = UserDefaults.standard.object(forKey: UserDefaults.bookListKey) as? Data {
            if let registeredBookList = try? JSONDecoder().decode([Book].self, from: loadedBookListData) {
                self.registeredBookList = registeredBookList
                updateBookList()
            }
        }
    }
    
    private func updateBookList() {
        indicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.bookListTableView.reloadData()
            self?.indicatorView.stopAnimating()
        }
    }
    
    @objc func registerBookButtonDidTap() {
        let registerBookViewController = RegisterBookViewController()
        registerBookViewController.delegate = self
        navigationController?.pushViewController(registerBookViewController, animated: true)
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCategory = Category(rawValue: registeredBookList[indexPath.row].category) ?? .novel
        
        switch currentCategory {
        case .novel:
            UIDevice.vibrate()
        case .tech:
            view.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.view.backgroundColor = .systemBackground
            }
        case .economy:
            break
        case .poet:
            let alertController = UIAlertController(
                title: nil,
                message: "으악! 🧟",
                preferredStyle: .alert
            )
            present(alertController, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.dismiss(animated: true)
            }
        }
    }
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
            
            if let encodedBookList = try? JSONEncoder().encode(registeredBookList) {
                UserDefaults.standard.set(encodedBookList, forKey: UserDefaults.bookListKey)
            }
        }
    }
}

extension BookListViewController: Loadable {
    func updateBookList(_ bookList: [Book]) {
        registeredBookList = bookList
        updateBookList()
    }
}
