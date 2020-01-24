//
//  JoystickViewController+UITableView.swift
//  SwiftEV3
//
//  Created by Pioneer-Robotics on 1/23/20.
//  Copyright © 2020 Pioneer-Robotics. All rights reserved.
//

import UIKit

extension JoystickViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = commands[indexPath.row].directionText
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            commands.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = commands[sourceIndexPath.row]
        commands.remove(at: sourceIndexPath.row)
        commands.insert(movedObject, at: destinationIndexPath.row)
    }
}
