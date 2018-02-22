//
//  calcValues.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 18/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import Foundation

/* James: Singleton to store calculator values that need to be shared between views. Singletons (effectively global variables) are somewhat
 of a tabboo in programming however any alternative data passing for the project seemed far more complex. The notification chains served for
 data passing in a tab, but passing data between tabs seemed nearly impossible without some form of global variable */
class Calc {
    static let sharedInstance = Calc()
    func network() {}
    private init() {}
    
    // Has the calculator recieved valid input
    var input:Bool = false
    
    // Absolute map values in meters, y inverted
    var mortarXPos:Double = 0
    var mortarYPos:Double = 0
    var targetXPos:Double = 0
    var targetYPos:Double = 0
    
    // Most recent calculated values (obviously not from a tab such as barrage)
    var azimuth:Double = 0
    var rads: Double = 0
    
    // Subgrid position values in meters
    var mortarSubgridXPos: Double = 100/6
    var mortarSubgridYPos: Double = 100/6
    var targetSubgridXPos: Double = 100/6
    var targetSubgridYPos: Double = 100/6
    
    /* Strings to hold the input into target fields, such as "A13", this isn't strictly neccesary to be included in the singleton
     but the alternative would be a complex calculation to work out the fields from the most recent absolute positional input so the
     values are stored for simplicity's sake*/
    var targetLeftField: String = ""
    var targetMidField: String = ""
    var targetRightField: String = ""
}
