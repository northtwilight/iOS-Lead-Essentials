//
//  RemoteFeedLoaderTests.swift
//  MyEssentialFeedTests
//
//  Created by Massimo Savino on 2022-12-04.
//

import XCTest
@testable import MyEssentialFeed

// Moved test logic to a separate test type, the HTTP client spy
private class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}

final class RemoteFeedLoaderTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown()  {
        super.tearDown()
    }
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    func test_init_doesNotRequestDataFromURL() {
        let url = URL(string: "https://a.url.com")!
        let client = HTTPClientSpy()
        makeSUT(url: url)
        
        // We assert that we didn't make a URL request, since that should only happen when `.load()` is invoked.
        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {
        // Arrange: Given a client and sut
        let url = URL(string: "https://a-given-URL.com")!
        let (sut, client) = makeSUT(url: url)
        
        
        // Act: When we invoke sut.load,
        sut.load()
        
        // Assert
        // Then we assert that a URL request was initiated in the client)
        XCTAssertNotNil(client.requestedURL)
    }
    
}
