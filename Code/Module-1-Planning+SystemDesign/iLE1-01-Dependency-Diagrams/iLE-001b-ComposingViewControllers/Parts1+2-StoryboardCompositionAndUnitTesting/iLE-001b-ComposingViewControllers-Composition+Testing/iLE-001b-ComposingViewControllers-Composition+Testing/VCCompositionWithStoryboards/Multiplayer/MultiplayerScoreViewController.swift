//
//  MultiplayerScoreViewController.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-14.
//

import UIKit

final class MultiplayerScoreViewController: UIViewController {
    var playerOne: PlayerScoreViewController? {
        return children.compactMap { $0 as? PlayerScoreViewController }.first
    }
    
    var playerTwo: PlayerScoreViewController? {
        return children.compactMap { $0 as? PlayerScoreViewController }.last
    }
}
