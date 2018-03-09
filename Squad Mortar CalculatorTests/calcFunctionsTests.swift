//
//  calcFunctions.swift
//  Squad Mortar CalculatorTests
//
//  Created by James Longman on 07/03/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import XCTest
@testable import Squad_Mortar_Calculator

class calcFunctionsTests: XCTestCase {
    let calc = Calc.sharedInstance
    let calcFunctions = CalcFunctions()

    override func setUp() {
        calc.input = false
    }

    // Verify should return true if calc.input is true
    func testVerifyWithCalcInput() {
        calc.input = true
        XCTAssertTrue(calcFunctions.verify())
    }

    // Verify should return false if there is no mortarXPos
    func testVerifyWithMortarXPos() {
        calc.mortarXPos = -1
        calc.mortarYPos = 1
        calc.targetXPos = 1
        calc.targetYPos = 1
        XCTAssertFalse(calcFunctions.verify())
    }

    // Verify should return false if there is no mortarYPos
    func testVerifyWithMortarYPos() {
        calc.mortarXPos = 1
        calc.mortarYPos = -1
        calc.targetXPos = 1
        calc.targetYPos = 1
        XCTAssertFalse(calcFunctions.verify())
    }

    // Verify should return false if there is no targetXPos
    func testVerifyWithTargetXPos() {
        calc.mortarXPos = 1
        calc.mortarYPos = 1
        calc.targetXPos = -1
        calc.targetYPos = 1
        XCTAssertFalse(calcFunctions.verify())
    }

    // Verify should return false if there is no targetYPos
    func testVerifyWithTargetYPos() {
        calc.mortarXPos = 1
        calc.mortarYPos = 1
        calc.targetXPos = 1
        calc.targetYPos = -1
        XCTAssertFalse(calcFunctions.verify())
    }

    // Verify should return true and set calc.input to true if input has been recieved
    func testVerifyWhenInputIsGood() {
        calc.mortarXPos = 1
        calc.mortarYPos = 1
        calc.targetXPos = 1
        calc.targetYPos = 1
        XCTAssertTrue(calcFunctions.verify())
        XCTAssertTrue(calc.input)
    }

    /* To test the azimuth calculation move target around mortar at 45 degree intervals
     Remember Y values inverted */
    func testAzimuth() {
        calc.mortarXPos = 2
        calc.mortarYPos = 2

        // Should return angle as a Double
        XCTAssertTrue(type(of: calcFunctions.azimuth(targetX: 2, targetY: 3)) == Double.self)

        // Should return 0 when target is straight above
        XCTAssertEqual(calcFunctions.azimuth(targetX: 2, targetY: 1), 0)

        // Should return 45 when target is top right
        XCTAssertEqual(calcFunctions.azimuth(targetX: 3, targetY: 1), 45)

        // Should return 90 when target is straight right
        XCTAssertEqual(calcFunctions.azimuth(targetX: 3, targetY: 2), 90)

        // Should return 135 when target is bottom right
        XCTAssertEqual(calcFunctions.azimuth(targetX: 3, targetY: 3), 135)

        // Should return 180 when target is straight down
        XCTAssertEqual(calcFunctions.azimuth(targetX: 2, targetY: 3), 180)

        // Should return 225 when target is bottom left
        XCTAssertEqual(calcFunctions.azimuth(targetX: 1, targetY: 3), 225)

        // Should return 270 when target is straight above
        XCTAssertEqual(calcFunctions.azimuth(targetX: 1, targetY: 2), 270)

        // Should return 315 when target is top left
        XCTAssertEqual(calcFunctions.azimuth(targetX: 1, targetY: 1), 315)
    }

}
