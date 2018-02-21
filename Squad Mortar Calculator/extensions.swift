//
//  extensions.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 18/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension String {
    
    // Returns true if the string contains only characters found in matchCharacters.
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = NSCharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    
    // Allows reference such as "STRING"[2] == R
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

extension Character {
    // Returns true if the string contains only characters found in matchCharacters.
    func containedIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = NSCharacterSet(charactersIn: matchCharacters).inverted
        return String(self).rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
}

extension UILabel {
    func animateTo(text: String, duration: Double) {
        if !(text == self.text!) {
            UIView.animate(
                withDuration: (duration / 2),
                animations: {
                    self.alpha = 0
            },
                completion:{ finished in
                    if(finished){
                        self.text = text
                        UIView.animate(
                            withDuration: (duration / 2),
                            animations: {
                                self.alpha = 1
                        },
                            completion: nil
                        )
                    }
            }
            )
        }
    }
    
    func updateText(updatedText: String) {
        self.text = updatedText
        if !(self.text!.count > 0) { return }
        var size: CGSize = self.text!.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: self.bounds.height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: self.font], context: nil).size
        
        if (size.width > self.bounds.width) {
            while size.width > self.bounds.width {
                self.font = self.font.withSize(self.font.pointSize - 1)
                size = (self.text?.boundingRect(
                    with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: self.bounds.height),
                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                    attributes: [NSAttributedStringKey.font: self.font],
                    context: nil).size)!
                
                self.setNeedsLayout()
            }
        }
        else {
            while size.width < self.bounds.width {
                self.font = self.font.withSize(self.font.pointSize + 1)
                size = (self.text?.boundingRect(
                    with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: self.bounds.height),
                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                    attributes: [NSAttributedStringKey.font: self.font],
                    context: nil).size)!
                
                self.setNeedsLayout()
            }
        }
    }
}

