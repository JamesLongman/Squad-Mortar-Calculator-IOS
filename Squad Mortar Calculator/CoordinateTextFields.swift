//
//  CoordinateTextField.swift
//  Squad Mortar Calculator
//  This section of code was primarily written by
//  Joey Devilla as shown on globalnerdy.com

import UIKit

// Designed ot be configurable to accept a letter from a-Z as the first character and a number from 1-9 as the second
class CoordinatesTextField1: UITextField, UITextFieldDelegate {
    private var characterLimit: Int?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        autocorrectionType = .no
    }
    
    @IBInspectable var acceptableFirstCharacters: String = ""
    @IBInspectable var acceptableSecondCharacters: String = ""
    @IBInspectable var maxLength: Int {
        get {
            guard let length = characterLimit else {
                return Int.max
            }
            return length
        } set {
            characterLimit = newValue
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard string.count > 0 else {
            return true
        }
        
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if prospectiveText.count > maxLength { return false }
        if prospectiveText.count == 1 && !(prospectiveText[0].containedIn(matchCharacters: acceptableFirstCharacters)) { return false }
        if prospectiveText.count > 1 && !(prospectiveText[1].containedIn(matchCharacters: acceptableSecondCharacters)) { return false }
        if prospectiveText.count > 2 && !(prospectiveText[2].containedIn(matchCharacters: acceptableSecondCharacters)) { return false }
        return true
    }
    
    
    // Allow keyboard to be dismissed via return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


/*  Designed to be configurable to accept an input of one number from 1-9
    Note: Unlike the first field these restrictions are not "fool proof", it would be
    difficult but possible for a user to accidently input an invalid string so a further
    check is needed before the input is used
 */
class CoordinatesTextField2: UITextField, UITextFieldDelegate {
    private var characterLimit: Int?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        autocorrectionType = .no
    }
    
    @IBInspectable var allowedChars: String = ""
    @IBInspectable var maxLength: Int {
        get {
            guard let length = characterLimit else {
                    return Int.max
            }
            return length
        } set {
            characterLimit = newValue
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard string.count > 0 else {
            return true
        }
        
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return prospectiveText.count <= maxLength && prospectiveText.containsOnlyCharactersIn(matchCharacters: allowedChars)
    }
    
    
    // Allow keyboard to be dismissed via return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
