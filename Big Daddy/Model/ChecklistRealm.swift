//
//  ChecklistRealm.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 30/06/2018.
//Copyright © 2018 Dumpy Developments. All rights reserved.
//

import Foundation
import RealmSwift

class ChecklistRealm: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var item = ""
    @objc dynamic var itemPacked = false
    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
