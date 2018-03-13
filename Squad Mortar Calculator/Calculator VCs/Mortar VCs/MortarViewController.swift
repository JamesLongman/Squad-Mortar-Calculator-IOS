//
//  MortarViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 01/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

// Protocal to pass up to CalculatorViewController
protocol MortarLocations {
    func mortarLocations()
}

class MortarViewController: UIViewController, UITextFieldDelegate, PassMortarLoc3 {

    var delegate: MortarLocations?
    let calc = Calc.sharedInstance

    // 3 fields and grid in Mortar view
    @IBOutlet weak var leftMortarField: CoordinatesTextField1!
    @IBOutlet weak var middleMortarField: CoordinatesTextField2!
    @IBOutlet weak var rightMortarField: CoordinatesTextField2!
    @IBOutlet weak var mortarGrid: UIView!

    // Allow keyboard to be dismissed via touching elsewhere on the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        leftMortarField.resignFirstResponder()
        middleMortarField.resignFirstResponder()
        rightMortarField.resignFirstResponder()
    }

    // Declare self as a delegate of sub view so can be notified upon input
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embeddedMortarGridSegue" {
            let mortarGridViewController = segue.destination as? MortarGridViewController
            mortarGridViewController?.delegate = self
        }
    }

    // When edditting ends in any input field, check to see if input is of a complete format
    @IBAction func leftMortarFieldEnded(_ sender: Any) {
        updateMortar()
    }

    @IBAction func middleMortarFieldEnded(_ sender: Any) {
        updateMortar()
    }

    @IBAction func rightMortarFieldEnded(_ sender: Any) {
        updateMortar()
    }

    // Called from subview upon input, check input to see if it is of a complete format
    func passMortar3() {
        updateMortar()
    }

    /* Called upon input, checks if input is complete, if so save to the calc singleton and notify
     parent view */
    func updateMortar() {
        // Checks input, if input is not complete return to wait for complete input
        if !checkMortarFields() {
            return
        }

        /* Variables to store the mortar position throughout the calculation
         these values are in meters and y axis is inverted */
        var mortarXPos: Double = 0
        var mortarYPos: Double = 0

        // Convert letter component in first field to numerical value
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for letter in alphabet {
            if letter == leftMortarField.text!.uppercased()[0] {
                break
            }
            mortarXPos += 300
        }

        // Convert number component of first field to meters
        if leftMortarField.text!.count == 2 {
            mortarYPos = (Double(String(leftMortarField.text![1]))! - 1) * 300
        } else {
            mortarYPos = Double(String(leftMortarField.text![1]))! * 3000
            mortarYPos = (Double(String(leftMortarField.text![2]))! - 1) * 300
        }

        // Convert second field to meters and add to sum
        switch Int(middleMortarField.text!)! {
            case 1:
                mortarYPos += 200
            case 2:
                mortarYPos += 200
                mortarXPos += 100
            case 3:
                mortarYPos += 200
                mortarXPos += 200
            case 4:
                mortarYPos += 100
            case 5:
                mortarYPos += 100
                mortarXPos += 100
            case 6:
                mortarYPos += 100
                mortarXPos += 200
            case 8:
                mortarXPos += 100
            case 9:
                mortarXPos += 200
            default:
                break // Should never hit default due to field input restrictions from custom class
        }

        // Convert third field to meters and add to sum
        let increment: Double = 100/3
        switch Int(rightMortarField.text!)! {
            case 1:
                mortarYPos += increment * 2
            case 2:
                mortarYPos += increment * 2
                mortarXPos += increment
            case 3:
                mortarYPos += increment * 2
                mortarXPos += increment * 2
            case 4:
                mortarYPos += increment
            case 5:
                mortarYPos += increment
                mortarXPos += increment
            case 6:
                mortarYPos += increment
                mortarXPos += increment * 2
            case 8:
                mortarXPos += increment
            case 9:
                mortarXPos += increment * 2
            default:
                break
        }

        /* Add subgrid position to sum (this value is not changed in this view but from
         EnlargedMortarGridViewController.swift) */
        mortarXPos += calc.mortarSubgridXPos
        mortarYPos += calc.mortarSubgridYPos

        // Update calculator singleton with the accepted input value and notify parent
        calc.mortarXPos = mortarXPos
        calc.mortarYPos = mortarYPos
        delegate!.mortarLocations()
    }

    // Checks input in all text fields is of an acceptable format
    func checkMortarFields() -> Bool {
        // Check left field input (should be the only field that can possibly have bad input)
        if leftMortarField.text == "" {
            return false
        }
        if !(leftMortarField.text!.count == 2 || leftMortarField.text!.count == 3) {
            rejectLeftMortarField()
            return false
        }
        if !(leftMortarField.text![0].containedIn(matchCharacters: leftMortarField.acceptableFirstCharacters)) {
            rejectLeftMortarField()
            return false
        }
        if !(leftMortarField.text![1].containedIn(matchCharacters: leftMortarField.acceptableSecondCharacters)) {
            rejectLeftMortarField()
            return false
        }
        if leftMortarField.text?.count == 3 {
            if !(leftMortarField.text![2].containedIn(matchCharacters: leftMortarField.acceptableSecondCharacters)) {
                rejectLeftMortarField()
                return false
            }
            if leftMortarField.text?[1] == "0" {
                rejectLeftMortarField()
                return false
            }
        }
        if leftMortarField.backgroundColor !== UIColor.white {
            leftMortarField.backgroundColor = UIColor.white
        }

        // Check middle field
        if middleMortarField.text == "" {
            return false
        }
        if !(middleMortarField.text?.count == 1) {
            rejectMiddleMortarField()
            return false
        }
        if !((middleMortarField.text?.containsOnlyCharactersIn(matchCharacters: middleMortarField.allowedChars))!) {
            rejectMiddleMortarField()
            return false
        }
        if middleMortarField.backgroundColor !== UIColor.white {
            middleMortarField.backgroundColor = UIColor.white
        }

        // Check right field
        if rightMortarField.text == "" {
            return false
        }
        if !(rightMortarField.text?.count == 1) {
            rejectRightMortarField()
            return false
        }
        if !((rightMortarField.text?.containsOnlyCharactersIn(matchCharacters: rightMortarField.allowedChars))!) {
            rejectRightMortarField()
            return false
        }
        if rightMortarField.backgroundColor !== UIColor.white {
            rightMortarField.backgroundColor = UIColor.white
        }

        // All text fields good
        return true
    }

    // If a field rejects, hint user that input is invalid by highlighting the field with red
    func rejectLeftMortarField() {
        leftMortarField.backgroundColor = UIColor.red
    }

    func rejectMiddleMortarField() {
        middleMortarField.backgroundColor = UIColor.red
    }

    func rejectRightMortarField() {
        rightMortarField.backgroundColor = UIColor.red
    }

}
