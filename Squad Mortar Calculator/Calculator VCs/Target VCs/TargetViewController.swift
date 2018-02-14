//
//  TargetViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 11/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class TargetViewController: UIViewController, UITextFieldDelegate, PassTargetLoc3 {

    var targetSubgridXPos: Double = 100/6
    var targetSubgridYPos: Double = 100/6
    
    // 3 fields and grid in Target view
    @IBOutlet weak var leftTargetField: CoordinatesTextField1!
    @IBOutlet weak var middleTargetField: CoordinatesTextField2!
    @IBOutlet weak var rightTargetField: CoordinatesTextField2!
    @IBOutlet weak var targetGrid: UIView!
    
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
        leftTargetField.resignFirstResponder()
        middleTargetField.resignFirstResponder()
        rightTargetField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "embeddedTargetGridSegue") {
            let targetGridViewController = (segue.destination as! TargetGridViewController)
            targetGridViewController.delegate = self
        }
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
    
    
    func passTarget3(x: Double, y: Double) {
        targetSubgridXPos = x
        targetSubgridYPos = y
        
        updateTarget()
    }
    
    func updateTarget() {
        if !checkTargetFields() { return }
        
        // Insert code to pass up input to main level for calculation here
    }
    
    // Checks input in all text fields is of an acceptable format
    // Note: It should be impossible to input incorrect formats into the middle and right fields so may remove checks if performance
    // becomes a concern
    func checkTargetFields() -> Bool {
        // Check left field input
        if (leftTargetField.text == "") { return false }
        if !(leftTargetField.text!.count == 2 || leftTargetField.text!.count == 3) { rejectLeftTargetField(); return false }
        if !(leftTargetField.text![0].containedIn(matchCharacters: leftTargetField.acceptableFirstCharacters)) { rejectLeftTargetField(); return false }
        if !(leftTargetField.text![1].containedIn(matchCharacters: leftTargetField.acceptableSecondCharacters)) { rejectLeftTargetField(); return false }
        if (leftTargetField.text!.count == 3) {
            if !(leftTargetField.text![2].containedIn(matchCharacters: leftTargetField.acceptableSecondCharacters)) { rejectLeftTargetField(); return false }
        }
        if (leftTargetField.backgroundColor !== UIColor.white) { leftTargetField.backgroundColor = UIColor.white }
        
        // Check middle field
        if (middleTargetField.text == "") { return false }
        if !(middleTargetField.text?.count == 1) { rejectMiddleTargetField(); return false }
        if !((middleTargetField.text?.containsOnlyCharactersIn(matchCharacters: middleTargetField.allowedChars))!) { rejectMiddleTargetField(); return false }
        if (middleTargetField.backgroundColor !== UIColor.white) { middleTargetField.backgroundColor = UIColor.white }
        
        // Check right field
        if (rightTargetField.text == "") { return false }
        if !(rightTargetField.text?.count == 1) { rejectRightTargetField(); return false }
        if !((rightTargetField.text?.containsOnlyCharactersIn(matchCharacters: rightTargetField.allowedChars))!) { rejectRightTargetField(); return false }
        if (rightTargetField.backgroundColor !== UIColor.white) { rightTargetField.backgroundColor = UIColor.white }
        
        // All text fields good
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
