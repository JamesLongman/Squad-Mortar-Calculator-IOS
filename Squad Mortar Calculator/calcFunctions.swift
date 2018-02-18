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
        if (calc.input) { return true }
        if (calc.mortarXPos == 0) { return false }
        if (calc.mortarYPos == 0) { return false }
        if (calc.targetXPos == 0) { return false }
        if (calc.targetYPos == 0) { return false }
        calc.input = true
        return true
    }
    
    /* Returns azimuth to target as double from euclidian input, math may appear odd
    becuase y co-odinates are effectively upside down */
    func azimuth() -> Double {
        let deltaY = calc.mortarYPos - calc.targetYPos
        let deltaX = calc.targetXPos - calc.mortarXPos
        let tanAngle = atan2(deltaY, deltaX) * 180 / Double.pi
        
        var angle:Double = 0
        if (tanAngle < 90) {
            angle = 90 - tanAngle
        } else if (tanAngle <= 180) {
            angle = 450 - tanAngle
        }
        
        return angle
    }
}
