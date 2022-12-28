//
//  HTTPClient.swift
//  MyEssentialFeed
//
//  Created by Massimo Savino on 2022-12-27.
//

import Foundation

public protocol HTTPClient {
    func get(
        from url: URL,
        completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)
}
