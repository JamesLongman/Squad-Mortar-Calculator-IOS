//
//  MoreViewController.swift
//  Squad Mortar Calculator
//
//  Created by James Longman on 13/02/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import UIKit

class MoreViewController: UITableViewController {
    // Table items stored in order
    let moreTable = ["User Guide", "About", "Leave A Review", "Project Github Repository"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // UIColor = Mercury
        self.tableView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        self.tableView.tableFooterView = UIView()
    }
    
    // Set sections to 1
    override func numberOfSections(in tableView: UITableView) -> Int {
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

    // Actions to be taken upon a touch of a particular table item
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (moreTable[indexPath.row] == "User Guide") {
            self.performSegue(withIdentifier: "guideViewControllerSegue", sender: self)
        } else if (moreTable[indexPath.row] == "About") {
            self.performSegue(withIdentifier: "aboutViewControllerSegue", sender: self)
        } else if (moreTable[indexPath.row] == "Leave A Review") {
            UIApplication.shared.open(URL(string: "https://itunes.apple.com/app/id1352781413?action=write-review")!, options: [:], completionHandler: nil)
        } else if (moreTable[indexPath.row] == "Project Github Repository") {
            UIApplication.shared.open(URL(string : "https://github.com/JamesLongman/Squad-Mortar-Calculator-IOS")!, options: [:], completionHandler: nil)
        } else {
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
    }
    
    // Simple animation to bring rows into view when more view appears
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.5, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
                }, completion: nil)
            delayCounter += 1
        }
    }
}
