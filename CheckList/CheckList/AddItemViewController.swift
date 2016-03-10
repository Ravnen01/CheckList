//
//  AddItemViewController.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 03/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    
   
    @IBOutlet var bDone: UIBarButtonItem!
    @IBOutlet var textField: UITextField!
    
    var delegate:AddItemViewControllerDelegate?
    
    var itemToEdit:ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _=itemToEdit{
          textField.text=itemToEdit?.text
            title="EditItem"
        }else{
            textField.text=""
            title="AddItem"
        }
        
        
    }
    
    @IBAction func done(sender: AnyObject) {
        if textField.text! != ""{
            if let _=itemToEdit{
                itemToEdit?.text=textField.text!
                itemToEdit?.checked=false
            }else{
                itemToEdit=ChecklistItem(text: textField.text!)
            }
            delegate?.addItemViewController(self,didFinishAddingItem: itemToEdit!)
        }
    }

    @IBAction func cancel(sender: AnyObject) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        let beforeText: NSString = textField.text!
        let afterText: NSString = beforeText.stringByReplacingCharactersInRange(range, withString: string)
        
        if afterText.length > 0 {
            bDone.enabled = true
        } else {
            bDone.enabled = false
        }
        
        return true
    }

    
    
}
