//
//  MortarViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 01/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

protocol MortarLocations {
    func mortarLocations()
}

class MortarViewController: UIViewController, UITextFieldDelegate, PassMortarLoc3 {
    
    var delegate: MortarLocations?
    let calc = Calc.sharedInstance
    var mortarSubgridXPos: Double = 100/6
    var mortarSubgridYPos: Double = 100/6

    // 3 fields and grid in Mortar view
    @IBOutlet weak var leftMortarField: CoordinatesTextField1!
    @IBOutlet weak var middleMortarField: CoordinatesTextField2!
    @IBOutlet weak var rightMortarField: CoordinatesTextField2!
    @IBOutlet weak var mortarGrid: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Allow keyboard to be dismissed via touching elsewhere on the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        leftMortarField.resignFirstResponder()
        middleMortarField.resignFirstResponder()
        rightMortarField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "embeddedMortarGridSegue") {
            let mortarGridViewController = (segue.destination as! MortarGridViewController)
            mortarGridViewController.delegate = self
        }
    }
    
    @IBAction func leftMortarFieldEnded(_ sender: Any) {
        updateMortar()
    }
    
    @IBAction func middleMortarFieldEnded(_ sender: Any) {
        updateMortar()
    }
    
    @IBAction func rightMortarFieldEnded(_ sender: Any) {
        updateMortar()
    }
    
    func passMortar3(x: Double, y: Double) {
        mortarSubgridXPos = x
        mortarSubgridYPos = y
        
        updateMortar()
    }
    
    func updateMortar() {
        if !checkMortarFields() { return }
        
        var mortarXPos:Double = 0
        var mortarYPos:Double = 0
        
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for letter in alphabet {
            if letter == leftMortarField.text!.uppercased()[0] {
                break
            }
            mortarXPos += 300
        }
        
        if (leftMortarField.text!.count == 2) {
            mortarYPos = (Double(String(leftMortarField.text![1]))! - 1) * 300
        } else {
            mortarYPos = Double(String(leftMortarField.text![1]))! * 3000
            mortarYPos = (Double(String(leftMortarField.text![2]))! - 1) * 300
        }
        
        switch Int(middleMortarField.text!)! {
        case 1: mortarYPos += 200
        case 2: mortarYPos += 200; mortarXPos += 100
        case 3: mortarYPos += 200; mortarXPos += 200
        case 4: mortarYPos += 100
        case 5: mortarYPos += 100; mortarXPos += 100
        case 6: mortarYPos += 100; mortarXPos += 200
        case 8: mortarXPos += 100
        case 9: mortarXPos += 200
        default: break
        }
        
        let increment:Double = 100/3
        switch Int(rightMortarField.text!)! {
        case 1: mortarYPos += increment * 2
        case 2: mortarYPos += increment * 2; mortarXPos += increment
        case 3: mortarYPos += increment * 2; mortarXPos += increment
        case 4: mortarYPos += increment
        case 5: mortarYPos += increment; mortarXPos += increment
        case 6: mortarYPos += increment; mortarXPos += increment * 2
        case 8: mortarXPos += increment
        case 9: mortarXPos += increment * 2
        default: break
        }
        
        mortarXPos += mortarSubgridXPos
        mortarYPos += mortarSubgridYPos
        
        calc.mortarXPos = mortarXPos
        calc.mortarYPos = mortarYPos
        delegate!.mortarLocations()
    }
    
    // Checks input in all text fields is of an acceptable format
    // Note: It should be impossible to input incorrect formats into the middle and right fields so may remove checks if performance
    // becomes a concern
    func checkMortarFields() -> Bool {
        // Check left field input
        if (leftMortarField.text == "") { return false }
        if !(leftMortarField.text!.count == 2 || leftMortarField.text!.count == 3) { rejectLeftMortarField(); return false }
        if !(leftMortarField.text![0].containedIn(matchCharacters: leftMortarField.acceptableFirstCharacters)) { rejectLeftMortarField(); return false }
        if !(leftMortarField.text![1].containedIn(matchCharacters: leftMortarField.acceptableSecondCharacters)) { rejectLeftMortarField(); return false }
        if (leftMortarField.text!.count == 3) {
            if !(leftMortarField.text![2].containedIn(matchCharacters: leftMortarField.acceptableSecondCharacters)) { rejectLeftMortarField(); return false }
            if (leftMortarField.text![1] == "0") { rejectLeftMortarField();return false }
        }
        if (leftMortarField.backgroundColor !== UIColor.white) { leftMortarField.backgroundColor = UIColor.white }
        
        // Check middle field
        if (middleMortarField.text == "") { return false }
        if !(middleMortarField.text?.count == 1) { rejectMiddleMortarField(); return false }
        if !((middleMortarField.text?.containsOnlyCharactersIn(matchCharacters: middleMortarField.allowedChars))!) { rejectMiddleMortarField(); return false }
        if (middleMortarField.backgroundColor !== UIColor.white) { middleMortarField.backgroundColor = UIColor.white }
        
        // Check right field
        if (rightMortarField.text == "") { return false }
        if !(rightMortarField.text?.count == 1) { rejectRightMortarField(); return false }
        if !((rightMortarField.text?.containsOnlyCharactersIn(matchCharacters: rightMortarField.allowedChars))!) { rejectRightMortarField(); return false }
        if (rightMortarField.backgroundColor !== UIColor.white) { rightMortarField.backgroundColor = UIColor.white }
        
        // All text fields good
        return true
    }
    
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
