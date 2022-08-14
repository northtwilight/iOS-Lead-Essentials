//
//  TimedMultiplayerViewController.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-13.
//

import UIKit

final class TimedMultiplayerViewController: UIViewController {
    @IBOutlet private weak var timeBar: TimeBarViewController?
    @IBOutlet private weak var playerOne: PlayerScoreViewController?
    @IBOutlet private weak var playerTwo: PlayerScoreViewController?
}
