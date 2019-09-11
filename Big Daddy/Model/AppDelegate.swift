//
//  AppDelegate.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 03/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var fullVersionUnlocked = UserDefaults.standard.bool(forKey: "fullVersionUnlocked")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IAPService.shared.getProducts()
//        if UserDefaults.standard.bool(forKey: "fullVersionUnlocked") != true {
//        IAPService.shared.restorePurchases()
//        }
        let receiptFetcher = ReceiptFetcher()
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            print("Message from App Delegate: The current app version is: \(version)")
        }
        receiptFetcher.fetchReceipt()
        let receiptValidator = ReceiptValidator()
        let validationResult = receiptValidator.validateReceipt()
        
        switch validationResult {
        case .success(let receipt):
            grantPremiumToPreviousUser(receipt: receipt)
            print("Message from App Delegate: Original app version is \(receipt.originalAppVersion ?? "n/a")")
            UserDefaults.standard.set(receipt.originalAppVersion, forKey: "originalBuildNumber")
        case .error(let error):
            // receipt validation failed, refer to enum ReceiptValidationError
            print("Message from App Delegate: error is \(error.localizedDescription)")
            
        }
        
        
        
        

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            print("Message from App Delegate: Is notification display granted? *** \(granted) ***")
        }

        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    
                    migration.enumerateObjects(ofType: ContractionCounterRealm.className()) { (_, newRealm) in
                        newRealm?["intervalString"] = ""
                    
                    }
                    
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
         // let realm = try! Realm()
    
        
        return true
        
    
    }

    func grantPremiumToPreviousUser(receipt: ParsedReceipt) {
        guard let originalAppVersionString = receipt.originalAppVersion,
            let originalBuildNumber = Double(originalAppVersionString) else {
                return
        }
       
        // the last build number that the app is still a paid app (build 9, version 1.3.0)
        
        print("Message from App Delegate: Build Number: \(originalBuildNumber)")
        if originalBuildNumber < 13 {
            fullVersionUnlocked = true
            UserDefaults.standard.set(true, forKey: "fullVersionUnlocked")
            print("Message from App Delegate: Full version is unlocked as earlier version already purchased: \(fullVersionUnlocked)")
        }
    }
    
    func restoreComplete() {
        print("Message from App Delegate: restore completed")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

