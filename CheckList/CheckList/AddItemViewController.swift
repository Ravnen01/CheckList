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
    
    var update:Bool?
    var text:String?
    var indexItem:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text=text
        if self.update!{
            title="EditItem"
            bDone.enabled=true
        }else{
            bDone.enabled=false
        }
        
    }
    
    @IBAction func done(sender: AnyObject) {
        delegate?.addItemViewController(self,didFinishAddingItem: ChecklistItem(text: textField!.text!),update:update!,index:indexItem!)
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
