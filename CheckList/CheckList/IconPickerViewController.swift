//
//  IconPickerViewController.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 31/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import UIKit

class IconPickerViewController: UITableViewController {
    let icons=["Appointments","Birthdays","Chores","Drinks","Folder","Groceries","Inbox","No Icon","Photos","Trips"]
    var delegate:IconPickerControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return icons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("IconCell", forIndexPath: indexPath)
        cell.textLabel?.text=icons[indexPath.row]
        cell.imageView?.image=UIImage(named:icons[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.iconPickerViewController(self, didFinishIcon: icons[indexPath.row])
    }
    
    
    
}

protocol IconPickerControllerDelegate{
    
    func iconPickerViewController(controller:IconPickerViewController, didFinishIcon iconName:String)
}


