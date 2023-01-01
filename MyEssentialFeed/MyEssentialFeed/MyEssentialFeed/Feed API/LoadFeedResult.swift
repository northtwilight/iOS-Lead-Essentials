//
//  LoadFeedResult.swift
//  MyEssentialFeed
//
//  Created by Massimo Savino on 2022-12-30.
//

import Foundation

public enum LoadFeedResult: Equatable {
    case success([FeedItem])
    case failure(RemoteFeedLoader.Error)
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: LoadFeedResult, rhs: LoadFeedResult) -> Bool {
        switch (lhs, rhs) {
        case (let .success(lhsFeedItems), let .success(rhsFeedItems)):
            return lhsFeedItems == rhsFeedItems
        case (let .failure(lhsError), let .failure(rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}
