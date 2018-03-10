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

    // Test distance calculation works for all directions
    func testDistanceInDirections() {
        calc.mortarXPos = 2
        calc.mortarYPos = 2

        // Should return distance as a Double
        XCTAssertTrue(type(of: calcFunctions.azimuth(targetX: 2, targetY: 3)) == Double.self)

        // Should return 1 meter in all directions straight
        XCTAssertEqual(calcFunctions.distance(targetX: 2, targetY: 1), 1)
        XCTAssertEqual(calcFunctions.distance(targetX: 3, targetY: 2), 1)
        XCTAssertEqual(calcFunctions.distance(targetX: 2, targetY: 3), 1)
        XCTAssertEqual(calcFunctions.distance(targetX: 1, targetY: 2), 1)

        // Should return root 2 in all 45 degree angles with a delta x and y of magnitude 1
        XCTAssertEqual(calcFunctions.distance(targetX: 3, targetY: 1), sqrt(2))
        XCTAssertEqual(calcFunctions.distance(targetX: 3, targetY: 3), sqrt(2))
        XCTAssertEqual(calcFunctions.distance(targetX: 1, targetY: 3), sqrt(2))
        XCTAssertEqual(calcFunctions.distance(targetX: 1, targetY: 1), sqrt(2))
    }

    // Check distance calculation with different magnitudes
    func testDistanceWithMagnitudes() {
        calc.mortarXPos = 0
        calc.mortarYPos = 0

        // Check X values faily robustly
        var counter: Double = 0
        while counter < 20 {
            counter += 1
            let xValue = randomDouble(min: 0, max: 1250)
            XCTAssertEqual(calcFunctions.distance(targetX: xValue, targetY: 0), xValue)
        }

        // Check Y values quickly
        XCTAssertEqual(calcFunctions.distance(targetX: 0, targetY: 0.25), 0.25)
        XCTAssertEqual(calcFunctions.distance(targetX: 0, targetY: 6), 6)
        XCTAssertEqual(calcFunctions.distance(targetX: 0, targetY: 742), 742)

        // Check a few Pythagorean triples
        XCTAssertEqual(calcFunctions.distance(targetX: 3, targetY: 4), 5)
        XCTAssertEqual(calcFunctions.distance(targetX: 35, targetY: 12), 37)
        XCTAssertEqual(calcFunctions.distance(targetX: 28, targetY: 195), 197)
        XCTAssertEqual(calcFunctions.distance(targetX: 40, targetY: 399), 401)
        XCTAssertEqual(calcFunctions.distance(targetX: 64, targetY: 1023), 1025)
    }

    /* For now 2d formula so test by ensuring each milliradian value is within 1 milliRad of the
    value provided for meters in the in-game data set being interpolated */
    func testRads() {
        // Should return milliRadians as a Double
        XCTAssertTrue(type(of: calcFunctions.rads(distance: 50)) == Double.self)

        // Test each data point
        XCTAssertTrue((calcFunctions.rads(distance: 50) - 1579) > -1 && (calcFunctions.rads(distance: 50) - 1579) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 100) - 1558) > -1 && (calcFunctions.rads(distance: 100) - 1558) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 150) - 1538) > -1 && (calcFunctions.rads(distance: 150) - 1538) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 200) - 1517) > -1 && (calcFunctions.rads(distance: 200) - 1517) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 250) - 1496) > -1 && (calcFunctions.rads(distance: 250) - 1496) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 300) - 1475) > -1 && (calcFunctions.rads(distance: 300) - 1475) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 350) - 1453) > -1 && (calcFunctions.rads(distance: 350) - 1453) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 400) - 1432) > -1 && (calcFunctions.rads(distance: 400) - 1431) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 450) - 1409) > -1 && (calcFunctions.rads(distance: 450) - 1409) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 500) - 1387) > -1 && (calcFunctions.rads(distance: 500) - 1387) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 550) - 1364) > -1 && (calcFunctions.rads(distance: 550) - 1364) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 600) - 1341) > -1 && (calcFunctions.rads(distance: 600) - 1341) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 650) - 1317) > -1 && (calcFunctions.rads(distance: 650) - 1317) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 700) - 1292) > -1 && (calcFunctions.rads(distance: 700) - 1292) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 750) - 1267) > -1 && (calcFunctions.rads(distance: 750) - 1267) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 800) - 1240) > -1 && (calcFunctions.rads(distance: 800) - 1240) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 850) - 1212) > -1 && (calcFunctions.rads(distance: 850) - 1212) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 900) - 1183) > -1 && (calcFunctions.rads(distance: 900) - 1183) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 950) - 1152) > -1 && (calcFunctions.rads(distance: 950) - 1152) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 1000) - 1118) > -1 && (calcFunctions.rads(distance: 1000) - 1118) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 1050) - 1081) > -1 && (calcFunctions.rads(distance: 1050) - 1081) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 1100) - 1039) > -1 && (calcFunctions.rads(distance: 1100) - 1039) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 1150) - 988) > -1 && (calcFunctions.rads(distance: 1150) - 988) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 1200) - 918) > -1 && (calcFunctions.rads(distance: 1200) - 918) < 1)
        XCTAssertTrue((calcFunctions.rads(distance: 1250) - 800) > -1 && (calcFunctions.rads(distance: 1250) - 800) < 1)

    }

    // Returns a random double in specified range (taken from BarrageViewController.swift)
    func randomDouble(min: Double, max: Double) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }

}
