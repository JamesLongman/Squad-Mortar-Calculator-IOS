//
//  CorrectionsEnlargedTargetGridViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 19/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

/* For comments please see mortar VCs counterpart */

import UIKit

protocol PassCorrectionsTargetLoc1 {
    func passCorrectionsTarget1()
}


class CorrectionsEnlargedTargetGridViewController: UIViewController {
    
    let calc = Calc.sharedInstance
    var delegate: PassCorrectionsTargetLoc1?
    
    @IBOutlet weak var targetPin: UIImageView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch! = touches.first! as UITouch
        updatePosition(position: touch.location(in: self.view))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch : UITouch! = touches.first! as UITouch
        let candidatePosition = touch.location(in: self.view)
        if self.view.point(inside: candidatePosition, with: event) {
            updatePosition(position: candidatePosition)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let xPoint = ((calc.targetSubgridXPos * Double(self.view!.bounds.width)) / (100/3))
        let yPoint = ((calc.targetSubgridYPos * Double(self.view!.bounds.height)) / (100/3))
        targetPin.center = CGPoint(x: xPoint, y: yPoint)
    }
    
    func center() {
        updatePosition(position: CGPoint(x: self.view!.bounds.width/2, y: self.view!.bounds.height/2))
    }
    
    func updatePosition(position: CGPoint) {
        targetPin.center = position
        
        calc.targetSubgridXPos = Double(position.x / self.view!.bounds.width) * (100/3)
        calc.targetSubgridYPos = Double(position.y / self.view!.bounds.height) * (100/3)
        
        delegate!.passCorrectionsTarget1()
    }

}
