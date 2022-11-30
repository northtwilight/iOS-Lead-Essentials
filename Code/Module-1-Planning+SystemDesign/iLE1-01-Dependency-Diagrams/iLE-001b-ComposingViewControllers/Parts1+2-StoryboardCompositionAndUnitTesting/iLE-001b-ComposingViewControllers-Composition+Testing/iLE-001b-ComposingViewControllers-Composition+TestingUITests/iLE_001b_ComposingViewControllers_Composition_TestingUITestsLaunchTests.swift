//
//  iLE_001b_ComposingViewControllers_Composition_TestingUITestsLaunchTests.swift
//  iLE-001b-ComposingViewControllers-Composition+TestingUITests
//
//  Created by Massimo Savino on 2022-08-11.
//

import XCTest

class iLE_001b_ComposingViewControllers_Composition_TestingUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
