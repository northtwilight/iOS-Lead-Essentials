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
    
    private var messages = [(url: URL, completion: (Result<(Data, HTTPURLResponse), Error>) -> Void)]()
     
    func get(from url: URL, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        messages.append((url, completion))
    }
    
    func complete(with error: Error, at index: Int = 0) {
        if case let error = error {
            messages[index].completion(.failure(error))
        }
    }
    
    func complete(
        withStatusCode code: Int,
        data: Data = Data(),
        at index: Int = 0) {
        let response = HTTPURLResponse(
            url: requestedURLs[index],
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
        messages[index].completion(.success((data, response)))
    }
}

final class RemoteFeedLoaderTests: XCTestCase {
    private struct Constants {
        static let aUrl = "https://a-url.com"
        static let aDotUrl = "https://a.url.com"
        static let aGivenUrl = "https://a-given-URL.com"
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown()  {
        super.tearDown()
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: Constants.aUrl)!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private func expect(
        _ sut: RemoteFeedLoader,
        toCompleteWith result: RemoteFeedLoader.Result,
        file: StaticString = #file,
        line: UInt = #line,
        when action: () -> Void) {
            var capturedResults = [RemoteFeedLoader.Result]()
            sut.load { capturedResults.append($0) }
            
            action()
            
            XCTAssertEqual(capturedResults, [result], file: file, line: line)
        }
    
    func test_init_doesNotRequestDataFromURL() {
        let url = URL(string: Constants.aDotUrl)!
        let (_, client) = makeSUT(url: url)
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        // Arrange: Given a client and sut
        let url = URL(string: Constants.aGivenUrl)!
        let (sut, client) = makeSUT(url: url)
        
        // Act: When we invoke sut.load,
        sut.load { _ in }
        
        // Assert: Then we assert that a URL request was initiated in the client)
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        // Arrange: Given a client and sut
        let url = URL(string: Constants.aGivenUrl)!
        let (sut, client) = makeSUT(url: url)
        
        // Act: Call load twice
        sut.load { _ in }
        sut.load { _ in }
        
        // Assert: Then we assert that a URL requests array came from the client
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError, at: 0)
        })
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        let samples = [199, 201, 300, 400, 500]
        
        samples
            .enumerated()
            .forEach { index, code in
                expect(
                    sut,
                    toCompleteWith: .failure(.invalidData),
                    when: {
                        client.complete(withStatusCode: code, at: index)
                    })
            }
    }
    
    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        
        expect(
            sut,
            toCompleteWith: .failure(.invalidData),
            when: {
                let invalidJSON = Data("invalidJSON".utf8)
                client.complete(withStatusCode: 200, data: invalidJSON)
            })
    }
    
    func test_load_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .success([]), when: {
            let emptyListJSON = Data(bytes: "{\"items\": []}".utf8)
            client.complete(withStatusCode: 200, data: emptyListJSON)
        })
    }
}
