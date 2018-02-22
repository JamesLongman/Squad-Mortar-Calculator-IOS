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
    
    // Returns true if valid values have been inputted
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
    func azimuth(targetX: Double, targetY: Double) -> Double {
        let deltaY = calc.mortarYPos - targetY
        let deltaX = targetX - calc.mortarXPos
        let tanAngle = atan2(deltaY, deltaX) * 180 / Double.pi
        
        var angle:Double = 0
        if (tanAngle < 90) {
            angle = 90 - tanAngle
        } else if (tanAngle <= 180) {
            angle = 450 - tanAngle
        }
        
        return angle
    }
    
    // Simple trig to calculate distance to target
    func distance(targetX: Double, targetY: Double) -> Double {
        let deltaY = calc.mortarYPos - targetY
        let deltaX = targetX - calc.mortarXPos
        
        // Distance in meters
        return sqrt((deltaX * deltaX) + (deltaY * deltaY))
    }
    
    // Returns milli-rads calibration to reach a certain distance
    func rads(distance: Double) -> Double {
        var rads:Double = 1603.9273942850821 // const from polynomial
        
        /* 12th order polynomial regression formula to approximate rads -> milliradians
        Interpolation provided by arachnoid.com/polysolve
        Higher orders than 12 offer extremely diminished returns
        Correlation coefficiant = 0.9999994 */
        rads += -5.8438295306148713 * pow(10, -1) * distance
        rads += 2.3978428325334847 * pow(10, -3) * pow(distance, 2)
        rads += -1.6710022368637173 * pow(10, -5) * pow(distance, 3)
        rads += 6.8176342659639214 * pow(10, -8) * pow(distance, 4)
        rads += -1.7561870164951840 * pow(10, -10) * pow(distance, 5)
        rads += 2.7973321639240712 * pow(10, -13) * pow(distance, 6)
        rads += -2.2893211828988827 * pow(10, -16) * pow(distance, 7)
        rads += -2.7848767129442064 * pow(10, -20) * pow(distance, 8)
        rads += 2.7355539358279937 * pow(10, -22) * pow(distance, 9)
        rads += -2.8038885580479877 * pow(10, -25) * pow(distance, 10)
        rads += 1.2940370170642232 * pow(10, -28) * pow(distance, 11)
        rads += -2.3669421263783761 * pow(10, -32) * pow(distance, 12)

        return rads
    }
}
