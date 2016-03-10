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
    
    init(text:String,checked:Bool=false){
        self.text=text
        
        self.checked=checked
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
        guard let text=aDecoder.decodeObjectForKey("text") as? String
            else{return nil}
        self.init(
            text: text,
            checked: aDecoder.decodeBoolForKey("checked")
        )
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.text, forKey: "text")
        aCoder.encodeBool(self.checked, forKey: "checked")
    }
    
    
}
func == (lhs: ChecklistItem, rhs: ChecklistItem)->Bool{
    return (lhs.text==rhs.text)
}