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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTableViewContents()
        tableView.reloadData()
    }

    func funcOnKeyboardDidSelected() {
        performSegue(withIdentifier: "fromSettingsToKeyboardSelect", sender: nil)
    }

    func includeNumberSwitched(_ sender: UISwitch) {
        MyUserDefaults.sharedInstance.includeNumber = sender.isOn
    }

    func includeLowerCaseSignSwitched(_ sender: UISwitch) {
        MyUserDefaults.sharedInstance.includeLowerCaseSign = sender.isOn
    }

    func allowIndexFingerSwitchedL(_ sender: UISwitch) {
        if !sender.isOn && !canSwitchLeft() {
            sender.isOn = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowIndexFingerL = sender.isOn
    }
    func allowIndexFingerSwitchedR(_ sender: UISwitch) {
        if !sender.isOn && !canSwitchRight() {
            sender.isOn = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowIndexFingerR = sender.isOn
    }

    func allowMiddleFingerSwitchedL(_ sender: UISwitch) {
        if !sender.isOn && !canSwitchLeft() {
            sender.isOn = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowMiddleFingerL = sender.isOn
    }
    func allowMiddleFingerSwitchedR(_ sender: UISwitch) {
        if !sender.isOn && !canSwitchRight() {
            sender.isOn = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowMiddleFingerR = sender.isOn
    }

    func allowRingFingerSwitchedL(_ sender: UISwitch) {
        if !sender.isOn && !canSwitchLeft() {
            sender.isOn = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowRingFingerL = sender.isOn
    }

    func allowRingFingerSwitchedR(_ sender: UISwitch) {
        if !sender.isOn && !canSwitchRight() {
            sender.isOn = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowRingFingerR = sender.isOn
    }

    func allowPinkieSwitchedL(_ sender: UISwitch) {
        if !sender.isOn && !canSwitchLeft() {
            sender.isOn = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowPinkieL = sender.isOn
    }
    func allowPinkieSwitchedR(_ sender: UISwitch) {
        if !sender.isOn && !canSwitchRight() {
            sender.isOn = true
            alertToEnableAtLeastTwoFingers()
            return
        }

        MyUserDefaults.sharedInstance.allowPinkieR = sender.isOn
    }

    fileprivate let reuseIdentifier = "Cell"

    fileprivate var settingsSections: [(sectionTitle: String, contents: [Content])]!

    fileprivate func setTableViewContents() {
        settingsSections = [
            (
                sectionTitle: "CharacterTypeExpansion".localize(),
                contents: [
                    (
                        title: "IncludeNumber".localize(),
                        detail: Optional("IncludeNumberDescription".localize()),
                        sw: Optional(generateSwitchWithAction(#selector(SettingsViewController.includeNumberSwitched(_:)), on: MyUserDefaults.sharedInstance.includeNumber)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "IncludeLowerCaseSign".localize(),
                        detail: Optional("IncludeLowerCaseSignDescription".localize()),
                        sw: Optional(generateSwitchWithAction(#selector(SettingsViewController.includeLowerCaseSignSwitched(_:)), on: MyUserDefaults.sharedInstance.includeLowerCaseSign)),
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
                        sw: Optional(generateSwitchWithAction(#selector(SettingsViewController.allowIndexFingerSwitchedL(_:)), on: MyUserDefaults.sharedInstance.allowIndexFingerL)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "MiddleFinger".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction(#selector(SettingsViewController.allowMiddleFingerSwitchedL(_:)), on: MyUserDefaults.sharedInstance.allowMiddleFingerL)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "RingFinger".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction(#selector(SettingsViewController.allowRingFingerSwitchedL(_:)), on: MyUserDefaults.sharedInstance.allowRingFingerL)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "Pinkie".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction(#selector(SettingsViewController.allowPinkieSwitchedL(_:)), on: MyUserDefaults.sharedInstance.allowPinkieL)),
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
                        sw: Optional(generateSwitchWithAction(#selector(SettingsViewController.allowIndexFingerSwitchedR(_:)), on: MyUserDefaults.sharedInstance.allowIndexFingerR)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "MiddleFinger".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction(#selector(SettingsViewController.allowMiddleFingerSwitchedR(_:)), on: MyUserDefaults.sharedInstance.allowMiddleFingerR)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "RingFinger".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction(#selector(SettingsViewController.allowRingFingerSwitchedR(_:)), on: MyUserDefaults.sharedInstance.allowRingFingerR)),
                        funcOnDidSelect: nil
                    ),
                    (
                        title: "Pinkie".localize(),
                        detail: nil,
                        sw: Optional(generateSwitchWithAction(#selector(SettingsViewController.allowPinkieSwitchedR(_:)), on: MyUserDefaults.sharedInstance.allowPinkieR)),
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

    fileprivate func getTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let content = settingsSections[(indexPath as NSIndexPath).section].contents[(indexPath as NSIndexPath).row]

        let cell: UITableViewCell
        if content.funcOnDidSelect != nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: reuseIdentifier)
            cell.accessoryType = .disclosureIndicator
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
            cell.selectionStyle = .none
        }

        cell.selectionStyle = .none

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

    fileprivate func generateSwitchWithAction(_ action: Selector, on: Bool) -> UISwitch {
        let sw = UISwitch()
        sw.isOn = on
        sw.addTarget(self, action: action, for: UIControlEvents.valueChanged)
        return sw
    }

    fileprivate func alertToEnableAtLeastTwoFingers() {
        let alertController = UIAlertController(title: "Error".localize(), message: "EnableAtLeastTwoFingers".localize(), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { action in })
        present(alertController, animated: true, completion: nil)
    }

    fileprivate func canSwitchLeft() -> Bool {
        // 少なくとも 2 つの指が有効になっていないと指が分散できなくなるためチェックをしている
        return Finger.allValues.map { $0.isAllowedL() }.filter { $0 == true }.count > 2
    }

    fileprivate func canSwitchRight() -> Bool {
        // 少なくとも 2 つの指が有効になっていないと指が分散できなくなるためチェックをしている
        return Finger.allValues.map { $0.isAllowedR() }.filter { $0 == true }.count > 2
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getTableViewCell(indexPath)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingsSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsSections[section].contents.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsSections[section].sectionTitle
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let content = settingsSections[(indexPath as NSIndexPath).section].contents[(indexPath as NSIndexPath).row]

        if content.funcOnDidSelect != nil {
            return tableView.rowHeight
        }

        if let detail = content.detail {
            let cell = getTableViewCell(indexPath)
            let attr = [NSFontAttributeName: cell.detailTextLabel!.font]
            return cell.bounds.height + detail.size(attributes: attr).height - "a".size(attributes: attr).height + 20
        }

        return tableView.rowHeight
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let f = settingsSections[(indexPath as NSIndexPath).section].contents[(indexPath as NSIndexPath).row].funcOnDidSelect {
            f()
        }
    }
}
