//
//  Faked.swift
//  MFLApp
//
//  Created by Massimo Savino on 2022-11-29.
//

import Foundation

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
