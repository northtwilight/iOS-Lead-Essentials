//
//  ApiClient.swift
//  iLE1-00-Are-Singletons-and-Global-Instances
//
//  Created by Massimo Savino on 2022-08-02.
//

import Foundation
import UIKit

// "stage 4" abstraction level

// own experimentation

/// Main Module

extension ApiClient: LogPrint {
    func login(completion: (LoggedInUser) -> Void) {
        logPrint()
    }
}

extension ApiClient {
    func loadFeed(completion: ([FeedItem]) -> Void) {
        logPrint()
    }
}

extension ApiClient {
    func loadFollowers(completion: ([Follower]) -> Void) {
        logPrint()
    }
}

protocol LogPrint {
    func logPrint()
}

extension LogPrint {
    func logPrint() {
        print("Called by \(#function) in \(#file) on \(#filePath)")
    }
}

class ApiClient {
    static let shared = ApiClient()
    
    private init() {}
    
    func execute(_ : URLRequest, completion: (Data) -> Void) {}
}

class MockApiClient: ApiClient {}

/// Login Module

struct LoggedInUser {}

protocol LoginClient {
    func login(completion: (LoggedInUser) -> Void)
}

class LoginClientAdapter: LoginClient, LogPrint {
    func login(completion: (LoggedInUser) -> Void) {
        logPrint()
    }
}

class LoginViewController: UIViewController {
    var loginAdapter: LoginClientAdapter = LoginClientAdapter()

    func didTapLoginButton() {
        loginAdapter.login(completion: { loggedInUser in
            // etc
        })
    }
}

/// Feed Module

struct FeedItem {}

protocol FeedClient {
    func loadFeed(completion: ([FeedItem]) -> Void)
}

class FeedClientAdapter: FeedClient, LogPrint {
    func loadFeed(completion: ([FeedItem]) -> Void) {
        logPrint()
    }
}

class FeedViewController: UIViewController {
    var feedAdapter: FeedClientAdapter = FeedClientAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedAdapter.loadFeed(completion: { feedItems in
            // yada yada
        })
    }
}


/// Follower Module

struct Follower {}

protocol FollowerClient {
    func loadFollowers(completion: ([Follower]) -> Void)
}

class FollowerClientAdapter: FollowerClient, LogPrint {
    func loadFollowers(completion: ([Follower]) -> Void) {
        logPrint()
    }
}

class FollowersViewController: UIViewController {
    var followerAdapter: FollowerClientAdapter = FollowerClientAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        followerAdapter.loadFollowers(completion: { followers in
            // update followers' array
        })
    }
}
