//
//  ViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 03/03/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        let due = UserDefaults.standard.object(forKey: "DueDate")
        print("This date has been retrieved from the default settings: \(due)")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
}

