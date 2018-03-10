//
//  calcValuesTests.swift
//  Squad Mortar CalculatorTests
//
//  Created by James Longman on 10/03/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import XCTest
@testable import Squad_Mortar_Calculator

class calcValuesTests: XCTestCase {
    let calc = Calc.sharedInstance

    // First check the calc has values of correct types
    func testCalcHasValues() {
        XCTAssertTrue(type(of: calc.input) == Bool.self)

        XCTAssertTrue(type(of: calc.mortarXPos) == Double.self)
        XCTAssertTrue(type(of: calc.mortarYPos) == Double.self)
        XCTAssertTrue(type(of: calc.targetXPos) == Double.self)
        XCTAssertTrue(type(of: calc.targetYPos) == Double.self)

        XCTAssertTrue(type(of: calc.azimuth) == Double.self)
        XCTAssertTrue(type(of: calc.rads) == Double.self)

        XCTAssertTrue(type(of: calc.mortarSubgridXPos) == Double.self)
        XCTAssertTrue(type(of: calc.mortarSubgridYPos) == Double.self)
        XCTAssertTrue(type(of: calc.targetSubgridXPos) == Double.self)
        XCTAssertTrue(type(of: calc.targetSubgridYPos) == Double.self)

        XCTAssertTrue(type(of: calc.targetLeftField) == String.self)
        XCTAssertTrue(type(of: calc.targetMidField) == String.self)
        XCTAssertTrue(type(of: calc.targetRightField) == String.self)
    }

    // Check calc values can be altered and read from the same instance
    func testCalcValuesFromInstance() {
        let calc2 = Calc.sharedInstance
        calc.mortarXPos = 100
        XCTAssertEqual(calc2.mortarXPos, 100)
        calc.rads = 55
        XCTAssertEqual(calc2.rads, 55)
        calc2.targetSubgridYPos = 0.5
        XCTAssertEqual(calc2.targetSubgridYPos, 0.5)
        XCTAssertEqual(calc.targetSubgridYPos, 0.5)

        // Reset values for shared instance
        calc.mortarXPos = -1
        calc.rads = 0
        calc.targetSubgridYPos = 100/6
    }

}
