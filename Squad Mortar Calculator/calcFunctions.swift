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
    
    func distance() -> Double {
        let deltaY = calc.mortarYPos - calc.targetYPos
        let deltaX = calc.targetXPos - calc.mortarXPos
        
        // Distance in meters
        return sqrt((deltaX * deltaX) + (deltaY * deltaY))
    }
    
    func rads(distance: Double) -> Double {
        var rads:Double = 1584.1 // const from 6th order
        
        /* 6th order polynomial to approximate distance -> milliradians, calculate 1 order
        at a time, interpolation by excel */
        rads += -0.0167 * distance
        rads += -0.003 * pow(distance, 2)
        rads += pow(10, -5) * pow(distance, 3)
        rads += -2 * pow(10, -8) * pow(distance, 4)
        rads += pow(10, -11) * pow(distance, 5)
        rads += -4 * pow(10, -15) * pow(distance, 6)

        return rads
    }
}
