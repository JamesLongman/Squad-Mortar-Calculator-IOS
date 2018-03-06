//
//  EnlargedMortarGridViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 05/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

// Protocol to pass subgrid input to parent
protocol PassMortarLoc1 {
    func passMortar1()
}

class EnlargedMortarGridViewController: UIViewController {

    let calc = Calc.sharedInstance
    var delegate: PassMortarLoc1?

    // This is the mortar pin to be used for input
    @IBOutlet weak var mortarPin: UIImageView!

    // Set pin position to the position of any touch within the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch! = touches.first! as UITouch
        updatePosition(position: touch.location(in: self.view))
    }

    // Allow the user to drag the pin as long as they don't drag it out of the view container
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch: UITouch! = touches.first! as UITouch
        let candidatePosition = touch.location(in: self.view)
        if self.view.point(inside: candidatePosition, with: event) {
            updatePosition(position: candidatePosition)
        }
    }

    // Upon apperance of view set pin to currently stored subgrid position
    override func viewWillAppear(_ animated: Bool) {
        let xPoint = (calc.mortarSubgridXPos * Double(self.view!.bounds.width)) / (100/3)
        let yPoint = (calc.mortarSubgridYPos * Double(self.view!.bounds.height)) / (100/3)
        mortarPin.center = CGPoint(x: xPoint, y: yPoint)
    }

    // Called from center button in EnlargedMortarViewController.swift, centers pin
    func center() {
        updatePosition(position: CGPoint(x: self.view!.bounds.width/2, y: self.view!.bounds.height/2))
    }

    // Called whenever the pin is moved, converts position to meters in ingame coordinate system and stores in singleton
    func updatePosition(position: CGPoint) {
        mortarPin.center = position

        calc.mortarSubgridXPos = Double(position.x / self.view!.bounds.width) * (100/3)
        calc.mortarSubgridYPos = Double(position.y / self.view!.bounds.height) * (100/3)

        // Begining of notification chain
        delegate!.passMortar1()
    }

}
