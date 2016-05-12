//
//  AllLidtViewController.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 10/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//
import UIKit
class AllLidtViewController: UITableViewController, ListDetailViewControllerDelegate {
    
    var lists=[Checklist]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NSUserDefaults.standardUserDefaults().registerDefaults([
            "FirstLaunch":true
            ])
        
        if(NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")){
            let list=[ChecklistItem]([
                ChecklistItem(text: "Edit your first item"),
                ChecklistItem(text: "Swipe me to delete")
                ])
            lists=[Checklist]([
                Checklist(name: "List", items: list, iconName: "Folder")
                ])
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "FirstLaunch")
            
        }else{
            lists=DataModel.sharedInstance.listItem
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return lists.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("CheckListCell", forIndexPath: indexPath)
        cell.textLabel!.text=lists[indexPath.row].name
        let numberOfChecked=lists[indexPath.row].uncheckedItemsCount()
        if lists[indexPath.row].items.count != 0{
            if numberOfChecked==0{
                cell.detailTextLabel?.text="All Done!"
            }else{
                cell.detailTextLabel?.text=String(numberOfChecked)
            }
        }else{
            cell.detailTextLabel?.text="(No Item)"
        }
        cell.imageView?.image=UIImage(named:lists[indexPath.row].iconName)
        return cell
    }
    
    override func awakeFromNib() {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier=="CheckToList"{
         let destination=segue.destinationViewController as! ChecklistViewController
            let itemSelected=tableView.indexPathForCell(sender as!UITableViewCell)?.row
            destination.list=lists[itemSelected!]
        }
        
        if segue.identifier=="AddList"{
            let navigationController=segue.destinationViewController as! UINavigationController
            let destination=navigationController.viewControllers[0] as! ListDetailViewController
            destination.delegate=self
            
        }
        
        if segue.identifier=="EditList"{
            
            let navigationController=segue.destinationViewController as! UINavigationController
            let destination=navigationController.viewControllers[0] as! ListDetailViewController
            destination.delegate=self
            let itemSelected=tableView.indexPathForCell(sender as!UITableViewCell)?.row
            destination.itemToEdit=lists[itemSelected!]
        }
    }
    
    
    func listDetailViewControllerDidCancel(controller:ListDetailViewController){
        controller.dismissViewControllerAnimated(true, completion: {})
    }
    
    func listDetailViewController(controller:ListDetailViewController, didFinishItem item:Checklist){
        controller.dismissViewControllerAnimated(true, completion: {})
        
        if let indexItem=lists.indexOf({$0===item}){
            lists[indexItem]=item
            DataModel.sharedInstance.listItem=lists
            let newIndexPath = NSIndexPath(forRow: indexItem, inSection: 0)
            tableView.reloadRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }else{
            let newIndexPath = NSIndexPath(forRow: lists.count, inSection: 0)
            lists+=[item]
            DataModel.sharedInstance.listItem=lists
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    
    
}
