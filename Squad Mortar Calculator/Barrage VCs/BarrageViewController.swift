//
//  BarrageViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 19/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit


class BarrageViewController: UIViewController, BarrageTargetLocations {
    
    // Radius and Interval input sections
    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var intervalSlider: UISlider!
    
    // Timing section
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var leftTimingView: UIView!
    
    // Results section
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var timer = Timer()
    var timerIsOn = false
    var timeRemaining:Int = 10
    
    let calc = Calc.sharedInstance
    
    let shapeLayer = CAShapeLayer()
    let animationDuration = 0.4
    
    // Upon view loading, configure track for timing animation
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var timerRadius:CGFloat = 0
        if (leftTimingView.frame.size.width > leftTimingView.frame.size.height) {
            timerRadius = (leftTimingView.frame.size.height/2) - 20
        } else {
            timerRadius = (leftTimingView.frame.size.width/2) - 20
        }
        
        let circularPath = UIBezierPath(arcCenter: leftTimingView.center, radius: timerRadius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.gray.cgColor
        trackLayer.lineWidth = timerRadius / 10
        trackLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.lineWidth = timerRadius / 10
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        leftTimingView.layer.addSublayer(trackLayer)
        leftTimingView.layer.addSublayer(shapeLayer)
        
        timerLabel.center = leftTimingView.center
    }
    
    // Set self as a delegate of child for updates upon target input
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "targetBarrageSectionSegue") {
            let targetSection = (segue.destination as! BarrageTargetViewController)
            targetSection.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // If no mortar input data inform user
        if (calc.mortarXPos == 0) {
            midLabel.updateText(updatedText: " Awaiting mortar position input ")
            return
        // If no target input data inform target
        } else if (calc.targetXPos == 0) {
            midLabel.updateText(updatedText: " Awaiting target position input ")
            return
        }
        
        // If there is input data, but the middle label has not been updated since there wasn't, clear it
        if (midLabel.text == " Awaiting target position input ") {
            midLabel.text = ""
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        timerIsOn = false
    }
    
    // Called from child view, notification that new target values have been inputted
    func barrageTargetLocations() {
        calculate()
    }
    
    // Checks input values is good, then calculates a point to barrage within specified parameters
    func calculate() {
        if (!CalcFunctions().verify()) { return }
        calc.azimuth = CalcFunctions().azimuth(targetX: calc.targetXPos, targetY: calc.targetYPos)
        
        // Calculate distance of center barrage point
        var distance = CalcFunctions().distance(targetX: calc.targetXPos, targetY: calc.targetYPos)
        if (distance < 50) {
            topLabel.updateText(updatedText: " Distance to barrage center: \(Int(round(distance)))m ")
            midLabel.updateText(updatedText: " Target too close ")
            bottomLabel.text = ""
            return
        } else if (distance > 1250) {
            topLabel.updateText(updatedText: " Distance to barrage center: \(Int(round(distance)))m ")
            midLabel.updateText(updatedText: " Target too far ")
            bottomLabel.text = ""
            return
        }
        
        /* First generate a random x value between min and max radius, then calc max and
         min y for that x using pythagoras and generate random y between those, method
         gives equal weight to all points in radius */
        var radius = Double(round(radiusSlider.value))
        var barrageX = randomDouble(min: (calc.targetXPos - radius), max: (calc.targetXPos + radius))
        var yTollerance = (radius * radius) - ((calc.targetXPos - barrageX) * (calc.targetXPos - barrageX))
        var barrageY = randomDouble(min: (calc.targetYPos - yTollerance), max: (calc.targetYPos + yTollerance))
        distance = CalcFunctions().distance(targetX: barrageX, targetY: barrageY)
        
        /* In the unlikely event the barrage point falls outside of the mortar's range recalculate, (this will never
         happen more than about half the time when the center point is at the edge of the mortar's range) */
        while(distance > 1250 || distance < 50) {
            radius = Double(round(radiusSlider.value))
            barrageX = randomDouble(min: (calc.targetXPos - radius), max: (calc.targetXPos + radius))
            yTollerance = (radius * radius) - ((calc.targetXPos - barrageX) * (calc.targetXPos - barrageX))
            barrageY = randomDouble(min: (calc.targetYPos - yTollerance), max: (calc.targetYPos + yTollerance))
            distance = CalcFunctions().distance(targetX: barrageX, targetY: barrageY)
        }
        
        // Update labels with results
        topLabel.updateText(updatedText: " Distance to barrage point: \(Int(round(distance)))m ")
        midLabel.updateText(updatedText: " Azimuth: \(CalcFunctions().azimuth(targetX: barrageX, targetY: barrageY).rounded(toPlaces: 1))° ")
        bottomLabel.updateText(updatedText: " Milliradians: \(Int(round(CalcFunctions().rads(distance: distance)))) ")
        
    }
    
    // Update slider feedback labels when sliders are moved
    @IBAction func radiusSliderChanged(_ sender: Any) {
        radiusLabel.text = "\(Int(round(radiusSlider.value)))m"
    }
    @IBAction func intervalSliderChanged(_ sender: Any) {
        intervalLabel.text = "\(Int(round(intervalSlider.value)))s"
    }
    
    // When the start or stop button is pressed (same button, changes function)
    @IBAction func startStopButtonPressed(_ sender: Any) {
        if (timerIsOn == false) {
            timeRemaining = Int(round(intervalSlider.value))
            timerLabel.animateTo(text: "\(timeRemaining)", duration: animationDuration)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
            timerIsOn = true
            shapeLayer.isHidden = false
            startStopButton.setTitle("Stop", for: .normal)
            calculate()
            timerAnimation()
        } else {
            timer.invalidate()
            timerIsOn = false
            shapeLayer.isHidden = true
            startStopButton.setTitle("Start", for: .normal)
            timeRemaining = Int(round(intervalSlider.value))
            timerLabel.animateTo(text: "\(timeRemaining)", duration: animationDuration)
            
        }
    }
    
    // Skips to next target, provides target if timer not active
    @IBAction func nextTargetButtonPressed(_ sender: Any) {
        if (timerIsOn) {
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
        }
        timeRemaining = Int(round(intervalSlider.value))
        if (timerIsOn) {
            timerAnimation()
        } else {
            shapeLayer.isHidden = true
        }
        timerLabel.animateTo(text: "\(timeRemaining)", duration: animationDuration)
        calculate()
    }
    
    // Objective C function, called every second, ObjC neccesary for timer functions as support not yet included in swift
    @objc func timerRunning() {
        if (timeRemaining > 1) {
            timeRemaining -= 1
            timerLabel.animateTo(text: "\(timeRemaining)", duration: animationDuration)
        } else {
            timeRemaining = Int(round(intervalSlider.value))
            timerLabel.animateTo(text: "\(timeRemaining)", duration: animationDuration)
            timerAnimation()
            calculate()
        }
    }
    
    // Returns a random double in specified range
    func randomDouble(min: Double, max: Double) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    
    // Animation of timer, makes circle over track in duration of interval
    func timerAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        basicAnimation.duration = Double(round(intervalSlider.value)) + 2
        shapeLayer.add(basicAnimation, forKey: "timeCircle")
    }
}
