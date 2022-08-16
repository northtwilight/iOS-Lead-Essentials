//
//  TimedMultiplayerViewController.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-13.
//

import UIKit

final class TimedMultiplayerViewController: UIViewController {
    private struct Constants {
        static let timeBarIdentifier = "TimeBar"
        static let playersIdentifier = "Players"
    }

    private(set) var timeBar: TimeBarViewController?
    private(set) var players: MultiplayerScoreViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.timeBarIdentifier, let vc = segue.destination as? TimeBarViewController {
            timeBar = vc
        } else if segue.identifier == Constants.playersIdentifier, let vc = segue.destination as? MultiplayerScoreViewController {
            players = vc
        }
    }
}
