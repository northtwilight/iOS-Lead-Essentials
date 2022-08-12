//
//  MultiplayerViewController.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-11.
//

import UIKit

class MultiplayerViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var name: String? {
        set { nameLabel?.text = newValue }
        get { return nameLabel?.text }
    }
    
    var score: String? {
        set { scoreLabel?.text = newValue }
        get { return scoreLabel?.text }
    }

}
