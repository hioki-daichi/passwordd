//
//  KeyboardSelectViewController.swift
//  passwordd
//
//  Created by 日置大智 on 2015/05/04.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import UIKit

class KeyboardSelectViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        cell.selectionStyle = .none

        let keyboardType = contents[(indexPath as NSIndexPath).row]

        cell.textLabel?.text = keyboardType.displayString()

        if keyboardType == MyUserDefaults.sharedInstance.keyboardType {
            cell.accessoryType = .checkmark
        }

        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<contents.count {
            tableView.cellForRow(at: IndexPath(row: i, section: 0))?.accessoryType = .none
        }

        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        let newKeyboardType = contents[(indexPath as NSIndexPath).row]
        MyUserDefaults.sharedInstance.keyboardType = newKeyboardType

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.initialKeyboardType != newKeyboardType {
            let alertController = UIAlertController(title: nil, message: "NeedToShutdownToReflect".localize(), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "ShutdownTheApplication".localize(), style: .default, handler: { (action: UIAlertAction) in exit(0) }))
            alertController.addAction(UIAlertAction(title: "Later".localize(), style: .default, handler: { (action: UIAlertAction) in }))
            DispatchQueue.main.async(execute: {
                self.present(alertController, animated: true, completion: nil)
            })
        }
    }

    fileprivate let contents = KeyboardType.allValues
    fileprivate let reuseIdentifier = "Cell"
}
