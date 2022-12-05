//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Massimo Savino on 2022-11-30.
//

import Foundation

protocol FeedLoader {
    func loadFeed(completion: @escaping (LoadFeedResult) -> Void)
}
