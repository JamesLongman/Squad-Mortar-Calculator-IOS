//
//  GuideViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 13/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    // INSERT: Guide view controller code
    
    @IBAction func backButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func backTextButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
