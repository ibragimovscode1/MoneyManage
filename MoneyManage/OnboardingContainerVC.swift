//
//  OnboardingContainerVC.swift
//  MoneyManage
//
//  Created by Rahmetullah on 1.07.2022.
//


import UIKit
protocol OnboardingVCDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerVC: UIViewController {

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
//    var currentVC: UIViewController
  weak var delegate: OnboardingVCDelegate?
  
    var currentVC: UIViewController {
             didSet {
                 guard let index = pages.firstIndex(of: currentVC) else { return }
                 nextButton.isHidden = index == pages.count - 1 // hide if on last page
                 backButton.isHidden = index == 0
                 doneButton.isHidden = !(index == pages.count - 1) // show if on last page
             }
         }

         let nextButton = UIButton(type: .system)
         let backButton = UIButton(type: .system)
         let closeButton = UIButton(type: .system)
         let doneButton = UIButton(type: .system)

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingVC(heroImageName: "delorean", titleText: "Money Manage is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 80s.")
        let page2 = OnboardingVC(heroImageName: "world", titleText: "Move your money around the world quickly amd securely.")
        let page3 = OnboardingVC(heroImageName: "thumbs", titleText: "Learn more at www.moneymanege.com")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
       
    }
    private func setup() {
        view.backgroundColor = .systemCyan
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
        
    }
    
    private func style () {
        view.addSubview(nextButton)
        view.addSubview(backButton)
        view.addSubview(closeButton)
        view.addSubview(doneButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: [])
        backButton.addTarget(self, action: #selector(backTapped), for: .primaryActionTriggered)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)
    
    }
    private func layout () {
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
                      view.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 4),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
                       view.bottomAnchor.constraint(equalToSystemSpacingBelow: backButton.bottomAnchor, multiplier: 4),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 2),
                         view.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 4)
            
        ])
        
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerVC: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

//MARK: - Selectors
extension OnboardingContainerVC {
    @objc func closeTapped() {
        delegate?.didFinishOnboarding()
        
    }
   
    @objc func nextTapped(_ sender: UIButton) {
            guard let nextVC = getNextViewController(from: currentVC) else { return }
            pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
    @objc func backTapped(_ sender: UIButton) {
            guard let previousVC = getPreviousViewController(from: currentVC) else { return }
            pageViewController.setViewControllers([previousVC], direction: .reverse, animated: true, completion: nil)
        }
    @objc func doneTapped(_ sender: UIButton) {
             delegate?.didFinishOnboarding()
             // TODO
         }


}
