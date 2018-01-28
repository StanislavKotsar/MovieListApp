//
//  TableViewController.swift
//  MovieListApp
//
//  Created by Станислав Коцарь on 28.01.2018.
//  Copyright © 2018 Станислав Коцарь. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)

         cell.textLabel?.text = categories[indexPath.row].name

        return cell
    }
    
    func loadCategories (with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
           categories = try context.fetch(request)
        } catch {
            print("\(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
    func saveCategories() {
        do{
            try context.save()
        } catch {
            print(error)
        }
        
        tableView.reloadData()
    }

    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new movie category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            let category = Category(context: self.context)
            category.name = textfield.text!
            self.categories.append(category)
            self.saveCategories()
            self.tableView.reloadData()
        }
        
        alert.addTextField { (field) in
            field.placeholder = "Add new category"
            textfield = field
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    

}
