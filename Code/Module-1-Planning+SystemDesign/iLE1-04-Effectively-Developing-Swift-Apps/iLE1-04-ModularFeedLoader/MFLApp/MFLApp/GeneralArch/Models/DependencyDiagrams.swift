//
//  DependencyDiagrams.swift
//  iLE-001-Intro-Dependency-Diagrams
//
//  Created by Massimo Savino on 2022-08-04.
//


/**

import Foundation
import UIKit

protocol FeedLoader  {
    func loadFeed(completion: @escaping ([String]) -> Void)
}

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

class RemoteFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        // do something
    }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        // do something different
    }
}

struct Reachability {
    static let networkAvailable = false
}

class RemoteWithLocalFallbackFeedLoader: FeedLoader {
    let remote: RemoteFeedLoader
    let local: LocalFeedLoader
    
    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.remote = remote
        self.local = local
    }
    
    func loadFeed(completion:  @escaping ([String]) -> Void) {
        let load = Reachability.networkAvailable ? remote.loadFeed : local.loadFeed
        load(completion)
        
        // or
        
        /**
        if Reachability.networkAvailable {
            remote.loadFeed { loadedItems in
                // do something
            }
        }
        else {
            local.loadFeed { loadedItems in
                // do something
            }
        }
        */
        
    }
}
    
struct Faked {
    func asIfPlayground() {
        // ie
        
        let vc = FeedViewController(loader: RemoteFeedLoader())
        let vc2 = FeedViewController(loader: LocalFeedLoader())

        let alternatingLoader = RemoteWithLocalFallbackFeedLoader(
            remote: RemoteFeedLoader(),
            local: LocalFeedLoader())

        let vc3 = FeedViewController()
        vc3.loader = RemoteWithLocalFallbackFeedLoader(
            remote: RemoteFeedLoader(),
            local: LocalFeedLoader())

        // vc3.loader = alternatingLoader
    }
}

 */



