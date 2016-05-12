//
//  Checklist.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 10/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import Foundation

class Checklist: NSObject, NSCoding {
    var name:String
    var items:[ChecklistItem]
    var iconName:String
    
    init(name:String,items:[ChecklistItem]=[ChecklistItem](),iconName:String="Folder") {
        self.name=name
        self.items=items
        self.iconName=iconName
    }
    
    func uncheckedItemsCount()->Int{
        let checkedItem=items.filter({$0.checked==false})
        return checkedItem.count
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let name=aDecoder.decodeObjectForKey("name") as? String, let items=aDecoder.decodeObjectForKey("items") as? [ChecklistItem], let iconName=aDecoder.decodeObjectForKey("iconName") as? String
            else{return nil}
        self.init(
            name: name,
            items: items,
            iconName: iconName
        )
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.items, forKey: "items")
        aCoder.encodeObject(self.iconName, forKey:"iconName")
    }

}
