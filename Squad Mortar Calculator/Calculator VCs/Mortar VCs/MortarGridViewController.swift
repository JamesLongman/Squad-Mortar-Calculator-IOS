//
//  MortarGridViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 03/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

// Protocol to notify parent upon input
protocol PassMortarLoc3 {
    func passMortar3()
}

class MortarGridViewController: UIViewController, PassMortarLoc2 {
    var delegate: PassMortarLoc3?
    let calc = Calc.sharedInstance
    
    // This mortar pin isn't for input but just to mirror the input pin to display current subgrid posiiton
    @IBOutlet weak var mortarPin: UIImageView!

    // If the subgrid view section is touched, open the enlarged subgrid view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let fullScreenGrid = storyboard!.instantiateViewController(withIdentifier: "EnlargedMortarView") as! EnlargedMortarViewController
        fullScreenGrid.delegate = self
        
        self.present(fullScreenGrid, animated: true, completion: nil)
    }
    
    // When the view will appear, set the pin to the most recent position stored in the calc singleton
    override func viewWillAppear(_ animated: Bool) {
        let xPoint = calc.mortarSubgridXPos * (3/2)
        let yPoint = calc.mortarSubgridYPos * (3/2)
        mortarPin.center = CGPoint(x: xPoint, y: yPoint)
    }
    
    // Notification of subgrid input from child, passed to parent
    func passMortar2() {
        delegate!.passMortar3()
    }
}
