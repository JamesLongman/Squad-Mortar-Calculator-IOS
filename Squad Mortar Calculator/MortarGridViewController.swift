//
//  MortarGridViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 03/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class MortarGridViewController: UIViewController {
    /*
        Container view width = 50, height = 50
        Pin width = 5, height = 5
        Center coodinates = (view size - pin size)/2
        ∴ Center coodinates are x = 22.5, y = 22.5
    */
    var mortarSubGridPosition = CGPoint(x: 0, y: 0)
    
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
        self.present(fullScreenGrid, animated: true, completion: nil)
    }

}
