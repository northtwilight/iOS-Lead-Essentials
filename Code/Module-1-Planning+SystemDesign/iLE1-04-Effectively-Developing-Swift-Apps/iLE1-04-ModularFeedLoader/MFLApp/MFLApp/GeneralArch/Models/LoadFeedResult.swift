//
//  LoadFeedResult.swift
//  MFLApp
//
//  Created by Massimo Savino on 2022-11-29.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}
