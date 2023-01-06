//
//  RemoteFeedLoader.swift
//  MyEssentialFeed
//
//  Created by Massimo Savino on 2022-12-08.
//

import Foundation

public enum RemoteError: Error {
    case connectivity
    case invalidData
    case noURLResponse
}

public final class RemoteFeedLoader: FeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping (LoadFeedResult) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                completion(FeedItemsMapper.map(data, from: response))
            case .failure:
                completion(.failure(RemoteError.connectivity))
            }
        }
    }
    private func map(_ data: Data, from response: HTTPURLResponse) -> LoadFeedResult {
        do {
            let items = try FeedItemsMapper.map(data, response)
            return .success(items)
        } catch {
            return .failure(RemoteError.invalidData)
        }
    }
}
