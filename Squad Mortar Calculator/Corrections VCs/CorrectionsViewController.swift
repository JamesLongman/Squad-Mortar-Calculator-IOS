//
//  CorrectionsViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 19/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class CorrectionsViewController: UIViewController, CorrectionsTargetLocations {
    
    let calc = Calc.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "targetCorrectionsSectionSegue") {
            let targetSection = (segue.destination as! CorrectionsTargetViewController)
            targetSection.delegate = self
        }
    }
    
    func correctionsTargetLocations() {
        calculate()
    }
    
    func calculate() {
        if (!CalcFunctions().verify()) { return }
        calc.azimuth = CalcFunctions().azimuth()
        
        let distance = CalcFunctions().distance()
        //topLabel.text = "Distance: \(Int(round(distance)))m"
        if (distance < 50) {
            //midLabel.text = "Target too close"
            //bottomLabel.text = ""
            return
        } else if (distance > 1250) {
            //midLabel.text = "Target too far"
            //bottomLabel.text = ""
            return
        }
        
        calc.rads = CalcFunctions().rads(distance: distance)
        //midLabel.text = "Azimuth: \(calc.azimuth.rounded(toPlaces: 1))°"
        //bottomLabel.text = "Milliradians: \(Int(round(calc.rads)))"
        
    }
}
