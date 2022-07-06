//
//  AccountSummaryVC.swift
//  MoneyManage
//
//  Created by Rahmetullah on 3.07.2022.
//


import UIKit



class AccountSummaryVC: UIViewController {
    //RequestModels
    var profile: Profile?
    var accounts: [Account] = []
    
    //ViewModel
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
        //Components
    
    var accountCellViewModels: [AccountSummaryCell.ViewModel] = []
    var tableView = UITableView()
    var  headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshControl = UIRefreshControl()
    
    lazy var logoutBarButonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNaviagtionBar()
    }
    
}

extension AccountSummaryVC {
    private func setup() {
        setupNaviagtionBar()
        setupTableView()
        setupTableHeaderView()
        setupRefreshControl()
        fetchData()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    func setupNaviagtionBar() {
        navigationItem.rightBarButtonItem = logoutBarButonItem
    }
    private func setupRefreshControl() {
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupTableHeaderView() {
        let headerView = AccountSummaryHeaderView(frame: .zero)
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        tableView.tableHeaderView = headerView
    }
}

extension AccountSummaryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountCellViewModels.isEmpty else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID,for: indexPath) as! AccountSummaryCell
        let account = accountCellViewModels[indexPath.row]
        cell.configure(with: account)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count
    }
}

extension AccountSummaryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
//extension AccountSummaryVC {
//    private func fetchAccounts() {
//        let savings = AccountSummaryCell.ViewModel(accountType: .Banking,
//                                                            accountName: "Basic Savings",
//                                                        balance: 929466.23)
//        let chequing = AccountSummaryCell.ViewModel(accountType: .Banking,
//                                                    accountName: "No-Fee All-In Chequing",
//                                                    balance: 17562.44)
//        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard,
//                                                       accountName: "Visa Avion Card",
//                                                       balance: 412.83)
//        let masterCard = AccountSummaryCell.ViewModel(accountType: .CreditCard,
//                                                       accountName: "Student Mastercard",
//                                                       balance: 50.83)
//        let investment1 = AccountSummaryCell.ViewModel(accountType: .Investment,
//                                                       accountName: "Tax-Free Saver",
//                                                       balance: 2000.00)
//        let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment,
//                                                       accountName: "Growth Fund",
//                                                       balance: 15000.00)
//
//        accountCellViewModels.append(savings)
//        accountCellViewModels.append(chequing)
//        accountCellViewModels.append(visa)
//        accountCellViewModels.append(masterCard)
//        accountCellViewModels.append(investment1)
//        accountCellViewModels.append(investment2)
//    }
//}

// MARK: - Networking
extension AccountSummaryVC {
 
    
    private func fetchData() {
        let group = DispatchGroup()
        group.enter()
        let userId = String(Int.random(in: 1..<4))
        
        
        fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                self.configureTableCells(with: accounts)
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configure(viewModel: vm)
    }
    private func configureTableCells(with accounts:[Account] ) {
        accountCellViewModels = accounts.map {
            AccountSummaryCell.ViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        }
    }
    
    
}
//MARK: - Selectors
extension AccountSummaryVC {
    @objc func logoutTapped() {
        NotificationCenter.default.post(name: .Logout, object: nil)
    }
    
    @objc func refreshContent() {
        fetchData()
    }
}
