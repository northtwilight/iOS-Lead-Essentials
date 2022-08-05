//
//  ApiClient.swift
//  iLE1-00-Are-Singletons-and-Global-Instances
//
//  Created by Massimo Savino on 2022-08-02.
//

import Foundation
import UIKit

struct LoggedInUser {}
struct FeedItem {}
struct Follower {}

// yet more abstraction and flexibility

    
// Singleton
class ApiClient {
    static let shared = ApiClient()
    
    private init() {}
    
    func execute(_ : URLRequest, completion: (Data) -> Void) {}
    
    func logPrint() {
        print("Called by \(#function) in \(#file) on \(#filePath)")
    }
}

extension ApiClient: LoginClient {
    func login(completion: (LoggedInUser) -> Void) {
        logPrint()
    }
}

extension ApiClient: FeedClient {
    func loadFeed(completion: ([FeedItem]) -> Void) {
        logPrint()
    }
}

extension ApiClient: FollowerClient {
    func loadFollowers(completion: ([Follower]) -> Void) {
        logPrint()
    }
}



protocol LoginClient {
    func login(completion: (LoggedInUser) -> Void)
}

class MockApiClient: ApiClient {}

class LoginViewController: UIViewController {
    var api = ApiClient.shared

    func didTapLoginButton() {
        api.login() { user in
            // show next screen
        }
    }
}

protocol FeedClient {
    func loadFeed(completion: ([FeedItem]) -> Void)
}

class FeedViewController: UIViewController {
    var api = ApiClient.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.loadFeed { loadedItems in
            //update UI
        }
    }
}

protocol FollowerClient {
    func loadFollowers(completion: ([Follower]) -> Void)
}

class FollowersViewController: UIViewController {
    var api = ApiClient.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.loadFollowers { followers in
            // update followers' array
        }
    }
}
