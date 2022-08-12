//
//  SinglePlayerViewController.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-11.
//

import UIKit

final class SinglePlayerViewController: UIViewController {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
