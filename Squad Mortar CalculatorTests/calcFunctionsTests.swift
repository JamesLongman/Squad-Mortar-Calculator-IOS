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

    override func setUp() {
        calc.input = false
    }

    func testVerify() {
        let calcFunctions = CalcFunctions()
        calc.input = true

        XCTAssertTrue(calcFunctions.verify())
    }

}
