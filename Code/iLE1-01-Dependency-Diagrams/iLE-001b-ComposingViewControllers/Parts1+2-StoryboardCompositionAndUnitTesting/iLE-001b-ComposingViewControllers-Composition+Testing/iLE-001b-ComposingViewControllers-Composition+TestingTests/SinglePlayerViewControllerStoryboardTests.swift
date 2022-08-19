//
//  SinglePlayerViewControllerStoryboardTests.swift
//  iLE-001b-ComposingViewControllers-Composition+TestingTests
//
//  Created by Massimo Savino on 2022-08-18.
//

@testable import iLE_001b_ComposingViewControllers_Composition_Testing
import XCTest

class SinglePlayerViewControllerStoryboardTests: XCTestCase {
    let storyboard = UIStoryboard(name: "SinglePlayerGame", bundle: nil)
    
    func test_singlePlayerGameStoryboardInitialViewController_isSinglePlayerViewController() {
        XCTAssertTrue(storyboard.instantiateInitialViewController() is SinglePlayerViewController)
    }
    
    func test_singlePlayerGameStoryboard_setsUpPlayerForSinglePlayerViewController() {
        // Check out the implementations in the SinglePlayerViewController vs the StoryboardConfigurator
        
        let vc = storyboard.instantiateInitialViewController() as! SinglePlayerViewController
        _ = vc.view
        XCTAssertNotNil(vc.player)
    }
}
