//
//  ViewController.swift
//  Todoey
//
//  Created by Shweta on 6/26/19.
//  Copyright © 2019 Nazima. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

   
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "buy potatoes"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "bring laundary"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "bring eggs"
        itemArray.append(newItem3)
       
        if let items = defaults.array(forKey: "ToDoList") as? [Item] {
            itemArray = items
       }
    }
    
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ?  .checkmark :  .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
    }

    
    @IBAction func addItemPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           
            let newItem = Item()
            newItem.title = textField.text ?? ""
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoList")
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
}

