//
//  SinglePlayerViewControllerStoryboardConfigurator.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-18.
//

import UIKit

final class SinglePlayerViewControllerStoryboardConfigurator: NSObject {
    // Property injection
    var observation: NSKeyValueObservation?
    
    @IBOutlet private weak var player: UIViewController? {
        didSet {
            // strong reference
            observation = player?.observe(\.parent) { player, changes in
                if let singlePlayerController = player.parent as? SinglePlayerViewController {
                    singlePlayerController.player = player as? PlayerScoreViewController
                }
            }
        }
    }
}
