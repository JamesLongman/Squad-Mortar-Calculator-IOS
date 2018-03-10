//
//  Enlarged Mortar Grid View Controller.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 04/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

// Protocol to pass notification of subgrid input up
protocol PassMortarLoc2 {
    func passMortar2()
}

class EnlargedMortarViewController: UIViewController, PassMortarLoc1 {
    var enlargedMortarGridViewController: EnlargedMortarGridViewController?
    var delegate: PassMortarLoc2?

    // When the user presses the done button dismiss the view
    @IBAction func doneButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    // When the user presses the center button center the pin in the subgrid view
    @IBAction func centerButton(_ sender: Any) {
        enlargedMortarGridViewController?.center()
    }

    // Set self as a delegate of child view so view can be notified upon subgrid input
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embeddedEnlargedMortarGridSegue" {
            enlargedMortarGridViewController = (segue.destination as? EnlargedMortarGridViewController)
            enlargedMortarGridViewController?.delegate = self
        }
    }

    // Notification of subgrid input from child passed to parent
    func passMortar1() {
        delegate?.passMortar2()
    }

}
