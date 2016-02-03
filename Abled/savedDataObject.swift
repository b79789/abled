//
//  savedDataObject.swift
//  Abled
//
//  Created by Brian Stacks on 2/2/16.
//  Copyright © 2016 Brian Stacks. All rights reserved.
//

import Foundation
class savedDataObject: NSObject {
    
    var name: String = ""
    var address: String = ""
    var type: String = ""
    var pic: String = ""
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(address, forKey: "address")
        aCoder.encodeObject(type, forKey: "type")
        aCoder.encodeObject(pic, forKey: "pic")

    }
    
    init(coder aDecoder: NSCoder!) {
        name = aDecoder.decodeObjectForKey("name") as! String
        address = aDecoder.decodeObjectForKey("address") as! String
        type = aDecoder.decodeObjectForKey("type") as! String
        pic = aDecoder.decodeObjectForKey("pic") as! String
    }
    
    override init() {
    }
}