//
//  MultiplayerViewController.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-11.
//

import UIKit

class MultiplayerViewController: UIViewController {
    private struct Constants {
        static let playerIdentifier = "Players"
    }
    
    private(set) var players: MultiplayerScoreViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.playerIdentifier, let vc = segue.destination as? MultiplayerScoreViewController {
            players = vc
        }
    }
}
