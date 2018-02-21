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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "targetBarrageSectionSegue") {
            let targetSection = (segue.destination as! BarrageTargetViewController)
            targetSection.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (calc.mortarXPos == 0) {
            midLabel.text = "Awaiting mortar position input"
            return
        } else if (calc.targetXPos == 0) {
            midLabel.text = "Awaiting target position input"
            return
        }
        
        if (midLabel.text == "Awaiting target position input") {
            midLabel.text = ""
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        timerIsOn = false
    }
    
    func barrageTargetLocations() {
        calculate()
    }
    
    func calculate() {
        if (!CalcFunctions().verify()) { return }
        calc.azimuth = CalcFunctions().azimuth(targetX: calc.targetXPos, targetY: calc.targetYPos)
        
        var distance = CalcFunctions().distance(targetX: calc.targetXPos, targetY: calc.targetYPos)
        if (distance < 50) {
            topLabel.text = "Distance to barrage center: \(Int(round(distance)))m"
            midLabel.text = "Target too close"
            bottomLabel.text = ""
            return
        } else if (distance > 1250) {
            topLabel.text = "Distance to barrage center: \(Int(round(distance)))m"
            midLabel.text = "Target too far"
            bottomLabel.text = ""
            return
        }
        
        /* First generate a random x value between min and max radius, then calc max and
         min y for that x using pythagoras and generate random y between those, method
         gives equal weight to all points in radius */
        let radius = Double(round(radiusSlider.value))
        let barrageX = randomDouble(min: (calc.targetXPos - radius), max: (calc.targetXPos + radius))
        let yTollerance = (radius * radius) - ((calc.targetXPos - barrageX) * (calc.targetXPos - barrageX))
        let barrageY = randomDouble(min: (calc.targetYPos - yTollerance), max: (calc.targetYPos + yTollerance))
        
        distance = CalcFunctions().distance(targetX: barrageX, targetY: barrageY)
        topLabel.text = "Distance to target point: \(Int(round(distance)))m"
        midLabel.text = "Azimuth: \(CalcFunctions().azimuth(targetX: barrageX, targetY: barrageY).rounded(toPlaces: 1))°"
        bottomLabel.text = "Milliradians: \(Int(round(CalcFunctions().rads(distance: distance))))"
        
    }
    
    @IBAction func radiusSliderChanged(_ sender: Any) {
        radiusLabel.text = "\(Int(round(radiusSlider.value)))m"
    }
 
    @IBAction func intervalSliderChanged(_ sender: Any) {
        intervalLabel.text = "\(Int(round(intervalSlider.value)))s"
    }
    
    @IBAction func startStopButtonPressed(_ sender: Any) {
        if (timerIsOn == false) {
            timeRemaining = Int(round(intervalSlider.value))
            timerLabel.text = "\(timeRemaining)"
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
            timerLabel.text = "\(timeRemaining)"
            
        }
    }
    
    @IBAction func nextTargetButtonPressed(_ sender: Any) {
        if (timerIsOn) {
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
        }
        timeRemaining = Int(round(intervalSlider.value))
        timerLabel.text = "\(timeRemaining)"
        timerAnimation()
        calculate()
    }
    
    @objc func timerRunning() {
        if (timeRemaining > 1) {
            timeRemaining -= 1
            timerLabel.text = "\(timeRemaining)"
        } else {
            timeRemaining = Int(round(intervalSlider.value))
            timerLabel.text = "\(timeRemaining)"
            timerAnimation()
            calculate()
        }
    }
    
    func randomDouble(min: Double, max: Double) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    
    func timerAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        basicAnimation.duration = Double(round(intervalSlider.value)) + 2
        shapeLayer.add(basicAnimation, forKey: "timeCircle")
    }
}
