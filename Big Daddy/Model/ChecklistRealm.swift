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
    
}

class ContractionCounterRealm: Object {
    
    @objc dynamic var timeOfDay : Date? = nil
    @objc dynamic var lengthOfContraction = 0
    @objc dynamic var interval : Int = 0
    @objc dynamic var strengthOfContraction : Int = 0
    
}

class ContractionCounterIntervalRealm: Object {
    @objc dynamic var interval : Int = 0
    
}
