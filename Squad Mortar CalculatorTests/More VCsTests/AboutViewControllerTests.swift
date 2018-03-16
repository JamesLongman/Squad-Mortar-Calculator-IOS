//
//  AboutViewControllerTests.swift
//  Squad Mortar CalculatorTests
//
//  Created by James Longman on 16/03/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import XCTest
@testable import Squad_Mortar_Calculator

class AboutViewControllerTests: XCTestCase {
    var vc: AboutViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "AboutView") as? AboutViewController
    }

    func testShouldPopulateText() {
        // Load view should populate sections
        let _ = vc.view

        // Should have changed from storyboard text
        XCTAssertTrue(vc.aboutText.text! != "replace")

        // Should be paragraph
        XCTAssertTrue(vc.aboutText.text!.count > 50)
    }

}
