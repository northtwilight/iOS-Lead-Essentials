//
//  LoadFeedResult.swift
//  EssentialFeed
//
//  Created by Massimo Savino on 2022-11-30.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}
