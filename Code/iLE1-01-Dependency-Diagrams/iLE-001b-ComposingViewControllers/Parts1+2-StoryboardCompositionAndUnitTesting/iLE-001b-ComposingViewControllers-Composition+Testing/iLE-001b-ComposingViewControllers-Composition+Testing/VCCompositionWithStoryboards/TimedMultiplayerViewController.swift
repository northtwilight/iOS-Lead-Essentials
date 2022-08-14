//
//  TimedMultiplayerViewController.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-13.
//

import UIKit

final class TimedMultiplayerViewController: UIViewController {
    @IBOutlet private weak var timeBar: TimeBarViewController?
    
    weak var playerOne: PlayerScoreViewController? {
        return children.compactMap { $0 as? PlayerScoreViewController }.first
    }
    
    weak var playerTwo: PlayerScoreViewController? {
        return children.compactMap { $0 as? PlayerScoreViewController }.last
    }
}
