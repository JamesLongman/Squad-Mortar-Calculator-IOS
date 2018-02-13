//
//  MoreViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 13/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class MoreViewController: UITableViewController {
    let moreTable = ["User Guide", "About", "Leave A Review", "Project Github Page"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // UIColor = Mercury
        self.tableView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreTable.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moreCell = self.tableView.dequeueReusableCell(withIdentifier: "moreCell", for: indexPath)
        moreCell.textLabel?.text = moreTable[indexPath.row]
        return moreCell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (moreTable[indexPath.row] == "User Guide") {
            let guideView = storyboard!.instantiateViewController(withIdentifier: "GuideView") as! GuideViewController
            self.present(guideView, animated: true, completion: nil)
        } else if (moreTable[indexPath.row] == "About") {
            let aboutView = storyboard!.instantiateViewController(withIdentifier: "AboutView") as! AboutViewController
            self.present(aboutView, animated: true, completion: nil)
        } else if (moreTable[indexPath.row] == "Leave A Review") {
            print("REVIEW LINK")
        } else if (moreTable[indexPath.row] == "Project Github Page") {
            UIApplication.shared.open(URL(string : "https://github.com/JamesLongman/Squad-Mortar-Calculator-IOS")!, options: [:], completionHandler: { (status) in})
        } else {
            return
        }
    }
}
