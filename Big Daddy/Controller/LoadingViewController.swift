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
    let receiptFetcher = ReceiptFetcher()


    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        var viewCountData:Results<UserDataRealm> {
            get {
                return realm.objects(UserDataRealm.self)
            }
        }
        
        receiptFetcher.fetchReceipt()
        let receiptValidator = ReceiptValidator()
        let validationResult = receiptValidator.validateReceipt()
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            print("The current app version is: \(version)")
        }
        switch validationResult {
        case .success(let receipt):
            // receipt validation success
            // Work with parsed receipt data.
            
            grantPremiumToPreviousUser(receipt: receipt)
            print("original app version is \(receipt.originalAppVersion ?? "n/a")")
        case .error(let error):
            // receipt validation failed, refer to enum ReceiptValidationError
            print("error is \(error.localizedDescription)")
        }
    }
    
    func grantPremiumToPreviousUser(receipt: ParsedReceipt) {
    // cast to Double to handle the "1.0" default value returned from sandbox
    // this also works with build number integer from production, eg: "37"
    guard let originalAppVersionString = receipt.originalAppVersion,
    let originalBuildNumber = Double(originalAppVersionString) else {
    return
    }
    
    // the last build number that the app is still a paid app
    if originalBuildNumber < 37 {
    // grant user premium feature here
    print("premium granted")
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
