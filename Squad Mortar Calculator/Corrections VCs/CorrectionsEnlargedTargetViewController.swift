//
//  CorrectionsEnlargedTargetViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 19/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

protocol PassCorrectionsTargetLoc2 {
    func passCorrectionsTarget2(x: Double, y: Double)
}

class CorrectionsEnlargedTargetViewController: UIViewController, PassCorrectionsTargetLoc1 {

    var correctionsEnlargedTargetGridViewController: CorrectionsEnlargedTargetGridViewController?
    var delegate: PassCorrectionsTargetLoc2?
    
    var targetSubgridXPos: Double = 100/6
    var targetSubgridYPos: Double = 100/6
    
    @IBAction func doneButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func centerButton(_ sender: Any) {
        correctionsEnlargedTargetGridViewController!.center()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "embeddedEnlargedCorrectionsTargetGridSegue") {
            correctionsEnlargedTargetGridViewController = (segue.destination as! CorrectionsEnlargedTargetGridViewController)
            correctionsEnlargedTargetGridViewController!.targetSubgridXPos = targetSubgridXPos
            correctionsEnlargedTargetGridViewController!.targetSubgridYPos = targetSubgridYPos
            correctionsEnlargedTargetGridViewController!.delegate = self
        }
    }
    
    func passCorrectionsTarget1(x: Double, y: Double) {
        targetSubgridXPos = x
        targetSubgridYPos = y
        delegate!.passCorrectionsTarget2(x: x, y: y)
    }

}
