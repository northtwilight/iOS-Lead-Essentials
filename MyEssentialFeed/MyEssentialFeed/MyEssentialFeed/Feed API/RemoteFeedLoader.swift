//
//  RemoteFeedLoader.swift
//  MyEssentialFeed
//
//  Created by Massimo Savino on 2022-12-08.
//

import Foundation

public enum HTTPClientResult {
    case success(HTTPURLResponse)
    case failure(Error)
}
// Substitute this eventually
// Result<HTTPURLResponse, Error>

public protocol HTTPClient {
    func get(
        from url: URL,
        completion: @escaping (HTTPClientResult) -> Void)
}

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
    
    public func load(completion: @escaping (Error) -> Void) {
        client.get(from: url) { result in
            switch result {
            case .failure:
                completion(.connectivity)
            case .success:
                completion(.invalidData)
            }
        }
    }
}
