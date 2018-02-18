//
//  AboutViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 13/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var body = "Squad Mortar Calculator is a non-official community made application to calculate accurate calibrations for players to correctly align their mortars to certain points on the map"
        body = body + "\n\nBuilt using:"
        body = body + "\nXcode 9.2"
        body = body + "\nSwift 4.1"
        body = body + "\n\nLicense: MIT"
        body = body + "\n\nThe project's code and information on how to contribute (whether through reporting bugs or improving on the code) is available at the projects github repository, a link is under the \"More\" tab"
        
        aboutText.text = body
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func backTextButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
