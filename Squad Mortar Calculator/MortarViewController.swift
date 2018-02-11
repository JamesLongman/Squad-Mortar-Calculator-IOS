//
//  MortarViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 01/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class MortarViewController: UIViewController, UITextFieldDelegate, PassMortarLoc3 {

    // 3 fields and grid in Mortar view
    @IBOutlet weak var leftMortarField: CoordinatesTextField1!
    @IBOutlet weak var middleMortarField: CoordinatesTextField2!
    @IBOutlet weak var rightMortarField: CoordinatesTextField2!
    @IBOutlet weak var mortarGrid: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Allow keyboard to be dismissed via touching elsewhere on the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        leftMortarField.resignFirstResponder()
        middleMortarField.resignFirstResponder()
        rightMortarField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "embeddedMortarGridSegue") {
            let mortarGridViewController = (segue.destination as! MortarGridViewController)
            mortarGridViewController.delegate = self
        }
    }
    
    func passMortar3(x: Double, y: Double) {
        
    }

}
