//
//  PrimaryViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 01/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, MortarLocations, TargetLocations {
    
    let calc = Calc.sharedInstance
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        midLabel.updateText(updatedText: " Awaiting input ")
    }
    
    // Declare self as a subview delegate so the view can be notified upon input
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "mortarSectionSegue") {
            let mortarSection = (segue.destination as! MortarViewController)
            mortarSection.delegate = self
        }
        if (segue.identifier == "targetSectionSegue") {
            let targetSection = (segue.destination as! TargetViewController)
            targetSection.delegate = self
        }
    }
    
    // Update results on view appearing (useful if target changes in other tabs)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calculate()
    }
    
    // Functions from protocol called from subviews upon input
    func mortarLocations() {
        calculate()
    }
    func targetLocations() {
        calculate()
    }
    
    // Calculate calibration and update results labels accordingly
    func calculate() {
        if (!CalcFunctions().verify()) { return }
        calc.azimuth = CalcFunctions().azimuth(targetX: calc.targetXPos, targetY: calc.targetYPos)
        
        let distance = CalcFunctions().distance(targetX: calc.targetXPos, targetY: calc.targetYPos)
        
        topLabel.updateText(updatedText: " Distance: \(Int(round(distance)))m ")
        if (distance < 50) {
            midLabel.updateText(updatedText: " Target too close ")
            bottomLabel.text = ""
            return
        } else if (distance > 1250) {
            midLabel.updateText(updatedText: " Target too far ")
            bottomLabel.text = ""
            return
        }
        
        calc.rads = CalcFunctions().rads(distance: distance)
        midLabel.updateText(updatedText: " Azimuth: \(calc.azimuth.rounded(toPlaces: 1))° ")
        bottomLabel.updateText(updatedText: " Milliradians: \(Int(round(calc.rads))) ")
        
    }
}

