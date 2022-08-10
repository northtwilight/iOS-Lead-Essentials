//
//  ApiClient.swift
//  iLE1-00-Singletons-and-Global-Instances
//
//  Created by Massimo Savino on 2022-08-02.
//

import Foundation
import UIKit

// "stage 4" abstraction level

// own experimentation

/// Main Module
/// 3 modules, each with a specialty function
///  -  ApiClient inverts dependencies
///
///   1. Login Module
///      login(completion: (LoggedInUser) -> Void)
///
///   2. Feed Module
///      loadFeed(completion: ([FeedItem]) -> Void)
///
///   3. Followers Module
///      loadFollowers(completion: ([Follower]) -> Void
///
///   Plus LogPrint protocol, which prints a string to std output

// Protocols and adapters, not so much closures

protocol LogPrint {}

class LogPrinter: LogPrint {
    static let shared = LogPrinter()
    func logPrint() {
        print("Called by \(#function) in \(#file) on \(#filePath)")
    }
}

struct LoggedInUser {}
struct FeedItem {}
struct Follower {}

// Singleton attempt

class ApiClient {
    static let shared = ApiClient()
    
    private init() {}
    
    func execute(_ : URLRequest, completion: (Data) -> Void) {}
}
 
class MockApiClient: ApiClient {}

/// Main module
protocol LoginClient {}
protocol FeedClient {}
protocol FollowerClient {}

extension LoginClient {
    func login(completion: @escaping (LoggedInUser) -> Void) {
        let logPrinter = LogPrinter()
        logPrinter.logPrint()
    }
}

extension FeedClient {
    func loadFeed(completion: @escaping ([FeedItem]) -> Void) {
        let logPrinter = LogPrinter()
        logPrinter.logPrint()
    }
}

extension FollowerClient {
    func loadFollowers(completion: @escaping([Follower]) -> Void) {
        let logPrinter = LogPrinter()
        logPrinter.logPrint()
    }
}


/// Login Module

class LoginClientAdapter: LoginClient {
    func login(completion: (LoggedInUser) -> Void) {
        // etc
    }
}

class LoginViewController: UIViewController {
    var loginAdapter: LoginClientAdapter = LoginClientAdapter()

    func didTapLoginButton() {
        loginAdapter.login { user in
            // show next screen, allow stuff etc
        }
    }
    
}


/// Feed Module

class FeedClientAdapter: FeedClient {
    func loadFeed(completion: ([FeedItem]) -> Void) {
        // etc
    }
}


class FeedViewController: UIViewController {
    var feedAdapter: FeedClientAdapter = FeedClientAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedAdapter.loadFeed { feedItems in
            // yada yada
        }
    }
}


/// Follower Module

class FollowerClientAdapter: FollowerClient {
    func loadFollowers(completion: ([Follower]) -> Void) {
        // etc
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


