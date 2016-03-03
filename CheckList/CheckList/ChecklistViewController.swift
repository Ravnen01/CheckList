//
//  ChecklistViewController.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 03/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
   

    var listItem=[ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item1=ChecklistItem(text: "Test1")
        let item2=ChecklistItem(text: "Test2", checked: true)
        let item3=ChecklistItem(text: "Text3", checked: true)
        listItem+=[item1,item2,item3]

        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return listItem.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
        configureTextForCell(cell, withItem: listItem[indexPath.row])
        configureCheckmarkForCell(cell, withItem: listItem[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, withItem item: ChecklistItem){
        if item.checked{
            cell.accessoryType = .Checkmark
        }else{
            cell.accessoryType = .None
        }
    }
    func configureTextForCell(cell: UITableViewCell, withItem item: ChecklistItem){
        cell.textLabel?.text=item.text
    }
    
    override func tableView(tableView: UITableView,willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?{
        listItem[indexPath.item].toggleChecked()
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        return indexPath
    }
    
    @IBAction func addDummyTodo(sender: AnyObject) {
        
        let newIndexPath = NSIndexPath(forRow: listItem.count, inSection: 0)
        listItem+=[ChecklistItem(text: "Dummy", checked: false)]
        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        
    }
    override func tableView(_tableView: UITableView,commitEditingStyle editingStyle: UITableViewCellEditingStyle,forRowAtIndexPath indexPath: NSIndexPath){
        listItem.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
}

