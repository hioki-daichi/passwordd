//
//  KeyboardSelectViewController.swift
//  passwordd
//
//  Created by 日置大智 on 2015/05/04.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import UIKit

class KeyboardSelectViewController: UITableViewController {
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: reuseIdentifier)
        cell.selectionStyle = .None

        let keyboardType = contents[indexPath.row]

        cell.textLabel?.text = keyboardType.displayString()

        if keyboardType == MyUserDefaults.sharedInstance.keyboardType {
            cell.accessoryType = .Checkmark
        }

        return cell
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        for i in 0..<contents.count {
            tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0))?.accessoryType = .None
        }

        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        let newKeyboardType = contents[indexPath.row]
        MyUserDefaults.sharedInstance.keyboardType = newKeyboardType

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if appDelegate.initialKeyboardType != newKeyboardType {
            let alertController = UIAlertController(title: nil, message: "NeedToShutdownToReflect".localize(), preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "ShutdownTheApplication".localize(), style: .Default, handler: { (action: UIAlertAction!) in exit(0) }))
            alertController.addAction(UIAlertAction(title: "Later".localize(), style: .Default, handler: { (action: UIAlertAction!) in }))
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(alertController, animated: true, completion: nil)
            })
        }
    }

    private let contents = KeyboardType.allValues
    private let reuseIdentifier = "Cell"
}
