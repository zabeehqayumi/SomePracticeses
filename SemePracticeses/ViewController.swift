//
//  ViewController.swift
//  SemePracticeses
//
//  Created by Zabeehullah Qayumi on 9/15/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var itemArrary = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
            loadItems()

    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var newTextFiled = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "Please add you fav item", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //Keep in mind
            
            let newItem = Item(context: self.context)
            newItem.title = newTextFiled.text!
            newItem.done = false
            self.itemArrary.append(newItem)
            self.saveItems()
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Please type here"
            newTextFiled = textField
        }
        
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
}

extension ViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArrary.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = itemArrary[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
    
    func saveItems(){
        do{
            try context.save()
        }catch{
            return
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArrary = try context.fetch(request)
        }
        catch{
            print("")
        }
   
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = itemArrary[indexPath.row]
        item.done = !item.done
        saveItems()
    }
}

























