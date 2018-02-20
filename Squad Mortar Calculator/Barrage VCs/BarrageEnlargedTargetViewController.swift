//
//  BarrageEnlargedTargetViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 20/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

protocol PassBarrageTargetLoc2 {
    func passBarrageTarget2()
}

class BarrageEnlargedTargetViewController: UIViewController, PassBarrageTargetLoc1 {
    
    var barrageEnlargedTargetGridViewController: BarrageEnlargedTargetGridViewController?
    var delegate: PassBarrageTargetLoc2?
    
    @IBAction func doneButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func centerButton(_ sender: Any) {
        barrageEnlargedTargetGridViewController!.center()
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
        if (segue.identifier == "embeddedEnlargedBarrageTargetGridSegue") {
            barrageEnlargedTargetGridViewController = (segue.destination as! BarrageEnlargedTargetGridViewController)
            barrageEnlargedTargetGridViewController!.delegate = self
        }
    }
    
    func passBarrageTarget1() {
        delegate!.passBarrageTarget2()
    }
    
}
