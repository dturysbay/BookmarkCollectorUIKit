//
//  AppDelegate.swift
//  BookmarkUI
//
//  Created by Dinmukhambet Turysbay on 05.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    
//    UserDefaults.standard.set(true, forKey: "isOnboardingSeen")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
       
        
//        if((UserSettings.userDefaults.integer(forKey: StorageStates.isOnboardingSeen.rawValue) != nil) == 1){
//            window?.rootViewController = WelcomeView()
//        }else{
//            window?.rootViewController = SaveYourFirstBookmark()
//        }
//        window?.rootViewController = WelcomeView()
        
        return true
    }

}

