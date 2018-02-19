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
        
        midLabel.text = "Awaiting input"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    func mortarLocations() {
        calculate()
    }
    
    func targetLocations() {
        calculate()
    }
    
    func calculate() {
        if (!CalcFunctions().verify()) { return }
        calc.azimuth = CalcFunctions().azimuth(targetX: calc.targetXPos, targetY: calc.targetYPos)
        
        let distance = CalcFunctions().distance(targetX: calc.targetXPos, targetY: calc.targetYPos)
        topLabel.text = "Distance: \(Int(round(distance)))m"
        if (distance < 50) {
            midLabel.text = "Target too close"
            bottomLabel.text = ""
            return
        } else if (distance > 1250) {
            midLabel.text = "Target too far"
            bottomLabel.text = ""
            return
        }
        
        calc.rads = CalcFunctions().rads(distance: distance)
        midLabel.text = "Azimuth: \(calc.azimuth.rounded(toPlaces: 1))°"
        bottomLabel.text = "Milliradians: \(Int(round(calc.rads)))"
        
    }
}

