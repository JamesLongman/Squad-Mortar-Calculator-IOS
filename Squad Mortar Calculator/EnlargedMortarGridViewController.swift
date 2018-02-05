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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch! = touches.first! as UITouch
        pinPosition = touch.location(in: self.view)
        mortarPin.center = pinPosition
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch! = touches.first! as UITouch
        pinPosition = touch.location(in: self.view)
        mortarPin.center = pinPosition
    }

}
