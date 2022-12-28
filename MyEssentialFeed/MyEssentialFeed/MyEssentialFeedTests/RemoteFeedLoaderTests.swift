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
        data: Data,
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
        static let deallocWarningMemLeak = "Instance should have been deallocated. Potential memory leak."
        static let anyURL = "http://any-url.com"
    }
    private static var OK_200: Int {
        return 200
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
        
        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(client)
        
        return (sut, client)
    }
    
    private func trackForMemoryLeaks(
        _ instance: AnyObject,
        file: StaticString = #file,
        line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                Constants.deallocWarningMemLeak,
                file: file,
                line: line)
        }
    }
    
    private func expect(
        _ sut: RemoteFeedLoader,
        toCompleteWith result: Result<[FeedItem], RemoteFeedLoader.Error>,
        file: StaticString = #file,
        line: UInt = #line,
        when action: () -> Void) {
            var capturedResults = [Result<[FeedItem], RemoteFeedLoader.Error>]()
            sut.load { capturedResults.append($0) }
            
            action()
            
            XCTAssertEqual(capturedResults, [result], file: file, line: line)
        }
    
    // Helper: Factory method for item creation
    private func makeItem(
        id: UUID,
        description: String? = nil,
        location: String? = nil,
        imageURL: URL) -> (model: FeedItem, json: [String: Any]) {
            let item = FeedItem(
                id: id,
                description: description,
                location: location,
                imageURL: imageURL)
            
            let json = [
                "id": id.uuidString,
                "description": description,
                "location": location,
                "image": imageURL.absoluteString
                // Maybe sub this with compactMap???
            ].reduce(into: [String: Any]()) { (accumulated, element) in
                if let value = element.value { accumulated[element.key] = value }
            }
            return (item, json)
        }
    
    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        let json = ["items": items]
        return try! JSONSerialization.data(withJSONObject: json)
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
        // Arrange: Given a system to test and a client
        let (sut, client) = makeSUT()
        
        // Act: We fail to complete with a connection error
        expect(sut, toCompleteWith: .failure(.connectivity), when: {
            // Assert: The client shows that error as its completion status
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError, at: 0)
        })
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        // Arrange: Given we have a SUT and client, plus sample status codes
        let (sut, client) = makeSUT()
        let samples = [199, 201, 300, 400, 500]
        
        samples
            .enumerated()
            .forEach { index, code in
                expect(
                    sut,
                    // Act: Where the status code indicates invalid data
                    toCompleteWith: .failure(.invalidData),
                    when: {
                        let json = makeItemsJSON( [] )
                        // Assert: We should see errors when non 200 codes encountered.
                        client.complete(withStatusCode: code, data: json, at: index)
                    })
            }
    }
    
    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        // Arrange: Given we have a SUT and client
        let (sut, client) = makeSUT()
        
        expect(
            sut,
            toCompleteWith: .failure(.invalidData),
            when: {
                // Act: We have invalid JSON for use
                let invalidJSON = Data("invalidJSON".utf8)
                // Assert: The client fails with an error
                client.complete(withStatusCode: 200, data: invalidJSON)
            })
    }
    
    func test_load_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() {
        // Arrange: Given we have a SUT and client
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .success([]), when: {
            // Act: When we supply JSON with no content
            let emptyListJSON = Data(bytes: "{\"items\": []}".utf8)
            // Assert: We get no items to show, even as the response is OK.
            client.complete(withStatusCode: 200, data: emptyListJSON)
        })
    }
    
    // happy path
    func test_load_deliversItemsOn200HTTPResponseWithValidJSON() {
        // Arrange: Given we have a SUT and client
        let (sut, client) = makeSUT()
        
        let itemOne = makeItem(
            id: UUID(),
            imageURL: URL(string: Constants.aDotUrl)!)
        
        let itemTwo = makeItem(
            id: UUID(),
            description: "A description",
            location: "A location",
            imageURL: URL(string: Constants.aGivenUrl)!)
        
        let items = [itemOne.model, itemTwo.model]
        
        expect(
            sut,
            toCompleteWith: .success(items),
            when: {
                // Act: We load up the correct JSON for two items
                let json = makeItemsJSON([itemOne.json, itemTwo.json])
                // Assert: We get back two FeedItems as promised
                client.complete(withStatusCode: 200, data: json)
            })
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let url = URL(string: Constants.anyURL)!
        let client = HTTPClientSpy()
        var sut: RemoteFeedLoader? = RemoteFeedLoader(url: url, client: client)
        
        var capturedResults = [Result<[FeedItem], RemoteFeedLoader.Error>]()
        sut?.load { capturedResults.append($0) }
        
        sut = nil
        client.complete(withStatusCode: 200, data: makeItemsJSON([]))
        
        XCTAssertTrue(capturedResults.isEmpty)
    }
}
