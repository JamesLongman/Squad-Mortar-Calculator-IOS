//
//  CorrectionsFields.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 19/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import Foundation

class CorrectionsField: UITextField, UITextFieldDelegate {
    private var characterLimit: Int?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        autocorrectionType = .no
    }

    @IBInspectable var acceptableCharacters: String = ""
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
