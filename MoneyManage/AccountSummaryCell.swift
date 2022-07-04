//
//  AccountSummaryCell.swift
//  MoneyManage
//
//  Created by Rahmetullah on 4.07.2022.
//

import Foundation
import UIKit
class AccountSummaryCell: UITableViewCell {
    
    enum AccountType: String {
        case Banking
        case CreditCard
        case Investment
    }
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal
        
        var balanceAttributedString: NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    let viewModel: ViewModel? = nil
    
    let typeLabel  = UILabel()
    let underlineView = UIView()
    let nameLabel = UILabel()
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmount = UILabel()
    let chevronImage = UIImageView()
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryCell {
        private func setup() {
            typeLabel.translatesAutoresizingMaskIntoConstraints = false
            typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
            typeLabel.adjustsFontForContentSizeCategory = true
            typeLabel.text = "Account Type"
            contentView.addSubview(typeLabel)
            
            underlineView.translatesAutoresizingMaskIntoConstraints = false
            underlineView.backgroundColor = appColor
            contentView.addSubview(underlineView)
            
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.adjustsFontForContentSizeCategory = true
            nameLabel.text = "Account name"
            nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
            contentView.addSubview(nameLabel)
            
            balanceStackView.translatesAutoresizingMaskIntoConstraints = false
            balanceStackView.axis = .vertical
            balanceStackView.spacing = 0
            
            balanceLabel.translatesAutoresizingMaskIntoConstraints = false
            balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
            balanceLabel.textAlignment = .right
            balanceLabel.text = "Some balance"
            
            balanceAmount.translatesAutoresizingMaskIntoConstraints = false
            balanceAmount.textAlignment = .right
            balanceAmount.attributedText = makeFormattedBalance(dollars: "xxx,xxx", cents: "xxx")
            contentView.addSubview(balanceStackView)
            balanceStackView.addArrangedSubview(balanceLabel)
            balanceStackView.addArrangedSubview(balanceAmount)
            
            chevronImage.translatesAutoresizingMaskIntoConstraints = false
            let chevronImageView = UIImage(systemName: "chevron.right")!.withTintColor(appColor,renderingMode: .alwaysOriginal)
            chevronImage.image = chevronImageView
            contentView.addSubview(chevronImage)
            
        }
        private func layout() {
            NSLayoutConstraint.activate([
                typeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                
                
                underlineView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8),
                underlineView.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
                underlineView.heightAnchor.constraint(equalToConstant: 4),
                underlineView.widthAnchor.constraint(equalToConstant: 60),
                
                nameLabel.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 16),
                nameLabel.leadingAnchor.constraint(equalTo: underlineView.leadingAnchor),
                
                balanceStackView.topAnchor.constraint(equalTo: underlineView.bottomAnchor),
                balanceStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
                balanceStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
                
                chevronImage.topAnchor.constraint(equalTo: underlineView.bottomAnchor,constant: 8),
                chevronImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                
                
                
            ])
        }
  
        private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
            let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
            let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
            let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
            
            let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
            let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
            let centString = NSAttributedString(string: cents, attributes: centAttributes)
            
            rootString.append(dollarString)
            rootString.append(centString)
            
            return rootString
        }
    
}
extension AccountSummaryCell {
    func configure(with vm: ViewModel) {
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmount.attributedText = vm.balanceAttributedString
        switch vm.accountType {
            
        case .Banking:
            underlineView.backgroundColor = appColor
            balanceLabel.text = "Currrent Balance"
            
        case .CreditCard:
            underlineView.backgroundColor = .orange
            balanceLabel.text = "Current Balance"
        case .Investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }
}

