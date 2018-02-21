//
//  CorrectionsViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 19/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (calc.mortarXPos == 0) {
            midLabel.updateText(updatedText: " Awaiting mortar position input ")
            return
        } else if (calc.targetXPos == 0) {
            midLabel.updateText(updatedText: " Awaiting target position input ")
            return
        }
        
        calculateCorrect()
    }
    
    func correctionsTargetLocations() {
        calculateCorrect()
    }
    
    func calculateCorrect() {
        if (!CalcFunctions().verify()) { return }
        
        var correctedX: Double = calc.targetXPos
        var correctedY: Double = calc.targetYPos
        
        // Remember y coodinates are reversed
        if (northField.text!.count > 0) {
            correctedY += -Double(northField.text!)!
        }
        if (eastField.text!.count > 0) {
            correctedX += Double(eastField.text!)!
        }
        if (southField.text!.count > 0) {
            correctedY += Double(southField.text!)!
        }
        if (westField.text!.count > 0) {
            correctedX += -Double(westField.text!)!
        }
        
        let correctedAzimuth = CalcFunctions().azimuth(targetX: correctedX, targetY: correctedY)
        
        var correctedDistance = CalcFunctions().distance(targetX: correctedX, targetY: correctedY)
        if (addField.text!.count > 0) {
            correctedDistance += Double(addField.text!)!
        }
        if (subtractField.text!.count > 0) {
            correctedDistance += -Double(subtractField.text!)!
        }
        
        topLabel.updateText(updatedText: " Distance: \(Int(round(correctedDistance)))m ")
        if (correctedDistance < 50) {
            midLabel.updateText(updatedText: " Target too close ")
            bottomLabel.text = ""
            return
        } else if (correctedDistance > 1250) {
            midLabel.updateText(updatedText: " Target too far ")
            bottomLabel.text = ""
            return
        }
        
        let correctedRads = CalcFunctions().rads(distance: correctedDistance)
        midLabel.updateText(updatedText: " Azimuth: \(correctedAzimuth.rounded(toPlaces: 1))° ")
        bottomLabel.updateText(updatedText: " Milliradians: \(Int(round(correctedRads))) ")
        
    }
    
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
