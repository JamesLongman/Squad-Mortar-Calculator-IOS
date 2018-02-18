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
    }
}

