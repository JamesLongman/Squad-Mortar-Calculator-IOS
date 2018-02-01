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
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var leftMortarField: MaxLengthTextField!
    @IBOutlet weak var middleMortarField: MaxLengthTextField!
    @IBOutlet weak var rightMortarField: MaxLengthTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.leftMortarField.delegate = self
        self.middleMortarField.delegate = self
        self.middleMortarField.delegate = self
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
    
    // Allow keyboard to be dismissed via return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    //Allow keyboard to be dismissed via touching elsewhere on the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        leftMortarField.resignFirstResponder()
        middleMortarField.resignFirstResponder()
        rightMortarField.resignFirstResponder()
    }

}
