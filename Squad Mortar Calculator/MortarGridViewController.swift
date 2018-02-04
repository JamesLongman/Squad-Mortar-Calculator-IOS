//
//  MortarGridViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 03/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class MortarGridViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let fullScreenGrid = storyboard!.instantiateViewController(withIdentifier: "EnlargedMortarGridView") as! Enlarged_Mortar_Grid_View_Controller
        self.present(fullScreenGrid, animated: true, completion: nil)
    }

}
