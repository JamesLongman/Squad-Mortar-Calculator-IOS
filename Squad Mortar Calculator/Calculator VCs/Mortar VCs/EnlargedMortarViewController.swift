//
//  Enlarged Mortar Grid View Controller.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 04/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

protocol PassMortarLoc2 {
    func passMortar2()
}

class EnlargedMortarViewController: UIViewController, PassMortarLoc1 {
    var enlargedMortarGridViewController: EnlargedMortarGridViewController?
    var delegate: PassMortarLoc2?
    
    @IBAction func doneButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func centerButton(_ sender: Any) {
        enlargedMortarGridViewController!.center()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "embeddedEnlargedMortarGridSegue") {
            enlargedMortarGridViewController = (segue.destination as! EnlargedMortarGridViewController)
            enlargedMortarGridViewController!.delegate = self
        }
    }
    
    func passMortar1() {
        delegate!.passMortar2()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
