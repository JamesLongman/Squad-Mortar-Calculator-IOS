//
//  GuideViewControllerTests.swift
//  Squad Mortar CalculatorTests
//
//  Created by James Longman on 16/03/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import XCTest
@testable import Squad_Mortar_Calculator

class GuideViewControllerTests: XCTestCase {
    var vc: GuideViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "GuideView") as? GuideViewController
    }

    func testShouldPopulateSections() {
        // Load view should populate sections
        let _ = vc.view

        // Should have changed from storyboard text
        XCTAssertTrue(vc.section1.text! != "section1")
        XCTAssertTrue(vc.section2.text! != "section2")
        XCTAssertTrue(vc.section3.text! != "section3")
        XCTAssertTrue(vc.section4.text! != "section4")
        XCTAssertTrue(vc.section5.text! != "section5")

        // Should be paragraphs
        XCTAssertTrue(vc.section1.text!.count > 50)
        XCTAssertTrue(vc.section2.text!.count > 50)
        XCTAssertTrue(vc.section3.text!.count > 50)
        XCTAssertTrue(vc.section4.text!.count > 50)
        XCTAssertTrue(vc.section5.text!.count > 50)
    }

}
