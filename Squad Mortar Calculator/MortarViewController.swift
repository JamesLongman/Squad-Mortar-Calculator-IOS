//
//  MortarViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 01/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class MortarViewController: UIViewController, UITextFieldDelegate {

    // 3 fields and button in Mortar view
    @IBOutlet weak var leftMortarField: CoordinatesTextField!
    @IBOutlet weak var middleMortarField: CoordinatesTextField!
    @IBOutlet weak var rightMortarField: CoordinatesTextField!
    @IBOutlet weak var editButton: UIButton!
    
    
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

}
