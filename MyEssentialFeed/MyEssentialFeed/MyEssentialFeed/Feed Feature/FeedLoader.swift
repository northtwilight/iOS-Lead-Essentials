//
//  FeedLoader.swift
//  MyEssentialFeed
//
//  Created by Massimo Savino on 2022-12-04.
//

import Foundation

protocol FeedLoader {
    func load(completion: @escaping (Result<[FeedItem], Error>) -> Void)
}

protocol HTTPClient {
    func get(from url: URL)
}

class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: url)
    }
}


