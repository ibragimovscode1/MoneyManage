//
//  DummyVC.swift
//  MoneyManage
//
//  Created by Rahmetullah on 2.07.2022.
//
import Foundation
import UIKit

class DummyVC: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    let logOutButton = UIButton(type: .system)
    weak var logOutDelegate: logoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension DummyVC {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.setTitle("Log Out", for: .normal)
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .primaryActionTriggered)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dummy"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logOutButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    //MARK: - Selectors
    
    @objc func logOutButtonTapped() {
        logOutDelegate?.didLogout()
    }
}

