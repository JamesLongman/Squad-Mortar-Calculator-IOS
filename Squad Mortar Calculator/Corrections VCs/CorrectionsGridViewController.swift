//
//  CorrectionsGridViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 19/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

protocol PassCorrectionsTargetLoc3 {
    func passCorrectionsTarget3(x: Double, y: Double)
}

class CorrectionsGridViewController: UIViewController, PassCorrectionsTargetLoc2 {

    var delegate: PassCorrectionsTargetLoc3?
    var targetSubgridXPos: Double = 100/6
    var targetSubgridYPos: Double = 100/6
    
    @IBOutlet weak var targetPin: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let fullScreenGrid = storyboard!.instantiateViewController(withIdentifier: "CorrectionsEnlargedTargetView") as! CorrectionsEnlargedTargetViewController
        fullScreenGrid.targetSubgridXPos = targetSubgridXPos
        fullScreenGrid.targetSubgridYPos = targetSubgridYPos
        fullScreenGrid.delegate = self
        
        self.present(fullScreenGrid, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let xPoint = targetSubgridXPos * (3/2)
        let yPoint = targetSubgridYPos * (3/2)
        targetPin.center = CGPoint(x: xPoint, y: yPoint)
    }
    
    
    func passCorrectionsTarget2(x: Double, y: Double) {
        targetSubgridXPos = x
        targetSubgridYPos = y
        
        delegate!.passCorrectionsTarget3(x: x, y: y)
    }
}
