//
//  BarrageTargetViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 20/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

/* For comments please see mortar VCs counterpart */

import UIKit

protocol BarrageTargetLocations {
    func barrageTargetLocations()
}

class BarrageTargetViewController: UIViewController, UITextFieldDelegate, PassBarrageTargetLoc3 {

    var delegate: BarrageTargetLocations?
    let calc = Calc.sharedInstance

    @IBOutlet weak var leftTargetField: CoordinatesTextField1!
    @IBOutlet weak var middleTargetField: CoordinatesTextField2!
    @IBOutlet weak var rightTargetField: CoordinatesTextField2!
    @IBOutlet weak var targetGrid: UIView!

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        leftTargetField.resignFirstResponder()
        middleTargetField.resignFirstResponder()
        rightTargetField.resignFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embeddedBarrageTargetGridSegue" {
            let targetGridViewController = segue.destination as? BarrageGridViewController
            targetGridViewController?.delegate = self
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        leftTargetField.text = calc.targetLeftField
        middleTargetField.text = calc.targetMidField
        rightTargetField.text = calc.targetRightField
    }

    @IBAction func leftTargetFieldEnded(_ sender: Any) {
        updateTarget()
    }

    @IBAction func middleTargetFieldEnded(_ sender: Any) {
        updateTarget()
    }

    @IBAction func rightTargetFieldEnded(_ sender: Any) {
        updateTarget()
    }


    func passBarrageTarget3() {
        updateTarget()
    }

    func updateTarget() {
        if !checkTargetFields() {
            return
        }

        var targetXPos: Double = 0
        var targetYPos: Double = 0

        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for letter in alphabet {
            if letter == leftTargetField.text!.uppercased()[0] {
                break
            }
            targetXPos += 300
        }

        if leftTargetField.text!.count == 2 {
            targetYPos = (Double(String(leftTargetField.text![1]))! - 1) * 300
        } else {
            targetYPos = Double(String(leftTargetField.text![1]))! * 3000
            targetYPos = (Double(String(leftTargetField.text![2]))! - 1) * 300
        }

        switch Int(middleTargetField.text!)! {
            case 1:
                targetYPos += 200
            case 2:
                targetYPos += 200
                targetXPos += 100
            case 3:
                targetYPos += 200
                targetXPos += 200
            case 4:
                targetYPos += 100
            case 5:
                targetYPos += 100
                targetXPos += 100
            case 6:
                targetYPos += 100
                targetXPos += 200
            case 8:
                targetXPos += 100
            case 9:
                targetXPos += 200
            default:
                break
        }

        let increment: Double = 100/3
        switch Int(rightTargetField.text!)! {
            case 1:
                targetYPos += increment * 2
            case 2:
                targetYPos += increment * 2
                targetXPos += increment
            case 3:
                targetYPos += increment * 2
                targetXPos += increment * 2
            case 4:
                targetYPos += increment
            case 5:
                targetYPos += increment
                targetXPos += increment
            case 6:
                targetYPos += increment
                targetXPos += increment * 2
            case 8:
                targetXPos += increment
            case 9:
                targetXPos += increment * 2
            default:
                break
        }

        targetXPos += calc.targetSubgridXPos
        targetYPos += calc.targetSubgridYPos

        calc.targetXPos = targetXPos
        calc.targetYPos = targetYPos
        delegate!.barrageTargetLocations()
    }

    func checkTargetFields() -> Bool {
        if leftTargetField.text == "" {
            return false
        }
        if !(leftTargetField.text!.count == 2 || leftTargetField.text!.count == 3) {
            rejectLeftTargetField()
            return false
        }
        if !(leftTargetField.text![0].containedIn(matchCharacters: leftTargetField.acceptableFirstCharacters)) {
            rejectLeftTargetField()
            return false
        }
        if !(leftTargetField.text![1].containedIn(matchCharacters: leftTargetField.acceptableSecondCharacters)) {
            rejectLeftTargetField()
            return false
        }
        if leftTargetField.text!.count == 3 {
            if !(leftTargetField.text![2].containedIn(matchCharacters: leftTargetField.acceptableSecondCharacters)) {
                rejectLeftTargetField()
                return false
            }
        }
        if leftTargetField.backgroundColor !== UIColor.white {
            leftTargetField.backgroundColor = UIColor.white
        }


        if middleTargetField.text == "" {
            return false

        }
        if !(middleTargetField.text?.count == 1) {
            rejectMiddleTargetField()
            return false
        }
        if !((middleTargetField.text?.containsOnlyCharactersIn(matchCharacters: middleTargetField.allowedChars))!) {
            rejectMiddleTargetField()
            return false
        }
        if middleTargetField.backgroundColor !== UIColor.white {
            middleTargetField.backgroundColor = UIColor.white
        }

        if rightTargetField.text == "" {
            return false
        }
        if !(rightTargetField.text?.count == 1) {
            rejectRightTargetField()
            return false
        }
        if !((rightTargetField.text?.containsOnlyCharactersIn(matchCharacters: rightTargetField.allowedChars))!) {
            rejectRightTargetField()
            return false
        }
        if rightTargetField.backgroundColor !== UIColor.white {
            rightTargetField.backgroundColor = UIColor.white
        }


        calc.targetLeftField = leftTargetField.text!
        calc.targetMidField = middleTargetField.text!
        calc.targetRightField = rightTargetField.text!
        return true
    }

    func rejectLeftTargetField() {
        leftTargetField.backgroundColor = UIColor.red
    }

    func rejectMiddleTargetField() {
        middleTargetField.backgroundColor = UIColor.red
    }

    func rejectRightTargetField() {
        rightTargetField.backgroundColor = UIColor.red
    }

}
