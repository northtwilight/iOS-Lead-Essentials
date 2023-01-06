//
//  FeedLoader.swift
//  MyEssentialFeed
//
//  Created by Massimo Savino on 2022-12-04. 
//

import Foundation

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
