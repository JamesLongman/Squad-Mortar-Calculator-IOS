//
//  PrimaryViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 15/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit
import StoreKit

extension UserDefaults {
    
    func hasValue(forKey key: String) -> Bool {
        return nil != object(forKey: key)
    }
}

class PrimaryViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        review()
    }
    
    func review() {
        let userDefaults = UserDefaults.standard
        let now = Int(NSDate().timeIntervalSince1970)
        // If app was last opened more than an hour ago
        if (now - userDefaults.integer(forKey: "lastUsed") > 3600) {
            if userDefaults.hasValue(forKey: "uses") {
                let current = userDefaults.integer(forKey: "uses")
                userDefaults.set(current + 1, forKey: "uses")
            } else {
                userDefaults.set(1, forKey: "uses")
            }
            
            userDefaults.synchronize()
            // If user has opened app more than 5 times request review once per month
            if (userDefaults.integer(forKey: "uses") > 4) {
                if userDefaults.hasValue(forKey: "lastNotified") {
                    // If last requested review more than month ago
                    if (now - userDefaults.integer(forKey: "lastNotified") > 2592000) {
                        userDefaults.set(now, forKey: "lastNotified")
                        SKStoreReviewController.requestReview()
                    }
                } else {
                    userDefaults.set(now, forKey: "lastNotified")
                    SKStoreReviewController.requestReview()
                }
            }
        }
        userDefaults.set(now, forKey: "lastUsed")
    }
}
