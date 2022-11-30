//
//  FeedLoader.swift
//  MFLApp
//
//  Created by Massimo Savino on 2022-11-29.
//

import Foundation

protocol FeedLoader  {
    func loadFeed(completion: @escaping (LoadFeedResult) -> Void)
}
