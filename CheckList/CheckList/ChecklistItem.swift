//
//  ChecklistItem.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 03/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
    var text:String
    var checked:Bool
    var dueDate:NSDate
    var shouldRemind:Bool;
    var itemID:Int;
    
    
    init(text:String,checked:Bool=false,shouldRemind:Bool=false,dueDate:NSDate=NSDate()){
        
        self.text=text
        self.dueDate=dueDate
        self.checked=checked
        self.shouldRemind=shouldRemind
        self.itemID=0
        super.init()
        
    }
    
    func toggleChecked(){
        if checked{
            checked=false
        }else{
            checked=true
        }
    }
    
    // MARK:NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let text=aDecoder.decodeObjectForKey("text") as? String, let dueDate=aDecoder.decodeObjectForKey("dueDate") as? NSDate
            else{return nil}
        self.init(
            text: text,
            checked: aDecoder.decodeBoolForKey("checked"),
            shouldRemind: aDecoder.decodeBoolForKey("shouldRemind"),
            dueDate: dueDate
        )
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.text, forKey: "text")
        aCoder.encodeBool(self.checked, forKey: "checked")
        aCoder.encodeBool(self.shouldRemind, forKey: "shouldRemind")
        aCoder.encodeObject(self.dueDate,forKey: "dueDate")
    }
    
    
}
func == (lhs: ChecklistItem, rhs: ChecklistItem)->Bool{
    return (lhs.text==rhs.text)
}