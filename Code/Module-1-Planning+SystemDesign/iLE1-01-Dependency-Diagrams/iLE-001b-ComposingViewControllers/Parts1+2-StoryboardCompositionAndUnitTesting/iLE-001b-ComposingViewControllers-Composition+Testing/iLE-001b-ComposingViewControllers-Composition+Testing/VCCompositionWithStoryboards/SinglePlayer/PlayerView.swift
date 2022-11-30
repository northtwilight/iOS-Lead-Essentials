//
//  PlayerView.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-17.
//

import UIKit

class PlayerView: UIView {
    @IBOutlet private(set) weak var nameLabel: UILabel!
    @IBOutlet private(set) weak var scoreLabel: UILabel!
    
    var name: String? {
        set { nameLabel?.text = newValue }
        get { return nameLabel?.text }
    }
    
    var score: String? {
        set { scoreLabel?.text = newValue }
        get { return scoreLabel?.text }
    }


}
