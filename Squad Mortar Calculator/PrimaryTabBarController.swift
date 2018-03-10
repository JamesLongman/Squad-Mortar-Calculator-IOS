//
//  PrimaryViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 15/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit
import StoreKit

class PrimaryTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /* Disable idle time. Users are likely to regularly spend periods of time
         using the app without any input while still referring to content the app provides,
         the app is intended to be used whilst a user is playing a computer game
         so battery life is not a big concern compared to the annoyance of regular idles
         as they will most likely be at home */
        UIApplication.shared.isIdleTimerDisabled = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        review()
    }

    // Function to determine if a request for a review should be made upon app start
    func review() {
        let userDefaults = UserDefaults.standard
        let now = Int(NSDate().timeIntervalSince1970)
        // If app was last opened more than an hour ago
        if now - userDefaults.integer(forKey: "lastUsed") > 3600 {
            if userDefaults.hasValue(forKey: "uses") {
                let current = userDefaults.integer(forKey: "uses")
                userDefaults.set(current + 1, forKey: "uses")
            } else {
                userDefaults.set(1, forKey: "uses")
            }

            userDefaults.synchronize()
            // If user has opened app more than 5 times request review once per month
            if userDefaults.integer(forKey: "uses") > 4 {
                if userDefaults.hasValue(forKey: "lastNotified") {
                    // If last requested review more than month ago
                    if now - userDefaults.integer(forKey: "lastNotified") > 2592000 {
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
