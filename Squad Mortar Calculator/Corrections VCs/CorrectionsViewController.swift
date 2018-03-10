//
//  CorrectionsViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 19/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

/* Very simmilar to CalculatorViewController.swift, more detailed comments there */

class CorrectionsViewController: UIViewController, CorrectionsTargetLocations {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!

    @IBOutlet weak var northField: CoordinatesTextField2!
    @IBOutlet weak var eastField: CoordinatesTextField2!
    @IBOutlet weak var southField: CoordinatesTextField2!
    @IBOutlet weak var westField: CoordinatesTextField2!

    @IBOutlet weak var addField: CoordinatesTextField2!
    @IBOutlet weak var subtractField: CoordinatesTextField2!

    let calc = Calc.sharedInstance

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "targetCorrectionsSectionSegue" {
            let targetSection = segue.destination as? CorrectionsTargetViewController
            targetSection?.delegate = self
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if calc.mortarXPos == 0 {
            midLabel.updateText(updatedText: " Awaiting mortar position input ")
            return
        } else if calc.targetXPos == 0 {
            midLabel.updateText(updatedText: " Awaiting target position input ")
            return
        }

        calculateCorrect()
    }

    // Notification from child view that target has been updated
    func correctionsTargetLocations() {
        calculateCorrect()
    }

    /* Very simmilar to calc function in CalculatorViewController.swift, only difference here is the distance/target position is updated
     prior to calculation */
    func calculateCorrect() {
        if !CalcFunctions().verify() {
            return
        }

        var correctedX: Double = calc.targetXPos
        var correctedY: Double = calc.targetYPos

        // Updates absolute position
        if northField.text!.count > 0 {
            correctedY += -Double(northField.text!)!
        }
        if eastField.text!.count > 0 {
            correctedX += Double(eastField.text!)!
        }
        if southField.text!.count > 0 {
            correctedY += Double(southField.text!)!
        }
        if westField.text!.count > 0 {
            correctedX += -Double(westField.text!)!
        }

        let correctedAzimuth = CalcFunctions().azimuth(targetX: correctedX, targetY: correctedY)
        var correctedDistance = CalcFunctions().distance(targetX: correctedX, targetY: correctedY)

        // Adds or subtracts to the distance
        if addField.text!.count > 0 {
            correctedDistance += Double(addField.text!)!
        }
        if subtractField.text!.count > 0 {
            correctedDistance += -Double(subtractField.text!)!
        }

        topLabel.updateText(updatedText: " Distance: \(Int(round(correctedDistance)))m ")

        if correctedDistance < 50 {
            midLabel.updateText(updatedText: " Target too close ")
            bottomLabel.text = ""
            return
        } else if correctedDistance > 1250 {
            midLabel.updateText(updatedText: " Target too far ")
            bottomLabel.text = ""
            return
        }

        let correctedRads = CalcFunctions().rads(distance: correctedDistance)
        midLabel.updateText(updatedText: " Azimuth: \(correctedAzimuth.rounded(toPlaces: 1))° ")
        bottomLabel.updateText(updatedText: " Milliradians: \(Int(round(correctedRads))) ")

    }

    // Recalculate whe adjustments are entered
    @IBAction func northFieldEnded(_ sender: Any) {
        calculateCorrect()
    }

    @IBAction func westFieldEnded(_ sender: Any) {
        calculateCorrect()
    }

    @IBAction func eastFieldEnded(_ sender: Any) {
        calculateCorrect()
    }

    @IBAction func southFieldEnded(_ sender: Any) {
        calculateCorrect()
    }

    @IBAction func addFieldEnded(_ sender: Any) {
        calculateCorrect()
    }

    @IBAction func subtractFieldEnded(_ sender: Any) {
        calculateCorrect()
    }

    // Clears all adjustment fields
    @IBAction func resetButton(_ sender: Any) {
        northField.text = ""
        eastField.text = ""
        southField.text = ""
        westField.text = ""
        addField.text = ""
        subtractField.text = ""
        calculateCorrect()
    }

}
