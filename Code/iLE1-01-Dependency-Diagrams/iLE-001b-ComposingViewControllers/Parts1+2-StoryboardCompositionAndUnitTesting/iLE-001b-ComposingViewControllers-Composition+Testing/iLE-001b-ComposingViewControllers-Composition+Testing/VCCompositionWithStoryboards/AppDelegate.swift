//
//  AppDelegate.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let views = (window?.rootViewController as? UITabBarController)?.viewControllers,
           let single = views[0] as? SinglePlayerViewController,
           let multi = views[1] as? MultiplayerViewController,
           let timed = views[2] as? TimedMultiplayerViewController {
            
            _ = single.view
            _ = multi.view
            _ = timed.view
            
            single.playerOne?.playerView.nameLabel.text = "TestONE!!!"
            multi.players?.playerOne?.playerView.nameLabel.text = "Slayer!!"
            multi.players?.playerTwo?.playerView.nameLabel.text = "Cheery Cherry!"
            timed.players?.playerOne?.playerView.nameLabel.text = "Tree-hugger!"
            timed.players?.playerTwo?.playerView.nameLabel.text = "Duane"
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

