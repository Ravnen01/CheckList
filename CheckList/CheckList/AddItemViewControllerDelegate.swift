//
//  AddItemViewControllerDelegate.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 03/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import Foundation

protocol AddItemViewControllerDelegate: class{
    func addItemViewControllerDidCancel(controller:AddItemViewController)
    func addItemViewController(controller:AddItemViewController, didFinishAddingItem item:ChecklistItem, update:Bool,index:Int)
}