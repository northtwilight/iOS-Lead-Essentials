//
//  PlayerScoreViewControllerStoryboardTests.swift
//  iLE-001b-ComposingViewControllers-Composition+TestingTests
//
//  Created by Massimo Savino on 2022-08-17.
//
@testable import iLE_001b_ComposingViewControllers_Composition_Testing
import XCTest

class PlayerScoreViewControllerStoryboardTests: XCTestCase {
    
    // MARK: PlayerOne Storyboard tests
    
    func test_playerOneStoryboardInitialViewController_isPlayerScoreViewController() {
        XCTAssertTrue(makePlayerOneStoryboard().instantiateInitialViewController() is PlayerScoreViewController)
    }
    
    func test_playerOneStoryboard_nameSetter_updatesNameLabel() {
        let vc = makePlayerScoreViewController(storyboard: makePlayerOneStoryboard() )
        vc.playerView.name = "a name"
        
        XCTAssertEqual(vc.playerView.nameLabel?.text, "a name")
    }
    
    func test_playerOneStoryboard_scoreSetter_updatesScoreLabel() {
        let vc = makePlayerScoreViewController(storyboard: makePlayerOneStoryboard())
        vc.playerView.score = "a name"
        
        XCTAssertEqual(vc.playerView.scoreLabel?.text, "a name")
    }

    // MARK: PlayerTwo Storyboard tests
    
    func test_playerTwoStoryboardInitialViewController_isPlayerScoreViewController() {
        XCTAssertTrue(makePlayerTwoStoryboard().instantiateInitialViewController() is PlayerScoreViewController)
    }
    
    func test_playerTwoStoryboard_nameSetter_updatesNameLabel() {
        let vc = makePlayerScoreViewController(storyboard: makePlayerTwoStoryboard() )
        vc.playerView.name = "a name"
        
        XCTAssertEqual(vc.playerView.nameLabel?.text, "a name")
    }
    
    func test_playerTwoStoryboard_scoreSetter_updatesScoreLabel() {
        let vc = makePlayerScoreViewController(storyboard: makePlayerTwoStoryboard())
        vc.playerView.score = "a name"
        
        XCTAssertEqual(vc.playerView.scoreLabel?.text, "a name")
    }
    
    // MARK: Helpers
    private func makePlayerOneStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "PlayerOne", bundle: nil)
    }
    
    private func makePlayerTwoStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "PlayerTwo", bundle: nil)
    }
    
    private func makePlayerScoreViewController(storyboard: UIStoryboard) -> PlayerScoreViewController {
        let vc = storyboard.instantiateInitialViewController() as! PlayerScoreViewController
        _ = vc.view
        return vc
    }
    
}
