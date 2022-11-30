//
//  SinglePlayerViewController.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-11.
//

import UIKit

final class SinglePlayerViewController: UIViewController {
//    private struct Constants {
//        static let playerIdentifier = "SinglePlayer"
//    }
    
    var player: PlayerScoreViewController?
    
    // Without the configurator, you would need one of the following:
    
//    {
//        return children.compactMap { $0 as? PlayerScoreViewController }.first
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == Constants.playerIdentifier, let vc = segue.destination as? PlayerScoreViewController {
//            player = vc
//        }
//    }
}
