//
//  TargetGridViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 11/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

/* For comments please see mortar VCs counterpart */

import UIKit

protocol PassTargetLoc3 {
    func passTarget3()
}

class TargetGridViewController: UIViewController, PassTargetLoc2 {

    var delegate: PassTargetLoc3?
    let calc = Calc.sharedInstance

    @IBOutlet weak var targetPin: UIImageView!

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let fullScreenGrid = storyboard!.instantiateViewController(withIdentifier: "EnlargedTargetView") as? EnlargedTargetViewController
        fullScreenGrid?.delegate = self

        self.present(fullScreenGrid!, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let xPoint = (calc.targetSubgridXPos * Double(self.view!.bounds.width)) / (100/3)
        let yPoint = (calc.targetSubgridYPos * Double(self.view!.bounds.height)) / (100/3)
        targetPin.center = CGPoint(x: xPoint, y: yPoint)
    }

    override func viewWillLayoutSubviews() {
        let xPoint = (calc.targetSubgridYPos * Double(self.view!.bounds.width)) / (100/3)
        let yPoint = (calc.targetSubgridYPos * Double(self.view!.bounds.height)) / (100/3)
        targetPin.center = CGPoint(x: xPoint, y: yPoint)
    }

    func passTarget2() {
        delegate!.passTarget3()
    }

}
