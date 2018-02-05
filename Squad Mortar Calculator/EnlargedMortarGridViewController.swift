//
//  EnlargedMortarGridViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 05/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class EnlargedMortarGridViewController: UIViewController {

    var pinPosition = CGPoint(x: 0, y: 0)
    
    @IBOutlet weak var mortarPin: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Set pin position to the position of any touch within the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch! = touches.first! as UITouch
        pinPosition = touch.location(in: self.view)
        mortarPin.center = pinPosition
    }
    
    // Allow the user to drag the pin as long as they don't drag it out of the view contaner
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch : UITouch! = touches.first! as UITouch
        let candidatePosition = touch.location(in: self.view)
        if self.view.point(inside: candidatePosition, with: event) {
            pinPosition = candidatePosition
            mortarPin.center = pinPosition
        }
    }

}
