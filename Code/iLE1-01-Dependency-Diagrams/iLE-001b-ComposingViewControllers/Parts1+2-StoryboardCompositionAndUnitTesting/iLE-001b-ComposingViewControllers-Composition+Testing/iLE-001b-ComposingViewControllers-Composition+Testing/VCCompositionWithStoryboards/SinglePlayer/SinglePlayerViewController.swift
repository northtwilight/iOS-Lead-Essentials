//
//  SinglePlayerViewController.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-11.
//

import UIKit

final class SinglePlayerViewController: UIViewController {
    var player: PlayerScoreViewController? {
        return children.compactMap { $0 as? PlayerScoreViewController }.first
    }
}
