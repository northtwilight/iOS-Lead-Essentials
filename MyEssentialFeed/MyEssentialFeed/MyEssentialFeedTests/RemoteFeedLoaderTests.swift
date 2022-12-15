//
//  RemoteFeedLoaderTests.swift
//  MyEssentialFeedTests
//
//  Created by Massimo Savino on 2022-12-04.
//

import XCTest
import MyEssentialFeed

private class HTTPClientSpy: HTTPClient {
    var capturedURLs = [URL]()
    var completions = [(Error) -> Void]()
     
    func get(from url: URL, completion: @escaping (Error) -> Void) {
        completions.append(completion)
        capturedURLs.append(url)
    }
    
    func complete(with error: Error, at index: Int = 0) {
        completions[index](error)
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
        let (_, client) = makeSUT(url: url)
        
        XCTAssertTrue(client.capturedURLs.isEmpty)
    }

    func test_load_requestsDataFromURL() {
        // Arrange: Given a client and sut
        let url = URL(string: "https://a-given-URL.com")!
        let (sut, client) = makeSUT(url: url)
        
        // Act: When we invoke sut.load,
        sut.load()
        
        // Assert: Then we assert that a URL request was initiated in the client)
        // (as the load method calls the protocol's required get method with a request)
        XCTAssertEqual(client.capturedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        // Arrange: Given a client and sut
        let url = URL(string: "https://a-given-URL.com")!
        let (sut, client) = makeSUT(url: url)
        
        // Act: When we invoke sut.load,
        sut.load()
        sut.load()
        
        // Assert: Then we assert that a URL request was initiated in the client)
        // (as the load method calls the protocol's required get method with a request)
        
        // What if we capture the called URLs into an array? This way, we can assert order, and equality,
        // in addition to the count. We do this by adding an empty array of capture URLs as a property
        XCTAssertEqual(client.capturedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load { capturedErrors.append($0)  }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError, at: 0)
        
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
}
