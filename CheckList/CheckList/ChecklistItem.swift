//
//  ChecklistItem.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 03/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import Foundation

class ChecklistItem {
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
    
}