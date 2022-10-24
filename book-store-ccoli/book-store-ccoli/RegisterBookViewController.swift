//
//  RegisterBookViewController.swift
//  book-store-ccoli
//
//  Created by 최혜린 on 2022/10/24.
//

import UIKit

final class RegisterBookViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter book title"
        return textField
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "category"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let categorySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["novel", "tech", "economy", "poet"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .ccoliGreen
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        segmentedControl.backgroundColor = .ccoliGray
        return segmentedControl
    }()
    
    let publicationDateLabel: UILabel = {
        let label = UILabel()
        label.text = "publication date"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let publicationDateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter publication date"
        return textField
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "price"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter price"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let registerBookButton: UIButton = {
        let button = UIButton()
        button.setTitle("register", for: .normal)
        button.backgroundColor = .ccoliGreen
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    private func configureView() {
        navigationItem.title = "register book"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .ccoliGreen

        [titleLabel, titleTextField, categoryLabel, categorySegmentedControl, publicationDateLabel, publicationDateTextField, priceLabel, priceTextField, registerBookButton].forEach {
            view.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(20)
        }
        
        categorySegmentedControl.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        publicationDateLabel.snp.makeConstraints {
            $0.top.equalTo(categorySegmentedControl.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(20)
        }
        
        publicationDateTextField.snp.makeConstraints {
            $0.top.equalTo(publicationDateLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(publicationDateTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(20)
        }
        
        priceTextField.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        registerBookButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalToSuperview().multipliedBy(0.06)
        }
        
        categorySegmentedControl.addTarget(self, action: #selector(categorySegmentedControlDidChange(_:)), for: .valueChanged)
        
        let backgroundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTap))
        view.addGestureRecognizer(backgroundTapGestureRecognizer)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
    }
    
    @objc func categorySegmentedControlDidChange(_ sender: UISegmentedControl) {
        
    }
    
    @objc func backgroundDidTap() {
        view.endEditing(true)
    }
}