//
//  SecondViewController.swift
//  TodoApp
//
//  Created by EKbana on 21/09/2022.
//

import UIKit

protocol TextDelegate: NSObject {
    func showText()
}

class SecondViewController: UIViewController {
    
    enum ViewType {
        case fromPlus
        case fromActionsheet
    }

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var todoTextField: UITextField!
    weak var delegate: TextDelegate?
    var type: ViewType = .fromPlus
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var todoItem: TodoItemList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if type == .fromActionsheet {
            todoTextField.text = todoItem?.name
            button.setTitle("Update List", for: .normal)
        } else {
            button.setTitle("Add List", for: .normal)

        }
    }
    @IBAction func addButton(_ sender: Any) {
        
        if type == .fromPlus {
        
        let createNew =  TodoItemList(context: context)
        createNew.name = todoTextField.text
        createNew.createdAt = Date()

        do{
            try context.save()
            dismiss(animated: true)
           
//            changeDeleate?.logoChange(image: UIImage.firstLogo)
        } catch {

        }
            
        } else {
            todoItem?.name = todoTextField.text

            do{
                try context.save()
                dismiss(animated: true)
                delegate?.showText()
            } catch {

            }
        }
        
    }
//    func createItem(name: String) {
//        let createNew =  TodoItemList(context: context)
//        createNew.name = todoTextField.text
//        createNew.createdAt = Date()
//
//        do{
//            try context.save()
//        } catch {
//
//        }
//    }


}
