//
//  calcFunctions.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 18/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import Foundation

class CalcFunctions {
    let calc = Calc.sharedInstance
    
    func verify() -> Bool {
        if (calc.mortarXPos == 0) { return false }
        if (calc.mortarYPos == 0) { return false }
        if (calc.targetXPos == 0) { return false }
        if (calc.targetYPos == 0) { return false }
        return true
    }
    
    func azimuth() -> String {
        return "success"
    }
}
