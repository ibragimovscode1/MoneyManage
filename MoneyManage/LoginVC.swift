//
//  LoginVC.swift
//  MoneyManage
//
//  Created by Rahmetullah on 29.06.2022.
//

import UIKit

protocol LoginVCDelegate: AnyObject {
    func didLogin()
}
protocol logoutDelegate: AnyObject{
    func didLogout()
}

class LoginVC: UIViewController {
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    weak var delegate: LoginVCDelegate?
   
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    //animation
    var leadingEdgeOnScreen:CGFloat = 16
    var leadingEdgeOffScreen:CGFloat = -1000
    var subTitleLeadingAnchor: NSLayoutConstraint?
    
    var titleLeadingAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = appColor
        style()
        layout()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }


}
extension LoginVC {
    private func style() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Money Manage"
        titleLabel.alpha = 0
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.text = "Your premium source for all things banking!"
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subTitleLabel.adjustsFontForContentSizeCategory = true
        subTitleLabel.text = "Your premium source for all\n things banking!"
        subTitleLabel.alpha = 0
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
      
        
    }
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            //Title Label
            subTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            //SubTitle label
            subTitleLabel.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: -24),
            subTitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
//            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subTitleLabel.widthAnchor.constraint(equalTo: loginView.widthAnchor),
            
            //Login View
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            //Button
            signInButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 24),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
            
            //Error Label
            errorMessageLabel.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor),
       ])
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        subTitleLeadingAnchor = subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        subTitleLeadingAnchor?.isActive = true
        
    }
    
}
//MARK: - Actions
extension LoginVC {
    @objc func signInTapped() {
        errorMessageLabel.isHidden = true
        login()
//        navigationController?.pushViewController(OnboardingContainerVC(), animated: true)
        
        
    }
    private func login() {
        guard let username  = username, let password = password else {
            assertionFailure("username / password should never be nil")
            return
        }
//        if username.isEmpty || password.isEmpty {
//            configureView(withMessage: "Username / password cannot be blank!")
//            return
//        }
        if username == "" && password == "" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
            
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}
extension LoginVC {
    private func animate() {
        let animator1 = UIViewPropertyAnimator(duration: 0.8, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
           
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
    
    
        let animator2 = UIViewPropertyAnimator(duration: 0.8, curve: .easeInOut) {
        self.subTitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
        self.view.layoutIfNeeded()
    }
        animator2.startAnimation(afterDelay: 0.2)
        
        let animator3 = UIViewPropertyAnimator(duration: 1.6, curve: .easeInOut) {
            self.titleLabel.alpha = 1
            self.subTitleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 0.2)
    
    
}
}
