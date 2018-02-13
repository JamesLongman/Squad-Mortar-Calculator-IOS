//
//  TargetGridViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 11/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

protocol PassTargetLoc3 {
    func passTarget3(x: Double, y: Double)
}

class TargetGridViewController: UIViewController, PassTargetLoc2 {

    var delegate: PassTargetLoc3?
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
        let fullScreenGrid = storyboard!.instantiateViewController(withIdentifier: "EnlargedTargetView") as! EnlargedTargetViewController
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
    
    
    func passTarget2(x: Double, y: Double) {
        targetSubgridXPos = x
        targetSubgridYPos = y
        
        delegate!.passTarget3(x: x, y: y)
    }
}
