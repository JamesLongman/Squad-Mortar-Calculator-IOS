//
//  CoordinateTextField.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 01/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

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
}
