//
//  MortarGridViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 03/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

protocol PassMortarLoc3 {
    func passMortar3(x: Double, y: Double)
}

class MortarGridViewController: UIViewController, PassMortarLoc2 {
    var delegate: PassMortarLoc3?
    /*
        Container view width = 50, height = 50
        Pin width = 5, height = 5
        Center coodinates = (view size - pin size)/2
        ∴ Center coodinates are x = 22.5, y = 22.5
    */
    var mortarSubGridPosition = CGPoint(x: 22.5, y: 22.5)
    var mortarSubgridXPos: Double = 100/6
    var mortarSubgridYPos: Double = 100/6
    
    @IBOutlet weak var mortarPin: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let fullScreenGrid = storyboard!.instantiateViewController(withIdentifier: "EnlargedMortarView") as! EnlargedMortarViewController
        fullScreenGrid.mortarSubgridXPos = mortarSubgridXPos
        fullScreenGrid.mortarSubgridYPos = mortarSubgridYPos
        fullScreenGrid.delegate = self
        
        self.present(fullScreenGrid, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mortarPin.center = mortarSubGridPosition
    }
    
    
    func passMortar2(x: Double, y: Double) {
        mortarSubGridPosition.x = CGFloat(x * (3/2))
        mortarSubGridPosition.y = CGFloat(y * (3/2))
        
        mortarSubgridXPos = x
        mortarSubgridYPos = y
        
        delegate!.passMortar3(x: x, y: y)
    }

}
