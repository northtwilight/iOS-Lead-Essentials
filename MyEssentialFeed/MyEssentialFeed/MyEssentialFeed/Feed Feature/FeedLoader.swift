//
//  FeedLoader.swift
//  MyEssentialFeed
//
//  Created by Massimo Savino on 2022-12-04. 
//

import Foundation

protocol FeedLoader {
    associatedtype Error: Swift.Error
    
    func load(completion: @escaping (Result<[FeedItem], Error>) -> Void)
}
