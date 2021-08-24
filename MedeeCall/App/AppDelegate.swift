//
//  AppDelegate.swift
//  MedeeCall
//
//  Created by Nothing2saY on 2021/02/02.
//

import UIKit
import HealthKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        return true
    }
    
    // Ask for authorizing health data
    func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        
        let healthStore = HKHealthStore()
        healthStore.handleAuthorizationForExtension { (success, error) in
            
            // Something to do after authorization
            if success {
                print("Health Authorized")
            } else {
                print("Health not authorized")
            }
        }
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
     
    }


}
