//
//  ViewController.swift
//  Shopping List
//
//  Created by Vlad Klunduk on 11/08/2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping list"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareItems))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func addItem(){
        let ac = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let action = UIAlertAction(title: "Add", style: .default){
            [weak ac, weak self] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.addItemInTable(item)
        }
        
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    func addItemInTable(_ item: String){
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func shareItems(){
        let arr = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [arr], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(vc, animated: true)
    }
}

