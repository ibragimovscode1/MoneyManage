//
//  ViewController.swift
//  MoneyManage
//
//  Created by Rahmetullah on 29.06.2022.
//

import UIKit

class LoginVC: UIViewController {
    let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        style()
        layout()
    }


}
extension LoginVC {
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout() {
        view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        
        ])
        
    }
    
}

