//
//  ReceiptFetcher.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 29/07/2019.
//  Copyright © 2019 Dumpy Developments. All rights reserved.
//

import StoreKit

class ReceiptFetcher : NSObject, SKRequestDelegate {
    
    let receiptRefreshRequest = SKReceiptRefreshRequest()
    
    override init() {
        super.init()
        receiptRefreshRequest.delegate = self
    }
    
    func fetchReceipt() {
        print("fetching receipt")
        guard let receiptUrl = Bundle.main.appStoreReceiptURL else {
            print("unable to retrieve receipt url")
            return
        }
        
        do {
            // if the receipt does not exist, start refreshing
            let reachable = try receiptUrl.checkResourceIsReachable()
            
            // the receipt does not exist, start refreshing
            if reachable == false {
                receiptRefreshRequest.start()
            }
        } catch {
            // the receipt does not exist, start refreshing
            print("error: \(error.localizedDescription)")
            /*
             error: The file “sandboxReceipt” couldn’t be opened because there is no such file
             */
            receiptRefreshRequest.start()
        }
    }
    
    // MARK: SKRequestDelegate methods
    func requestDidFinish(_ request: SKRequest) {
        print("receipt fetching request finished successfully")
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("receipt fetching request failed with error \(error.localizedDescription)")
    }
    
//    func grantPremiumToPreviousUser(receipt: ParsedReceipt) {
//        // cast to Double to handle the "1.0" default value returned from sandbox
//        // this also works with build number integer from production, eg: "37"
//        guard let originalAppVersionString = receipt.originalAppVersion,
//            let originalBuildNumber = Double(originalAppVersionString) else {
//                return
//        }
//        
//        // the last build number that the app is still a paid app
//        if originalBuildNumber < 37 {
//            // grant user premium feature here
//            print("premium granted")
//        }
//    }
}

