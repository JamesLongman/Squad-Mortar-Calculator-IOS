//
//  GuideViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 13/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    @IBOutlet weak var section1: UILabel!
    @IBOutlet weak var section2: UILabel!
    @IBOutlet weak var section3: UILabel!
    @IBOutlet weak var section4: UILabel!
    @IBOutlet weak var section5: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        section1.text! = "Using the calculator is really simple. Basically you just need to enter the position of your mortars and the position that you want to target."
        section1.text! += "\n\n"
        section1.text! += "The results of the calculation will give you 3 values:"
        section1.text! += "\n\nDistance: The range to your target in meters (not necessary for mortars)"
        section1.text! += "\n\nAzimuth: The angle (left to right) in degrees which you much adjust your mortars to"
        section1.text! += "\n\nMilliradians: The are the angle (up and down) that you must adjust your mortars to (right click whilst on a mortar to see your current adjustment)"

        section2.text! = "The calculator simply provides the calibration to hit any target within range of your mortars."
        section2.text! += "\n\nYou must input your mortar position in this tab regardless of what tab you are using (Remember to update this if you move your mortars)"
        section2.text! += "\n\nThe input is of the form A1-1-1 in line with the games co-ordinate system (you can mouse over any point on the map to see its position if this confuses you)"
        section2.text! += "\n\nFor added accuracy it is important to set your sub-grid position. As the smallest grids the game provides are 33m wide. Do this by tapping the box to the right of the coordinate fields and moving the green dot representing a position within the grid"

        section3.text! = "While calculators for Squad mortars tend to be very accurate (this one is accurate to ±1 meter!) there are two main factors that cause mortars to often miss by a bit more than this"
        section3.text! += "\n\n1. User Error: This is the main cause of mortars missing, estimates of map positions always come with some degree of error. Particularly at longer ranges."
        section3.text! += "\n\n2. Altitude Differences: Unfortunately the formula can only account for differences in the X and Y planes. Though this isn't as much of a problem as you might think as mortars tend to drop quite steeply, so large differences in altitude often only cause small differences in XY position. The effect is greater at larger ranges though as mortars begin to drop shallower."
        section3.text! += "\n\nIf you know your mortars are missing your target and wish to adjust to hit a target precisely you can use the corrections tab for this. On this tab you can input corrections to move your target a certain distance North, East, South or West. There is also the option to simply add or subtract a certain distance from your ranging. Remember all input is in meters and you can use a combination of all the fields to adjust your targeting however you require"

        section4.text! = "The Barrage tab is a nice feature to assist you in spreading out your fire over a larger area. The Barrage tab will provide you calibrations to random points within your barrage area."
        section4.text! += "\n\nFirstly make sure that your target is set to the center of the area you wish to barrage. Then set the radius of your bombardment using the slider."
        section4.text! += "\n\nYou can now either receive targets by tapping next target, or you can receive regular targets by setting a time interval and tapping start"

        section5.text! = "•Be sure that you use the interface to input subgrid positions, the smallest grids are 1089m²!"
        section5.text! += "\n\n•If you're calling out calibrations to your squad make sure they know you're giving them ranges in milliradians and not meters"
        section5.text! += "\n\n•Barrages can be even more effective if you alternate targets between mortars. For example: \"Mortar 1, (target)\"... 5 seconds ... \"Mortar2, (target)\""
        section5.text! += "\n\n•Enemy HABs are your #1 target, hit them as precisely and with as much ordinance as possible (FOB Radios are too small a target, leave them to the infantry)"
        section5.text! += "\n\n•Please remember to mark your mortar targets with IDF markers, especially if you're targeting positions close to team-mates. You can also use team chat to remind your team not to go near IDF marks"
        section5.text! += "\n\n•Mortar travel time is about 20 seconds, when team-mates ask you to stop shooting make sure they know there are probably a few more volleys in the air"
    }

}
