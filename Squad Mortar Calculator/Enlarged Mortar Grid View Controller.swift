//
//  Enlarged Mortar Grid View Controller.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 04/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class Enlarged_Mortar_Grid_View_Controller: UIViewController {
    @IBAction func doneButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
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

}
