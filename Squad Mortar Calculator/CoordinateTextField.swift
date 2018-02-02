//
//  CoordinateTextField.swift
//  Squad Mortar Calculator
//
//

import UIKit

//  ===============================================
//  This section of code was primarily written by
//  Joey Devilla as shown on globalnerdy.com

class MaxLengthTextField: UITextField, UITextFieldDelegate {
    private var characterLimit: Int?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
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
        return prospectiveText.count <= maxLength
    }
//  ===============================================
    
    
    // Allow keyboard to be dismissed via return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
