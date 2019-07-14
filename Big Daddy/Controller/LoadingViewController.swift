//
//  LoadingViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 13/10/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit
import RealmSwift
import StoreKit

class LoadingViewController: UIViewController {
    
    public typealias ProductIdentifier = String
    private let productIdentifiers: Set<ProductIdentifier> = []
    private var purchasedProductIdentifiers: Set<ProductIdentifier> = []
    private var productIds: Set<ProductIdentifier> = []
    
//    init(productIds: Set<ProductIdentifier>) {
//        productIdentifiers = productIds
//        for productIdentifier in productIds {
//            let purchased = UserDefaults.standard.bool(forKey: productIdentifier)
//            if purchased {
//                purchasedProductIdentifiers.insert(productIdentifier)
//                print("Previously purchased: \(productIdentifier)")
//            } else {
//                print("Not purchased: \(productIdentifier)")
//            }
//        }
//     super.init(nibName: nil, bundle: nil)
//
//      //  SKPaymentQueue.default().add(self)
//    }
    
 
    
 
    
//    func isProductPurchased(_ productIdentifier: ProductIdentifier) -> Bool {
//        return purchasedProductIdentifiers.contains(productIdentifier)
//    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let product = "com.dumpy.BigDaddy.fullVersion"
        
       // print("The result of the purchase: \(isProductPurchased(product))")
        
        
//        for productIdentifier in productIds {
//            let purchased = UserDefaults.standard.bool(forKey: productIdentifier)
//            if purchased {
//                purchasedProductIdentifiers.insert(productIdentifier)
//                print("Previously purchased: \(productIdentifier)")
//            } else {
//                print("Not purchased: \(productIdentifier)")
//            }
//        }

        
        
        
        
        
        
        
        let realm = try! Realm()
        var viewCountData:Results<UserDataRealm> {
            get {
                return realm.objects(UserDataRealm.self)
            }
        }
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
  
    
    
    override func viewDidAppear(_ animated: Bool) {
        
      
        
       var fullVersionUnlocked = UserDefaults.standard.bool(forKey: "fullVersionUnlocked")
        
        if fullVersionUnlocked == true {
            print(fullVersionUnlocked)
        } else if fullVersionUnlocked == false {
            print(fullVersionUnlocked)
        }
        
       // print("Full version unlocked is : \(fullVersionUnlocked)")
        
        if let numberOfViews = UserDefaults.standard.object(forKey: "newViews") {
            print("this screen has already been viewed before")
            let viewCount = numberOfViews as! Int + 1
            UserDefaults.standard.set(viewCount, forKey: "newViews")
            self.performSegue(withIdentifier: "secondUseSegue", sender: self)
        } else {
            let shared = UserDefaults.standard
            let newViews = 1
            shared.set(newViews, forKey: "newViews")
            print(newViews)
            self.performSegue(withIdentifier: "firstUseSegue", sender: self)
        }
        

}
}
