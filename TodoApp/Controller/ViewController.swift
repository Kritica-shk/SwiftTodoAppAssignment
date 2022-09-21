//
//  ViewController.swift
//  TodoApp
//
//  Created by EKbana on 21/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [TodoItemList]()
    
    //MARK: - methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        //function call
        getAllData()
        
        //add button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc private func addButtonTapped() {
        let stordboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = stordboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        controller.delegate = self
        present(controller, animated: true)
    }
    
    func getAllData() {
        do{
            models = try context.fetch(TodoItemList.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch(let err){
            print(err.localizedDescription)
        }
    }
    
    func deleteItem(item: TodoItemList) {
        context.delete(item)
        
        do {
            try context.save()
            getAllData()
        } catch{
            
        }
    }
}

//MARK: - Extensions
extension ViewController: TextDelegate {
    func showText() {
        getAllData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.nameLabel.text = models[indexPath.row].name
        cell.dateLabel.text =  models[indexPath.row].createdAt!.dateToString()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        
        let sheet = UIAlertController(title: "Settings", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            
            let stordboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = stordboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
            controller.delegate = self
            controller.todoItem = self.models[indexPath.row]
            controller.type = .fromActionsheet
            self.present(controller, animated: true)
        }))
        
        //delete
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        present(sheet, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = models[indexPath.row]
        
        if editingStyle == .delete{
            self.deleteItem(item: item)
        }
    }
    
}

