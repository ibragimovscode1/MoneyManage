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
  
    let mainViewController = MainVC()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginVC.delegate = self
        onboardingVC.delegate = self
        displayLogin()
        return true
    }
    private func displayLogin() {
        setRootViewController(loginVC)
    }
    private func displayNextScreen() {
        if LocalState.hasOnboarded {
            prepMainView()
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingVC)
        }
    }
    private func prepMainView() {
        mainViewController.statusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
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
extension AppDelegate: LoginVCDelegate {
    func didLogin() {
       displayNextScreen()
    
    }
    
    
}
   
extension AppDelegate: OnboardingVCDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        prepMainView()
        setRootViewController(mainViewController)
   }
}

extension AppDelegate: logoutDelegate {
    func didLogout() {
        setRootViewController(loginVC)
    }
    
}

