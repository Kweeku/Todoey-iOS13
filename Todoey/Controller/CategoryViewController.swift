//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Benedict Adu on 06/05/2026.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }


    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let category = categories?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = category?.name ?? "No Categories added yet"

        
        return cell
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func save(category : Category) {
        
        do {
            try realm.write{
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
            
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)

        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            let newCategory = Category()
            newCategory.name = textField.text!
           
            self.save(category: newCategory)
            
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add a new catgeory"
            textField = alertTextField
        }
        
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }
    

    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let IndexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[IndexPath.row]
        }
    }
    
    
}
