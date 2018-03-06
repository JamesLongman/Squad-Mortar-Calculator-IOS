//
//  CorrectionsGridViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 19/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

/* For comments please see mortar VCs counterpart */

import UIKit

protocol PassCorrectionsTargetLoc3 {
    func passCorrectionsTarget3()
}

class CorrectionsGridViewController: UIViewController, PassCorrectionsTargetLoc2 {

    var delegate: PassCorrectionsTargetLoc3?
    let calc = Calc.sharedInstance

    @IBOutlet weak var targetPin: UIImageView!

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let fullScreenGrid = storyboard!.instantiateViewController(withIdentifier: "CorrectionsEnlargedTargetView") as? CorrectionsEnlargedTargetViewController
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
        super.viewWillLayoutSubviews()
        let xPoint = (calc.targetSubgridYPos * Double(self.view!.bounds.width)) / (100/3)
        let yPoint = (calc.targetSubgridYPos * Double(self.view!.bounds.height)) / (100/3)
        targetPin.center = CGPoint(x: xPoint, y: yPoint)
    }

    func passCorrectionsTarget2() {
        delegate!.passCorrectionsTarget3()
    }

}
