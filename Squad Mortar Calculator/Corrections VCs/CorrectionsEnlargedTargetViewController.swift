//
//  CorrectionsEnlargedTargetViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 19/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

/* For comments please see mortar VCs counterpart */

import UIKit

protocol PassCorrectionsTargetLoc2 {
    func passCorrectionsTarget2()
}

class CorrectionsEnlargedTargetViewController: UIViewController, PassCorrectionsTargetLoc1 {

    var correctionsEnlargedTargetGridViewController: CorrectionsEnlargedTargetGridViewController?
    var delegate: PassCorrectionsTargetLoc2?

    @IBAction func doneButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func centerButton(_ sender: Any) {
        correctionsEnlargedTargetGridViewController!.center()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embeddedEnlargedCorrectionsTargetGridSegue" {
            correctionsEnlargedTargetGridViewController = segue.destination as? CorrectionsEnlargedTargetGridViewController
            correctionsEnlargedTargetGridViewController!.delegate = self
        }
    }

    func passCorrectionsTarget1() {
        delegate!.passCorrectionsTarget2()
    }

}
