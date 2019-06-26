//
//  LoadingViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 13/10/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit
import RealmSwift

class LoadingViewController: UIViewController {

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let realm = try! Realm()
        var viewCountData:Results<UserDataRealm> {
            get {
                return realm.objects(UserDataRealm.self)
            }
        }
        
//        if viewCountData.count == 0 {
//                        print("new view")
//                        let newViewRegistered = 1
//                        let primaryKey = "First View"
//            let viewCountRealm = UserDataRealm()
//                       // let viewCountRealm = realm.object(ofType: UserDataRealm.self, forPrimaryKey: primaryKey)
//                        viewCountRealm.viewCount = 1
//            viewCountRealm.primaryKey = "ViewCounter"
//                        try! self.realm.write({
//                            self.realm.add(viewCountRealm)
//                        })
//      
//        } else {
//            print("not new view")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let numberOfViews = UserDefaults.standard.object(forKey: "newViews") {
            print("this screen has already been viewed before")
            let viewCount = numberOfViews as! Int + 1
            UserDefaults.standard.set(viewCount, forKey: "newViews")
             performSegue(withIdentifier: "secondUseSegue", sender: self)
        } else {
            let shared = UserDefaults.standard
            let newViews = 1
            shared.set(newViews, forKey: "newViews")
            print(newViews)
        performSegue(withIdentifier: "firstUseSegue", sender: self)
        }
    }
}
