import UIKit

// Singleton

class ApiClient {
    static let instance = ApiClient()

    private init() { }
}

let client = ApiClient.instance

