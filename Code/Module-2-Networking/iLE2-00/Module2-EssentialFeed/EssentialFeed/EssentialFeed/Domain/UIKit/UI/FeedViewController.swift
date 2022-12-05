//
//  FeedViewController.swift
//  EssentialFeed
//
//  Created by Massimo Savino on 2022-11-30.
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
            // update the UI
        }
    }
}
