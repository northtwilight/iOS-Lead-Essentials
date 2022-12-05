//
//  RemoteFeedLoaderTests.swift
//  MyEssentialFeedTests
//
//  Created by Massimo Savino on 2022-12-04.
//

import XCTest

class HTTPClient {
    // Refactoring Step 1:
    //  Make the shared instance a variable and not a let statement
    static var shared = HTTPClient()
    
    // Refactoring Step 2:
    //  Move the test logic from the RemoteFeedLoader to HTTPClient VVVVVVVVV
    func get(from url: URL) {}
}

class HTTPClientSpy: HTTPClient {
    // Refactoring Step 3:
    //  Move the test logic to a new subclass of the HTTPClient
    override func get(from url: URL) {
        requestedURL = url
    }
    
    var requestedURL: URL?
}


class RemoteFeedLoader {
    func load() {
        // Refactoring Step 2:
        //  Move the test logic from the RemoteFeedLoader to HTTPClient ^^^^^^
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
        // Now we no longer have a singleton and the test logic is now in a testable type, the client spy.
        
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        
        let sut = RemoteFeedLoader()
        sut.load()
        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {
        // Refactoring step 4:
        //  Swap the HTTPClient shared instance with the spy subclass during tests.
        
        
        // Arrange
        //  Given a client and sut
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        
        let sut = RemoteFeedLoader()
        
        // Act
        //  When we invoke sut.load,
        sut.load()
        
        // Assert
        // Then assert that a URL request was initiated in the client)
        
        XCTAssertNotNil(client.requestedURL) 
    }
    
}
