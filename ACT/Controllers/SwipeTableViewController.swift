//
//  SwipeTableViewController.swift
//  ACT
//
//  Created by Traton Gossink on 5/9/23.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    var cell: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 88.0
    }
    
    //MARK: - DataSource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.deleteCellModel(at: indexPath)
        }
        let editAction = SwipeAction(style: .default, title: "Edit") { action, indexPath in
            self.editCellModel(at: indexPath)
        }
//        print("Delete Cell")
        ///Displays UI buttons when swipe action is performed
        deleteAction.image = UIImage(named: "delete-icon")
        editAction.image = UIImage(systemName: "pencil")
        
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        
        return options
    }
    
    func deleteCellModel(at indexPath: IndexPath) {
    }
    
    func editCellModel(at indexPath: IndexPath) {
    }
    
}


