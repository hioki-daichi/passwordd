//
//  SettingsViewController.swift
//  passwordd
//
//  Created by 日置大智 on 2015/04/25.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    typealias Content = (title: String, detail: String?, sw: UISwitch?, funcOnDidSelect: (() -> ())?)

    override func viewDidLoad() {
        setTableViewContents()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setTableViewContents()
        tableView.reloadData()
    }

    func funcOnKeyboardDidSelected() {
        performSegueWithIdentifier("fromSettingsToKeyboardSelect", sender: nil)
    }

    func includeNumberSwitched(sender: UISwitch) {
        MyUserDefaults.sharedInstance.includeNumber = sender.on
    }

    func includeLowerCaseSignSwitched(sender: UISwitch) {
        MyUserDefaults.sharedInstance.includeLowerCaseSign = sender.on
    }

    func allowIndexFingerSwitchedL(sender: UISwitch) {
        if !sender.on && !canSwitchLeft() {
            sender.on = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowIndexFingerL = sender.on
    }
    func allowIndexFingerSwitchedR(sender: UISwitch) {
        if !sender.on && !canSwitchRight() {
            sender.on = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowIndexFingerR = sender.on
    }

    func allowMiddleFingerSwitchedL(sender: UISwitch) {
        if !sender.on && !canSwitchLeft() {
            sender.on = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowMiddleFingerL = sender.on
    }
    func allowMiddleFingerSwitchedR(sender: UISwitch) {
        if !sender.on && !canSwitchRight() {
            sender.on = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowMiddleFingerR = sender.on
    }

    func allowRingFingerSwitchedL(sender: UISwitch) {
        if !sender.on && !canSwitchLeft() {
            sender.on = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowRingFingerL = sender.on
    }

    func allowRingFingerSwitchedR(sender: UISwitch) {
        if !sender.on && !canSwitchRight() {
            sender.on = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowRingFingerR = sender.on
    }

    func allowPinkieSwitchedL(sender: UISwitch) {
        if !sender.on && !canSwitchLeft() {
            sender.on = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowPinkieL = sender.on
    }
    func allowPinkieSwitchedR(sender: UISwitch) {
        if !sender.on && !canSwitchRight() {
            sender.on = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowPinkieR = sender.on
    }

    private let reuseIdentifier = "Cell"

    private var settingsSections: [(sectionTitle: String, contents: [Content])]!

    private func setTableViewContents() {
        settingsSections = [
            (
                sectionTitle: "CharacterTypeExpansion".localize(),
                contents: [
                    (
                        title: "IncludeNumber".localize(),
                        detail: Optional("IncludeNumberDescription".localize()),
                        sw: Optional(generateSwitchWithAction("includeNumberSwitched:", on: MyUserDefaults.sharedInstance.includeNumber)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "IncludeLowerCaseSign".localize(),
                        detail: Optional("IncludeLowerCaseSignDescription".localize()),
                        sw: Optional(generateSwitchWithAction("includeLowerCaseSignSwitched:", on: MyUserDefaults.sharedInstance.includeLowerCaseSign)),
                        funcOnDidSelect: nil
                    ),
                ]
            ),
            (
                sectionTitle: "LeftHandFingers".localize(),
                contents: [
                    (
                        title: "IndexFinger".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction("allowIndexFingerSwitchedL:", on: MyUserDefaults.sharedInstance.allowIndexFingerL)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "MiddleFinger".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction("allowMiddleFingerSwitchedL:", on: MyUserDefaults.sharedInstance.allowMiddleFingerL)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "RingFinger".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction("allowRingFingerSwitchedL:", on: MyUserDefaults.sharedInstance.allowRingFingerL)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "Pinkie".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction("allowPinkieSwitchedL:", on: MyUserDefaults.sharedInstance.allowPinkieL)),
                        funcOnDidSelect: nil
                    ),
                ]
            ),
            (
                sectionTitle: "RightHandFingers".localize(),
                contents: [
                    (
                        title: "IndexFinger".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction("allowIndexFingerSwitchedR:", on: MyUserDefaults.sharedInstance.allowIndexFingerR)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "MiddleFinger".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction("allowMiddleFingerSwitchedR:", on: MyUserDefaults.sharedInstance.allowMiddleFingerR)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "RingFinger".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction("allowRingFingerSwitchedR:", on: MyUserDefaults.sharedInstance.allowRingFingerR)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "Pinkie".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction("allowPinkieSwitchedR:", on: MyUserDefaults.sharedInstance.allowPinkieR)),
                        funcOnDidSelect: nil
                    ),
                ]
            ),
            (
                sectionTitle: "Other".localize(),
                contents: [
                    (
                        title: "Keyboard".localize(),
                        detail: Optional(MyUserDefaults.sharedInstance.keyboardType.displayString()),
                        sw: nil,
                        funcOnDidSelect: Optional({ self.funcOnKeyboardDidSelected() })
                    ),
                ]
            )
        ]
    }

    private func getTableViewCell(indexPath: NSIndexPath) -> UITableViewCell {
        let content = settingsSections[indexPath.section].contents[indexPath.row]

        let cell: UITableViewCell
        if content.funcOnDidSelect != nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: reuseIdentifier)
            cell.accessoryType = .DisclosureIndicator
        } else {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: reuseIdentifier)
            cell.selectionStyle = .None
        }

        cell.selectionStyle = .None

        if let textLabel = cell.textLabel {
            textLabel.text = content.title
            textLabel.textColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
        }

        if let detail = content.detail, let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.numberOfLines = 0
            detailTextLabel.text = detail
            detailTextLabel.textColor = UIColor(red: 176/255.0, green: 190/255.0, blue: 197/255.0, alpha: 1)
        }

        if let sw = content.sw {
            cell.accessoryView = sw;
        }

        return cell
    }

    private func generateSwitchWithAction(action: Selector, on: Bool) -> UISwitch {
        let sw = UISwitch()
        sw.on = on
        sw.addTarget(self, action: action, forControlEvents: UIControlEvents.ValueChanged)
        return sw
    }

    private func alertToEnableAtLeastTwoFingers() {
        let alertController = UIAlertController(title: "Error".localize(), message: "EnableAtLeastTwoFingers".localize(), preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default) { action in })
        presentViewController(alertController, animated: true, completion: nil)
    }

    private func canSwitchLeft() -> Bool {
        // 少なくとも 2 つの指が有効になっていないと指が分散できなくなるためチェックをしている
        return Finger.allValues.map { $0.isAllowedL() }.filter { $0 == true }.count > 2
    }

    private func canSwitchRight() -> Bool {
        // 少なくとも 2 つの指が有効になっていないと指が分散できなくなるためチェックをしている
        return Finger.allValues.map { $0.isAllowedR() }.filter { $0 == true }.count > 2
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return getTableViewCell(indexPath)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return settingsSections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsSections[section].contents.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsSections[section].sectionTitle
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let content = settingsSections[indexPath.section].contents[indexPath.row]

        if content.funcOnDidSelect != nil {
            return tableView.rowHeight
        }

        if let detail = content.detail {
            let cell = getTableViewCell(indexPath)
            let attr = [NSFontAttributeName: cell.detailTextLabel!.font]
            return cell.bounds.height + detail.sizeWithAttributes(attr).height - "a".sizeWithAttributes(attr).height + 20
        }

        return tableView.rowHeight
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let f = settingsSections[indexPath.section].contents[indexPath.row].funcOnDidSelect {
            f()
        }
    }
}
