//
//  SceneDelegate.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene),
              let window = window else { return }

        window.makeKeyAndVisible()
        guard let rootTabBarViewController = window.rootViewController as? UITabBarController else {
            print("Cannot set root view controller as tab bar controller")
            return
        }

        guard let views = rootTabBarViewController.viewControllers,
              let single = views[0] as? SinglePlayerViewController,
              let multi = views[1] as? MultiplayerViewController,
              let timed = views[2] as? TimedMultiplayerViewController
        else {
            print("can't set view controllers correctly")
            return
        }

        _ = single.view
        _ = multi.view
        _ = timed.view

        single.player?.playerView?.name = "Generic Test"
        
        multi.players?.playerOne?.playerView?.name = "Test 1"
        multi.players?.playerTwo?.playerView?.name = "Test 2"
        
        timed.players?.playerOne?.playerView?.name = "Test 3"
        timed.players?.playerTwo?.playerView?.name = "Test 4"
        
        timed.timeBar?.barView?.backgroundColor = UIColor.systemRed
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

