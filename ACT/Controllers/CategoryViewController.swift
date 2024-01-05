//
//  CategoryTableViewController.swift
//  ACT
//
//  Created by Traton Gossink on 3/22/23.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
        
    let realm = try! Realm()
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadCategory()
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet."
        }
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    func  save(category: Category) {
        do{
            try realm.write{
                realm.add(category)
            }
        }catch {
            print("Error saving context, \(error)")
        }
        tableView.reloadData()
    } 
    func  edit(item: Item) {
        var updateItem = self.categories
        do{
            try realm.write{
                realm.add(updateItem!)
            }
        }catch {
            print("Error saving context, \(error)")
        }
        tableView.reloadData()
    } 
    
    func loadCategory() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
            
    override func deleteCellModel(at indexPath: IndexPath) {
        if let deleteCategory = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(deleteCategory)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }

    override func editCellModel(at indexPath: IndexPath) {
        if let editCategory = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    var textField = UITextField()
                    
                    let alert = UIAlertController(title: "Edit Name", message: "", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Save", style: .default) { (action) in
                        let editCategory = Category()
                        editCategory.name = textField.text!
                        self.save(category: editCategory)
                    }
                    //Cancel Button Alert Display
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    alert.addAction(action)
                    
                    //Edit Placeholder display in alert window
                    alert.addTextField {(alertTextField) in
                        alertTextField.placeholder = "Edit Name"
                        textField = alertTextField
                    }
                    present(alert, animated: true, completion: nil)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Create a New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default){ (action) in
            let newCategory = Category()
            newCategory.name = textField.text!.capitalized
            self.save(category: newCategory)
        }
        alert.addAction(action)
        alert.addTextField {(alertTextField) in
            alertTextField.placeholder = "Create a Category"
            textField = alertTextField
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ToItemList", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let destinationVC = segue.destination as! TaskClosingViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
}


