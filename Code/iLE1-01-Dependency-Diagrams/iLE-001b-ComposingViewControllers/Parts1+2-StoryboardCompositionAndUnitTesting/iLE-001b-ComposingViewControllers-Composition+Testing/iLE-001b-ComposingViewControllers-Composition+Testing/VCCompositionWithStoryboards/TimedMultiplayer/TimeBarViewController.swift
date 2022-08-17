//
//  TimeBarViewController.swift
//  iLE-001b-ComposingViewControllers-Composition+Testing
//
//  Created by Massimo Savino on 2022-08-13.
//

import UIKit

final class TimeBarViewController: UIViewController {
    @IBOutlet weak var barView: UIView?
    
    var progress: Float = 1 {
        didSet { /** update bar frame */ }
    }
}
