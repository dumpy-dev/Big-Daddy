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

    let realm = try! Realm()
    var viewCountData:Results<UserDataRealm> {
        get {
            return realm.objects(UserDataRealm.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("this is the view count: \(viewCountData.count)")
        
        if viewCountData.count == 0 {
                        print("new view")
                        let newViewRegistered = 1
                        let primaryKey = "First View"
            let viewCountRealm = UserDataRealm()
                       // let viewCountRealm = realm.object(ofType: UserDataRealm.self, forPrimaryKey: primaryKey)
                        viewCountRealm.viewCount = 1
            viewCountRealm.primaryKey = "ViewCounter"
                        try! self.realm.write({
                            self.realm.add(viewCountRealm)
                        })
      
        } else {
            print("not new view")
        }
            
//            print("new view")
//            let newViewRegistered = 1
//            let primaryKey = "First View"
//            let viewCountRealm = realm.object(ofType: UserDataRealm.self, forPrimaryKey: primaryKey)
//            viewCountRealm!.viewCount = 1
//            try! self.realm.write({
//                self.realm.add(viewCountRealm!)
//            })
//        } else {
//            print("not new view")
//        }
        
//        let currentViewCount = viewCountData
//        print("this is the inital view count: \(currentViewCount)")
//        //let updatedViewCount = currentViewCount.viewCount + 1
//        
//        let numberOfViews = UserDataRealm()
//        //numberOfViews.viewCount = updatedViewCount
//        try! self.realm.write({
//            self.realm.add(numberOfViews, update: true)
//        })
//        let newViewCount = viewCountData[0].viewCount
//        print("this is the new view count: \(newViewCount)")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view appeared")
        if let numberOfViews = UserDefaults.standard.object(forKey: "newViews") {
            print("this screen has already been viewed before")
             let viewCount = 2
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
