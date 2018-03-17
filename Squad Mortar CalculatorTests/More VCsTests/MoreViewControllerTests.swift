//
//  MoreViewControllerTests.swift
//  Squad Mortar CalculatorTests
//
//  Created by James Longman on 16/03/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import XCTest
@testable import Squad_Mortar_Calculator

class MoreViewControllerTests: XCTestCase {
    var vc: MoreViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "MoreView") as? MoreViewController
        let _ = vc.view
    }

    func testViewDidLoad() {
        // Should have changed background colour to Mercury
        XCTAssertEqual(vc.tableView.backgroundColor, UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0))
    }

    func testSections() {
        XCTAssertEqual(vc.tableView.numberOfSections, 1)
    }

    func testRowsInSection() {
        let sections = vc.tableView.numberOfSections
        var counter = 0
        while counter < sections {
            XCTAssertEqual(vc.tableView.numberOfRows(inSection: counter), vc.moreTable.count)
            counter += 1
        }
    }

    func testViewWillAppear() {
        // Mock class to test function is called
        class MockMoreViewController: MoreViewController {
            var animateCalled = false

            override func animateTable() {
                animateCalled = true
            }


        }

        // Should call animateTable() on viewWillAppear
        let mockVC = MockMoreViewController()
        mockVC.viewWillAppear(false)
        XCTAssertTrue(mockVC.animateCalled)
    }

}
