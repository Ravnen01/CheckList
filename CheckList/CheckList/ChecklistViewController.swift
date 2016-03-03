//
//  ChecklistViewController.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 03/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController ,AddItemViewControllerDelegate {
    
   

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
        let label=cell.viewWithTag(1) as! UILabel
        if item.checked{
            label.text="✔"
        }else{
            label.text=""
        }
    }
    func configureTextForCell(cell: UITableViewCell, withItem item: ChecklistItem){
        let label=cell.viewWithTag(2) as! UILabel
        label.text=item.text
        
    }
    
    override func tableView(tableView: UITableView,willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?{
        listItem[indexPath.item].toggleChecked()
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        return indexPath
    }
    
    
    override func tableView(_tableView: UITableView,commitEditingStyle editingStyle: UITableViewCellEditingStyle,forRowAtIndexPath indexPath: NSIndexPath){
        listItem.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func addItemViewControllerDidCancel(controller:AddItemViewController){
        controller.dismissViewControllerAnimated(true, completion: {})
    }
    
    func addItemViewController(controller:AddItemViewController, didFinishAddingItem item:ChecklistItem,update:Bool,index:Int){
        controller.dismissViewControllerAnimated(true, completion: {})
        if update{
            listItem[index]=item
            let newIndexPath = NSIndexPath(forRow: index, inSection: 0)
            tableView.reloadRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }else{
            let newIndexPath = NSIndexPath(forRow: listItem.count, inSection: 0)
            listItem+=[item]
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }
        
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="AddItem"{
            let navigationController=segue.destinationViewController as! UINavigationController
            let destination=navigationController.viewControllers[0] as! AddItemViewController
            destination.delegate=self
            destination.text=""
            destination.indexItem=0;
            destination.update=false
        }
        
        if segue.identifier=="EditItem"{
            
            let navigationController=segue.destinationViewController as! UINavigationController
            let destination=navigationController.viewControllers[0] as! AddItemViewController
            destination.delegate=self
            let itemSelected=tableView.indexPathForCell(sender as!UITableViewCell)?.row
            destination.text=listItem[itemSelected!].text
            destination.indexItem=itemSelected!;
            destination.update=true
        }
    }
    
}

