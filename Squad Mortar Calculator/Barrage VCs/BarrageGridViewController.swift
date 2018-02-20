//
//  BarrageGridViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 20/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

protocol PassBarrageTargetLoc3 {
    func passBarrageTarget3()
}

class BarrageGridViewController: UIViewController, PassBarrageTargetLoc2 {
    
    var delegate: PassBarrageTargetLoc3?
    let calc = Calc.sharedInstance
    
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
        let fullScreenGrid = storyboard!.instantiateViewController(withIdentifier: "BarrageEnlargedTargetView") as! BarrageEnlargedTargetViewController
        fullScreenGrid.delegate = self
        
        self.present(fullScreenGrid, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let xPoint = calc.targetSubgridXPos * (3/2)
        let yPoint = calc.targetSubgridYPos * (3/2)
        targetPin.center = CGPoint(x: xPoint, y: yPoint)
    }
    
    
    func passBarrageTarget2() {
        delegate!.passBarrageTarget3()
    }
}

