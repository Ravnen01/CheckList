//
//  Checklist.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 10/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import Foundation

class Checklist: NSObject {
    var name:String
    var items:[ChecklistItem]
    
    init(name:String,items:[ChecklistItem]=[ChecklistItem]()) {
        self.name=name
        self.items=items
    }
}
