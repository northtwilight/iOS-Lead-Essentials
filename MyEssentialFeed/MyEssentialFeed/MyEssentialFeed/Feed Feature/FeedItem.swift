//
//  FeedItem.swift
//  MyEssentialFeed
//
//  Created by Massimo Savino on 2022-12-04.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
