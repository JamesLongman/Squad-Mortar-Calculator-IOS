//
//  extensionsTests.swift
//  Squad Mortar CalculatorTests
//
//  Created by James Longman on 09/03/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import XCTest
@testable import Squad_Mortar_Calculator

class extensionsTests: XCTestCase {

    func testDoubleRounded() {
        var numberToRound: Double = 0.86
        var i: Double = 0

        // Should return rounded number of type double
        XCTAssertTrue(type(of: numberToRound.rounded()) == Double.self)
        XCTAssertTrue(numberToRound.rounded().truncatingRemainder(dividingBy: 1) == 0)

        // Should round up
        while i < 10 {
            i += 1
            XCTAssertEqual(numberToRound.rounded(), i)
            numberToRound += 1
        }

        // Should round down
        i = 0
        numberToRound = 0.34
        while i < 10 {
            XCTAssertEqual(numberToRound.rounded(), i)
            i += 1
            numberToRound += 1
        }

        // Should round up if 0.5
        numberToRound = 0.5
        XCTAssertEqual(numberToRound.rounded(), 1)

        // Should not round if already of interger value
        numberToRound = 0
        XCTAssertEqual(numberToRound.rounded(), 0)
        numberToRound = 1
        XCTAssertEqual(numberToRound.rounded(), 1)

        // Should round negatives correctly
        numberToRound = -4.3
        XCTAssertEqual(numberToRound.rounded(), -4)
        numberToRound = -4.5
        XCTAssertEqual(numberToRound.rounded(), -5)
        numberToRound = -5.87
        XCTAssertEqual(numberToRound.rounded(), -6)
    }

    func testStringContainsOnlyCharactersIn() {
        var testing: String = "abcdef"

        // Should return boolean
        XCTAssertTrue(type(of: testing.containsOnlyCharactersIn(matchCharacters: "abcdefghijkl")) == Bool.self)

        // Should return true if string is in character set
        XCTAssertTrue(testing.containsOnlyCharactersIn(matchCharacters: "abcdefghijkl"))
        testing = "kde"
        XCTAssertTrue(testing.containsOnlyCharactersIn(matchCharacters: "abcdefghijkl"))
        testing = "eeeeeeeeccccccc"
        XCTAssertTrue(testing.containsOnlyCharactersIn(matchCharacters: "abcdefghijkl"))

        // Should return false if string contains a character out of the set
        testing = "abcdzfghi"
        XCTAssertFalse(testing.containsOnlyCharactersIn(matchCharacters: "abcdefghijkl"))
        testing = "quxz"
        XCTAssertFalse(testing.containsOnlyCharactersIn(matchCharacters: "abcdefghijkl"))
        testing = "z"
        XCTAssertFalse(testing.containsOnlyCharactersIn(matchCharacters: "abcdefghijkl"))

        // Should return false due to case sensitive
        testing = "abcdeFgh"
        XCTAssertFalse(testing.containsOnlyCharactersIn(matchCharacters: "abcdefghijkl"))
        testing = "ABC"
        XCTAssertFalse(testing.containsOnlyCharactersIn(matchCharacters: "abcdefghijkl"))
        testing = "A"
        XCTAssertFalse(testing.containsOnlyCharactersIn(matchCharacters: "abcdefghijkl"))

        // Should return false if string contains random characters
        testing = "abcde%gh"
        XCTAssertFalse(testing.containsOnlyCharactersIn(matchCharacters: "abcdefghijkl"))
        testing = "£(*"
        XCTAssertFalse(testing.containsOnlyCharactersIn(matchCharacters: "abcdefghijkl"))
        testing = "!"
        XCTAssertFalse(testing.containsOnlyCharactersIn(matchCharacters: "abcdefghijkl"))
    }

    // String subscript should allow referencing
    func testStringSubscript() {
        var testing: String = "abcdef"

        // Should be able to access characters
        XCTAssertEqual(testing[0], "a")
        XCTAssertEqual(testing[1], "b")
        XCTAssertEqual(testing[2], "c")
        XCTAssertEqual(testing[3], "d")
        XCTAssertEqual(testing[4], "e")
        XCTAssertEqual(testing[5], "f")

        // Should return whitespace if attempt to  reference character outside of string's range
        XCTAssertEqual(testing[6], " ")
        XCTAssertEqual(testing[-1], " ")
        XCTAssertEqual(testing[450], " ")

        // Should return case sensitive
        testing = "abCdef"
        XCTAssertFalse(testing[2] == "c")
        XCTAssertEqual(testing[2], "C")
    }

    func testContainedIn() {
        let set = "abcdef"

        // Should return boolean
        XCTAssertTrue(type(of: Character("a").containedIn(matchCharacters: set)) == Bool.self)

        // Should return true if contained within set
        XCTAssertTrue(Character("a").containedIn(matchCharacters: set))
        XCTAssertTrue(Character("b").containedIn(matchCharacters: set))
        XCTAssertTrue(Character("c").containedIn(matchCharacters: set))
        XCTAssertTrue(Character("f").containedIn(matchCharacters: set))

        // Should return false if not contained in set
        XCTAssertFalse(Character("x").containedIn(matchCharacters: set))
        XCTAssertFalse(Character("v").containedIn(matchCharacters: set))
        XCTAssertFalse(Character("r").containedIn(matchCharacters: set))
        XCTAssertFalse(Character("p").containedIn(matchCharacters: set))

        // Should return false idue to case sensitive
        XCTAssertFalse(Character("A").containedIn(matchCharacters: set))
        XCTAssertFalse(Character("B").containedIn(matchCharacters: set))
        XCTAssertFalse(Character("C").containedIn(matchCharacters: set))
        XCTAssertFalse(Character("F").containedIn(matchCharacters: set))
    }

    // TODO: Not sure how to test UILabel extensions, issue #35

    // Be careful when testing user defaults to clear after testing
    func testUserDefaultsHasValue() {
        let userDefaults = UserDefaults.standard

        // Should return false if UserDefaults does not have a value for key
        XCTAssertFalse(userDefaults.hasValue(forKey: "test"))

        // Should return true if UserDefaults has value
        userDefaults.set(false, forKey: "test")
        XCTAssertTrue(userDefaults.hasValue(forKey: "test"))

        // Should not have value after tests complete (effectively a test of the test)
        userDefaults.removeObject(forKey: "test")
        XCTAssertFalse(userDefaults.hasValue(forKey: "test"))
    }

}
