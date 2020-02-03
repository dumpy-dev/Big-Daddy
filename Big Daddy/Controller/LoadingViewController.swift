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
    
    let receiptFetcher = ReceiptFetcher()
    var fullVersionUnlocked = UserDefaults.standard.bool(forKey: "fullVersionUnlocked")
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("**LOADING SCREEN** Is full version unlocked? \(fullVersionUnlocked)")

        let realm = try! Realm()
        var viewCountData:Results<UserDataRealm> {
            get {
                return realm.objects(UserDataRealm.self)
            }
        }
        
//        receiptFetcher.fetchReceipt()
//        let receiptValidator = ReceiptValidator()
//        let validationResult = receiptValidator.validateReceipt()
//
//        switch validationResult {
//        case .success(let receipt):
//            grantPremiumToPreviousUser(receipt: receipt)
//            print("original app version is \(receipt.originalAppVersion ?? "n/a")")
//        case .error(let error):
//            // receipt validation failed, refer to enum ReceiptValidationError
//            print("error is \(error.localizedDescription)")
//        }
    }
    
//    func grantPremiumToPreviousUser(receipt: ParsedReceipt) {
//        guard let originalAppVersionString = receipt.originalAppVersion,
//            let originalBuildNumber = Double(originalAppVersionString) else {
//                return
//            }
//        // the last build number that the app is still a paid app (build 9, version 1.3.0)
//        if originalBuildNumber < 10 {
//            fullVersionUnlocked = true
//            UserDefaults.standard.set(true, forKey: "fullVersionUnlocked")
//            print("Full version is unlocked as earlier version already purchased: \(fullVersionUnlocked)")
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    override func viewDidAppear(_ animated: Bool) {        
        if let numberOfViews = UserDefaults.standard.object(forKey: "newViews") {
            let viewCount = numberOfViews as! Int + 1
            UserDefaults.standard.set(viewCount, forKey: "newViews")
            self.performSegue(withIdentifier: "secondUseSegue", sender: self)
        } else {
            let shared = UserDefaults.standard
            let newViews = 1
            shared.set(newViews, forKey: "newViews")
            self.performSegue(withIdentifier: "firstUseSegue", sender: self)
        }
    }
}
