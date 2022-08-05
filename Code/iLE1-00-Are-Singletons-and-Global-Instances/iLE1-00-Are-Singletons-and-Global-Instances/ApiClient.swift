//
//  ApiClient.swift
//  iLE1-00-Are-Singletons-and-Global-Instances
//
//  Created by Massimo Savino on 2022-08-02.
//

import Foundation
import UIKit

// "stage 4" abstraction level

/// Main Module

extension ApiClient {
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

// Singleton
class ApiClient {
    static let shared = ApiClient()
    
    private init() {}
    
    func execute(_ : URLRequest, completion: (Data) -> Void) {}
    
    func logPrint() {
        print("Called by \(#function) in \(#file) on \(#filePath)")
    }
}

class MockApiClient: ApiClient {}

/// Login Module

struct LoggedInUser {}

class LoginViewController: UIViewController {
    var login: (((LoggedInUser) -> Void) -> Void)?

    func didTapLoginButton() {
        login? { user in
            // show next screen
        }
    }
}

/// Feed Module

struct FeedItem {}

class FeedViewController: UIViewController {
    var loadFeed: ((([FeedItem]) -> Void) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFeed? { loadedItems in
            //update UI
        }
    }
}


/// Follower Module

struct Follower {}

class FollowersViewController: UIViewController {
    var loadFollowers: ((([Follower]) -> Void) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFollowers? { followers in
            // update followers' array
        }
    }
}
