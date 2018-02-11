//
//  MortarViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 01/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class MortarViewController: UIViewController, UITextFieldDelegate, PassMortarLoc3 {
    
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
        if !checkFields() { return }
        
        // Insert code to pass up input to main level for calculation here
    }
    
    // Checks input in all text fields is of an acceptable format
    // Note: It should be impossible to input incorrect formats into the middle and right fields so may remove checks if performance
    // becomes a concern
    func checkFields() -> Bool {
        // Check left field input
        if (leftMortarField.text == "") { return false }
        if !(leftMortarField.text!.count == 2) { rejectLeftField(); return false }
        if !(leftMortarField.text![0].containedIn(matchCharacters: leftMortarField.acceptableFirstCharacters)) { rejectLeftField(); return false }
        if !(leftMortarField.text![1].containedIn(matchCharacters: leftMortarField.acceptableSecondCharacters)) { rejectLeftField(); return false }
        if (leftMortarField.backgroundColor !== UIColor.white) { leftMortarField.backgroundColor = UIColor.white }
        
        // Check middle field
        if (middleMortarField.text == "") { return false }
        if !(middleMortarField.text?.count == 1) { rejectMiddleField(); return false }
        if !((middleMortarField.text?.containsOnlyCharactersIn(matchCharacters: middleMortarField.allowedChars))!) { rejectMiddleField(); return false }
        if (middleMortarField.backgroundColor !== UIColor.white) { middleMortarField.backgroundColor = UIColor.white }
        
        // Check right field
        if (rightMortarField.text == "") { return false }
        if !(rightMortarField.text?.count == 1) { rejectRightField(); return false }
        if !((rightMortarField.text?.containsOnlyCharactersIn(matchCharacters: rightMortarField.allowedChars))!) { rejectRightField(); return false }
        if (rightMortarField.backgroundColor !== UIColor.white) { rightMortarField.backgroundColor = UIColor.white }
        
        // All text fields good
        return true
    }
    
    func rejectLeftField() {
        leftMortarField.backgroundColor = UIColor.red
    }
    
    func rejectMiddleField() {
        middleMortarField.backgroundColor = UIColor.red
    }
    
    func rejectRightField() {
        rightMortarField.backgroundColor = UIColor.red
    }
}
