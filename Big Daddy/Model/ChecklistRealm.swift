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
    
    @objc dynamic var item = ""
    @objc dynamic var itemPacked = false
    @objc dynamic var name = ""
    
}

class NameRealm: Object {
    
    @objc dynamic var name = ""
}

class BabyChecklistRealm: Object {
    
    @objc dynamic var babyItem = ""
    @objc dynamic var itemCompleted = false
    @objc dynamic var name = ""
    @objc dynamic var category = ""
    override static func primaryKey() -> String? {
        return "name"
    }
    
    
}

class ContractionCounterRealm: Object {
    
    @objc dynamic var timeOfDay : Date? = nil
    @objc dynamic var lengthOfContraction : String = ""
    @objc dynamic var intervalString : String = ""
   // @objc dynamic var interval : String = ""
    @objc dynamic var strengthOfContraction : Int = 0
    
}

//class ContractionCounterIntervalRealm: Object {
//    @objc dynamic var interval : Int = 0
//    @objc dynamic var intervalTime : String = ""
//}

class UserDataRealm: Object {
    @objc dynamic var viewCount : Int = 0
    @objc dynamic var primaryKey : String = ""
    override static func primaryKey() -> String? {
        return "primaryKey"
    }
}
