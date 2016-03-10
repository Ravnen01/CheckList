//
//  ListDetailViewController.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 10/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController {

    @IBOutlet var done: UIBarButtonItem!
    @IBOutlet var textField: UITextField!
    
    var delegate:ListDetailViewControllerDelegate?
    
    var itemToEdit:Checklist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        done.enabled=false
        if let _=itemToEdit{
            textField.text=itemToEdit?.name
            title="EditList"
        }else{
            textField.text=""
            title="AddList"
        }
    }
    

    @IBAction func doneAction(sender: AnyObject) {
        if textField.text! != ""{
            if let _=itemToEdit{
                itemToEdit?.name=textField.text!
                
            }else{
                itemToEdit=Checklist(name: textField.text!)
            }
            delegate?.listDetailViewController(self,didFinishItem: itemToEdit!)
        }
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    override func viewWillAppear(animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        let beforeText: NSString = textField.text!
        let afterText: NSString = beforeText.stringByReplacingCharactersInRange(range, withString: string)

        done.enabled = afterText.length>0
        return true
    }
    
}

protocol ListDetailViewControllerDelegate{
    func listDetailViewControllerDidCancel(controller:ListDetailViewController)
    func listDetailViewController(controller:ListDetailViewController, didFinishItem item:Checklist)
}
