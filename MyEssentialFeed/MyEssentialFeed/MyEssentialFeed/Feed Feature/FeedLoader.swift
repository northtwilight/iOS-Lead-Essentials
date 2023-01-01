//
//  FeedLoader.swift
//  MyEssentialFeed
//
//  Created by Massimo Savino on 2022-12-04. 
//

import Foundation

typealias FeedItemWithErrorResult = Result<[FeedItem], Error>
typealias FeedItemWithErrorCompletionResult = Result<[FeedItem], Error>

public protocol FeedLoader {
    // func load(completion: @escaping (Result<[FeedItem], Error>) -> Void)
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
