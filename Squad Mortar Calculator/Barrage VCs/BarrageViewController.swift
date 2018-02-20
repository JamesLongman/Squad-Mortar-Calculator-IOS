//
//  BarrageViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 19/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class BarrageViewController: UIViewController, BarrageTargetLocations {
    
    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var intervalSlider: UISlider!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var timer = Timer()
    var timerIsOn = false
    var timeRemaining:Int = 10
    
    let calc = Calc.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
            timerIsOn = true
            startStopButton.setTitle("Stop", for: .normal)
        } else {
            timer.invalidate()
            timerIsOn = false
            startStopButton.setTitle("Start", for: .normal)
        }
    }
    
    @IBAction func nextTargetButtonPressed(_ sender: Any) {
        if (timerIsOn) {
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
        }
        timeRemaining = Int(round(intervalSlider.value))
        timerLabel.text = "\(timeRemaining)"
        calculate()
    }
    
    @objc func timerRunning() {
        if (timeRemaining > 1) {
            timeRemaining -= 1
            timerLabel.text = "\(timeRemaining)"
        } else {
            timeRemaining = Int(round(intervalSlider.value))
            timerLabel.text = "\(timeRemaining)"
            calculate()
        }
    }
    
    func randomDouble(min: Double, max: Double) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
}
