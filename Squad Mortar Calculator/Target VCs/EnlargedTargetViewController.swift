//
//  EnlargedTargetViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 11/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

protocol PassTargetLoc2 {
    func passTarget2(x: Double, y: Double)
}

class EnlargedTargetViewController: UIViewController, PassTargetLoc1 {
    var enlargedTargetGridViewController: EnlargedTargetGridViewController?
    var delegate: PassTargetLoc2?
    
    var targetSubgridXPos: Double = 100/6
    var targetSubgridYPos: Double = 100/6
    
    @IBAction func doneButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func centerButton(_ sender: Any) {
        enlargedTargetGridViewController!.center()
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
        if (segue.identifier == "embeddedEnlargedTargetGridSegue") {
            enlargedTargetGridViewController = (segue.destination as! EnlargedTargetGridViewController)
            enlargedTargetGridViewController!.targetSubgridXPos = targetSubgridXPos
            enlargedTargetGridViewController!.targetSubgridYPos = targetSubgridYPos
            enlargedTargetGridViewController!.delegate = self
        }
    }
    
    func passTarget1(x: Double, y: Double) {
        targetSubgridXPos = x
        targetSubgridYPos = y
        delegate!.passTarget2(x: x, y: y)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
