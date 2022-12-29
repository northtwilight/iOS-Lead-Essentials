//
//  RemoteFeedLoader.swift
//  MyEssentialFeed
//
//  Created by Massimo Savino on 2022-12-08.
//

import Foundation

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
        case noURLResponse
    }
    
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping (Result<[FeedItem], Error>) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                completion(FeedItemsMapper.map(data, from: response))
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
    
    private func map(_ data: Data, from response: HTTPURLResponse) -> Result<[FeedItem], RemoteFeedLoader.Error> {
        do {
            let items = try FeedItemsMapper.map(data, response)
            return .success(items)
        } catch {
            return .failure(.invalidData)
        }
    }
}
