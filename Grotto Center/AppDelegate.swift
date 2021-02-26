//
//  AppDelegate.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 01/02/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var coordinator: AppCoordinator?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    coordinator = AppCoordinator(window: window!)
    coordinator?.start()
    
    return true
  }

}

