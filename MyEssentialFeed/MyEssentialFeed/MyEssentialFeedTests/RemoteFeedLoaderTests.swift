//
//  RemoteFeedLoaderTests.swift
//  MyEssentialFeedTests
//
//  Created by Massimo Savino on 2022-12-04.
//

import XCTest
import MyEssentialFeed

private class HTTPClientSpy: HTTPClient {
    var requestedURLs: [URL] {
        return messages.map( { $0.url })
    }
    
    private var messages = [(url: URL, completion: (Error) -> Void)]()
     
    func get(from url: URL, completion: @escaping (Error) -> Void) {
        messages.append((url, completion))
    }
    
    func complete(with error: Error, at index: Int = 0) {
        messages[index].completion(error)
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
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_load_requestsDataFromURL() {
        // Arrange: Given a client and sut
        let url = URL(string: "https://a-given-URL.com")!
        let (sut, client) = makeSUT(url: url)
        
        // Act: When we invoke sut.load,
        sut.load()
        
        // Assert: Then we assert that a URL request was initiated in the client)
        // (as the load method calls the protocol's required get method with a request)
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        // Arrange: Given a client and sut
        let url = URL(string: "https://a-given-URL.com")!
        let (sut, client) = makeSUT(url: url)
        
        // Act: When we invoke sut.load,
        sut.load()
        sut.load()
        
        // Assert: Then we assert that an array of URL requests was initiated in the client)
        XCTAssertEqual(client.requestedURLs, [url, url])
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
