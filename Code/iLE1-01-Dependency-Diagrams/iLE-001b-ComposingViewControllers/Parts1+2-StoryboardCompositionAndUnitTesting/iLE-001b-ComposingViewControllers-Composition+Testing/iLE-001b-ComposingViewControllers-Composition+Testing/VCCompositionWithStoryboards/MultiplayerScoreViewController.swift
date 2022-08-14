//
//  MultiplayerScoreViewController.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-14.
//

import UIKit

final class MultiplayerScoreViewController: UIViewController {
    private struct Constants {
        static let playerOneIdentifier = "PlayerOne"
        static let playerTwoIdentifier = "PlayerTwo"
    }
    
    private(set) var playerOne: PlayerScoreViewController?
    private(set) var playerTwo: PlayerScoreViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.playerOneIdentifier, let vc = segue.destination as? PlayerScoreViewController {
            playerOne = vc
        }
        else if segue.identifier == Constants.playerTwoIdentifier, let vc = segue.destination as? PlayerScoreViewController {
            playerTwo = vc
        }
    }
}
