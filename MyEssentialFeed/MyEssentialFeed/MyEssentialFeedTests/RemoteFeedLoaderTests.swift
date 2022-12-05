//
//  RemoteFeedLoaderTests.swift
//  MyEssentialFeedTests
//
//  Created by Massimo Savino on 2022-12-04.
//

import XCTest

protocol HTTPClient {
    func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
    func get(from url: URL) {
        requestedURL = url
    }
    
    var requestedURL: URL?
}


class RemoteFeedLoader {
    let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        let originalUrlString = "https://a-url.com"
        let urlString = "https://slashdot.org"
        
        client.get(from: URL(string: originalUrlString)!)
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
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(client: client)
        
        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {
        // Arrange
        //  Given a client and sut
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(client: client)
        
        // Act
        //  When we invoke sut.load,
        sut.load()
        
        // Assert
        // Then assert that a URL request was initiated in the client)
        
        XCTAssertNotNil(client.requestedURL)
    }
    
}
