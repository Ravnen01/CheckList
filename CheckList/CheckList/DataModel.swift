//
//  DataModel.swift
//  CheckList
//
//  Created by Corentin LECOMTE on 31/03/2016.
//  Copyright © 2016 LECOR. All rights reserved.
//

import Foundation

class DataModel{
    var listItem=[Checklist]()
    static let sharedInstance=DataModel()
    
    private init(){
        
        awakeFromNib()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DataModel.saveChecklistItems), name: "UIApplicationDidEnterBackgroundNotification", object: nil)
        
    }
    @objc func saveChecklistItems(){
        NSKeyedArchiver.archiveRootObject(listItem, toFile: dataFileUrl().path!)
    }
    
    
    func documentDirectory()->NSURL{
        let paths=NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return paths[0]
    }
    
    func dataFileUrl()->NSURL{
        let file=NSURL.init(fileURLWithPath: "Checklists.plist", isDirectory: false, relativeToURL: documentDirectory())
        
        return file
    }
    @objc func loadChecklistItem(){
        let Items=NSKeyedUnarchiver.unarchiveObjectWithFile(dataFileUrl().path!) as? [Checklist]
        if Items != nil{
                listItem=Items!
            }else{
                listItem=[Checklist]()
            }
        listItem=sortCheckLists()
        
    }
    
    @objc func awakeFromNib() {
                loadChecklistItem()
    }
    
    func sortCheckLists() ->[Checklist]{
        return listItem.sort({$0.0.name.localizedStandardCompare($0.1.name) == NSComparisonResult.OrderedAscending})
    }
    
}