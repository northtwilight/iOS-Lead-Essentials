//
//  MultiplayerScoreViewController.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-14.
//

import UIKit

final class MultiplayerScoreViewController: UIViewController {
    private struct Constants {
        static let playerOne = "PlayerOne"
        static let playerTwo = "PlayerTwo"
    }
    
    var playerOne: PlayerScoreViewController? {
        return children.compactMap { $0 as? PlayerScoreViewController }.first
    }
    
    var playerTwo: PlayerScoreViewController? {
        return children.compactMap { $0 as? PlayerScoreViewController }.last
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == Constants.playerOne, let vc = segue.destination as? PlayerScoreViewController {
//            playerOne = vc
//        } else if segue.identifier == Constants.playerTwo , let vc = segue.destination as? PlayerScoreViewController {
//            playerTwo = vc
//        }
//    }
}
