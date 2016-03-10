//
//  ItemDetailViewController.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 03/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController {
    
    
   
    @IBOutlet var bDone: UIBarButtonItem!
    @IBOutlet var textField: UITextField!
    
    var delegate:ItemDetailViewControllerDelegate?
    
    var itemToEdit:ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bDone.enabled=false
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
            delegate?.itemDetailViewController(self,didFinishItem: itemToEdit!)
        }
    }

    @IBAction func cancel(sender: AnyObject) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        let beforeText: NSString = textField.text!
        let afterText: NSString = beforeText.stringByReplacingCharactersInRange(range, withString: string)
        
        
        bDone.enabled = afterText.length>0
        return true
    }

    
    
}

protocol ItemDetailViewControllerDelegate: class{
    func itemDetailViewControllerDidCancel(controller:ItemDetailViewController)
    func itemDetailViewController(controller:ItemDetailViewController, didFinishItem item:ChecklistItem)
}
