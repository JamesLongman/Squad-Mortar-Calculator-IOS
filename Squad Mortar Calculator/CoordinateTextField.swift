//
//  CoordinateTextField.swift
//  Squad Mortar Calculator
//  This section of code was primarily written by
//  Joey Devilla as shown on globalnerdy.com

import UIKit

class CoordinatesTextField: UITextField, UITextFieldDelegate {
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

extension String {
    
    // Returns true if the string contains only characters found in matchCharacters.
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = NSCharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    
}
