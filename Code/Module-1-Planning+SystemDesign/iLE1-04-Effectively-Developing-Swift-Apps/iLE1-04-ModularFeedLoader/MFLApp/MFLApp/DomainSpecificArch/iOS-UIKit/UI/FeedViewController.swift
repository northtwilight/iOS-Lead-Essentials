//
//  FeedViewController.swift
//  MFLApp
//
//  Created by Massimo Savino on 2022-11-29.
//

import UIKit

class FeedViewController: UIViewController {
    var loader: FeedLoader!
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.loadFeed { loadedItems in
            // update UI
        }
    }
}
