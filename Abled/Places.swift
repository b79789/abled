//
//  Places.swift
//  Abled
//
//  Created by Brian Stacks on 2/5/16.
//  Copyright © 2016 Brian Stacks. All rights reserved.
//

import Foundation
import Parse


class Places: PFObject, PFSubclassing {
    
    @NSManaged var displayName: String
    @NSManaged var displayAddress: String
    @NSManaged var displayType: String
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
            }
        }
    
        class func parseClassName() -> String {
        
            return "Place"
        }
    }


