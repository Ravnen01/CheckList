//
//  ChecklistViewController.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 03/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController ,ItemDetailViewControllerDelegate {
    
   

    var listItem=[ChecklistItem]()
    var list: Checklist!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title=list.name
        
        print(dataFileUrl().path!)

        
        
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
        //saveChecklistItems()
        return indexPath
    }
    
    
    override func tableView(_tableView: UITableView,commitEditingStyle editingStyle: UITableViewCellEditingStyle,forRowAtIndexPath indexPath: NSIndexPath){
        listItem.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        //saveChecklistItems()
    }
    
    func itemDetailViewControllerDidCancel(controller:ItemDetailViewController){
        controller.dismissViewControllerAnimated(true, completion: {})
    }
    
    func itemDetailViewController(controller:ItemDetailViewController, didFinishItem item:ChecklistItem){
        controller.dismissViewControllerAnimated(true, completion: {})
        
        if let indexItem=listItem.indexOf({$0===item}){
            listItem[indexItem]=item
            let newIndexPath = NSIndexPath(forRow: indexItem, inSection: 0)
            tableView.reloadRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }else{
            let newIndexPath = NSIndexPath(forRow: listItem.count, inSection: 0)
            listItem+=[item]
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }
        //saveChecklistItems()
        
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="AddItem"{
            let navigationController=segue.destinationViewController as! UINavigationController
            let destination=navigationController.viewControllers[0] as! ItemDetailViewController
            destination.delegate=self
            
        }
        
        if segue.identifier=="EditItem"{
            
            let navigationController=segue.destinationViewController as! UINavigationController
            let destination=navigationController.viewControllers[0] as! ItemDetailViewController
            destination.delegate=self
            let itemSelected=tableView.indexPathForCell(sender as!UITableViewCell)?.row
            destination.itemToEdit=listItem[itemSelected!]
        }
    }
    
    func documentDirectory()->NSURL{
        let paths=NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return paths[0]
    }
    
    func dataFileUrl()->NSURL{
        let file=NSURL.init(fileURLWithPath: "Checklists.plist", isDirectory: false, relativeToURL: documentDirectory())
        
        return file
    }
    
//    func saveChecklistItems(){
//        NSKeyedArchiver.archiveRootObject(listItem, toFile: dataFileUrl().path!)
//    }
//    
//    func loadChecklistItem(){
//        let Items=NSKeyedUnarchiver.unarchiveObjectWithFile(dataFileUrl().path!) as? [ChecklistItem]
//        if Items != nil{
//            listItem=Items!
//        }else{
//            listItem=[ChecklistItem]()
//        }
//        
//    }
//    
//    override func awakeFromNib() {
//        loadChecklistItem()
//    }
}

