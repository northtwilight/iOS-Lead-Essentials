//
//  RemoteWithLocalFallback.swift
//  MFLApp
//
//  Created by Massimo Savino on 2022-11-29.
//

import Foundation

class RemoteWithLocalFallbackFeedLoader: FeedLoader {
    let remote: RemoteFeedLoader
    let local: LocalFeedLoader
    
    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.remote = remote
        self.local = local
    }
    
    func loadFeed(completion:  @escaping (LoadFeedResult) -> Void) {
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
