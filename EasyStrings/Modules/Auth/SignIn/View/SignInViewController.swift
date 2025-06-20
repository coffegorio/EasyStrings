//
//  SignInViewController.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import UIKit

class SignInViewController: UIViewController {

    var viewModel: SignInViewModel?
    
    lazy private var titleLabel = DefaultLabel(text: "Добро пожаловать!")
    lazy private var subtitleLabel = DefaultLabel(text: "Введите ключ-доступа для в вашу учетную запись. Если у Вас нет аккаунта, вы можете")
    lazy private var generateKeyButton: UIButton = {
        let button = UIButton()
        button.setTitle("сгенерировать ключ.", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()

    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(generateKeyButton)
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(stackView)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
