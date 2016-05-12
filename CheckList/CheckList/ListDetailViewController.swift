//
//  ListDetailViewController.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 10/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController, IconPickerControllerDelegate {

    @IBOutlet var done: UIBarButtonItem!
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var icon: UIImageView!
    var delegate:ListDetailViewControllerDelegate?
    
    var itemToEdit:Checklist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        done.enabled=false
        if let _=itemToEdit{
            textField.text=itemToEdit?.name
            icon.image=UIImage(named: (itemToEdit?.iconName)!)
            title="EditList"
        }else{
            textField.text=""
            title="AddList"
            icon.image=UIImage(named: "Folder")
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
    
    func iconPickerViewController(controller: IconPickerViewController, didFinishIcon iconName: String) {
        self.navigationController?.popViewControllerAnimated(true)
        icon.image=UIImage(named: iconName)
        itemToEdit?.iconName=iconName
        if (textField.text) != nil{
                self.done.enabled=true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="IconChoise"{
            let destination=segue.destinationViewController as! IconPickerViewController
            destination.delegate=self
        }
    }
    
}

protocol ListDetailViewControllerDelegate{
    func listDetailViewControllerDidCancel(controller:ListDetailViewController)
    func listDetailViewController(controller:ListDetailViewController, didFinishItem item:Checklist)
}
