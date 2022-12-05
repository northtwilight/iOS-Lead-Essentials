//
//  RemoteFeedLoaderTests.swift
//  MyEssentialFeedTests
//
//  Created by Massimo Savino on 2022-12-04.
//

import XCTest

class HTTPClient {
    static var shared = HTTPClient()
    var requestedURL: URL?
    
    private init() {}
    
    func get(from url: URL) {}
}


class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.get(from: URL(string: "https://a-url.com")!)
    }
}


final class RemoteFeedLoaderTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown()  {
        super.tearDown()
    }
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        sut.load()
        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {
        // Arrange
        //  Given a client and sut
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        
        // Act
        //  When we invoke sut.load,
        sut.load()
        
        // Assert
        // Then assert that a URL request was initiated in the client)
        
        XCTAssertNotNil(client.requestedURL) // <-- should fail as-is
    }
    
}
