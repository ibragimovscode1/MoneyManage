//
//  OnboardingVC.swift
//  MoneyManage
//
//  Created by Rahmetullah on 1.07.2022.
//

import UIKit


class OnboardingVC: UIViewController {
 
   
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    let heroImageName: String
    let titleText: String

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = appColor
        style()
        layout()
        
    }
    init (heroImageName: String, titleText: String) {
        self.heroImageName = heroImageName
        self.titleText = titleText
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}
extension OnboardingVC {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: heroImageName)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.text = titleText
        label.font = UIFont.preferredFont(forTextStyle: .title3)
    }
    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
      
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 8),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
        ])
      
        
    }
}
