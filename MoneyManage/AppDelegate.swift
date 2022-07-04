//
//  AppDelegate.swift
//  MoneyManage
//
//  Created by Rahmetullah on 29.06.2022.
//

import UIKit
let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    


    var window: UIWindow?
    let loginVC = LoginVC()
    let onboardingVC = OnboardingContainerVC()
    let dummyViewController = DummyVC()
    let mainViewController = MainVC()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginVC.delegate = self
        onboardingVC.delegate = self
        dummyViewController.logOutDelegate = self
//        window?.rootViewController = mainViewController
        window?.rootViewController = AccountSummaryVC()
        return true
    }
}
extension AppDelegate: LoginVCDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(dummyViewController)
        } else {
            setRootViewController(onboardingVC)
        }
    
    }
    
    
}
   
extension AppDelegate: OnboardingVCDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(dummyViewController)
   }
}

extension AppDelegate: logoutDelegate {
    func didLogout() {
        setRootViewController(loginVC)
    }
    
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.7,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    
}
