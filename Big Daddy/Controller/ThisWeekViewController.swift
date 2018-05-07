//
//  ThisWeekViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 30/04/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class ThisWeekViewController: UIViewController {

    var personID : String = ""
    
    // Setup dictionaries of information
    
    var babyWeeks : [Int : String] = [
        
        1 : "Baby is not yet in existence",
        2 : "Baby is still not in existence",
        3 : "Baby is still not in existence",
        4 : "Baby is possibly just about in existence",
        5 : "Baby is in existence",
        6 : "Baby is getting bigger",
        7 : "Baby is getting bigger",
        8 : "Baby is getting bigger",
        9 : "Baby is getting bigger",
        10 : "Baby is getting bigger",
        11 : "Baby is getting bigger",
        12 : "Baby is getting bigger",
        13 : "Baby is getting bigger",
        14 : "Baby is getting bigger",
        15 : "Baby is getting bigger",
        16 : "Baby is getting bigger",
        17 : "Baby is getting bigger",
        18 : "Baby is getting bigger",
        19 : "Baby is getting bigger",
        20 : "Baby is getting bigger",
        21 : "Baby is getting bigger",
        22 : "Baby is getting bigger",
        23 : "Baby is getting bigger",
        24 : "Baby is getting bigger",
        25 : "Baby is getting bigger",
        26 : "Baby is getting bigger",
        27 : "Baby is getting bigger",
        28 : "Baby is getting bigger",
        29 : "Baby is getting bigger",
        30 : "Baby is getting bigger",
        31 : "Baby is getting bigger",
        32 : "Baby is getting bigger",
        33 : "Baby is getting bigger",
        34 : "Baby is getting bigger",
        35 : "Baby is getting bigger",
        36 : "Baby is getting bigger",
        37 : "Baby is getting bigger",
        38 : "Baby is getting bigger",
        39 : "Baby is getting bigger",
        40 : "Baby is getting bigger",
        41 : "Baby is getting bigger",
        42 : "Baby is getting bigger"
        ]
    
    var motherWeeks : [Int : String] = [
        1 : "Baby is not yet in existence",
        2 : "Baby is still not in existence",
        3 : "Baby is still not in existence",
        4 : "Baby is possibly just about in existence",
        5 : "Baby is in existence",
        6 : "Baby is getting bigger",
        7 : "Baby is getting bigger",
        8 : "Baby is getting bigger",
        9 : "Baby is getting bigger",
        10 : "Baby is getting bigger",
        11 : "Baby is getting bigger",
        12 : "Baby is getting bigger",
        13 : "Baby is getting bigger",
        14 : "Baby is getting bigger",
        15 : "Baby is getting bigger",
        16 : "Baby is getting bigger",
        17 : "Baby is getting bigger",
        18 : "Baby is getting bigger",
        19 : "Baby is getting bigger",
        20 : "Baby is getting bigger",
        21 : "Baby is getting bigger",
        22 : "Baby is getting bigger",
        23 : "Baby is getting bigger",
        24 : "Baby is getting bigger",
        25 : "Baby is getting bigger",
        26 : "Baby is getting bigger",
        27 : "Baby is getting bigger",
        28 : "Baby is getting bigger",
        29 : "Baby is getting bigger",
        30 : "Baby is getting bigger",
        31 : "Baby is getting bigger",
        32 : "Baby is getting bigger",
        33 : "Baby is getting bigger",
        34 : "Baby is getting bigger",
        35 : "Baby is getting bigger",
        36 : "Baby is getting bigger",
        37 : "Baby is getting bigger",
        38 : "Baby is getting bigger",
        39 : "Baby is getting bigger",
        40 : "Baby is getting bigger",
        41 : "Baby is getting bigger",
        42 : "Baby is getting bigger"
    ]
    
    var factWeeks : [Int : String] = [
    1 : "Baby is not yet in existence",
    2 : "Baby is still not in existence",
    3 : "Baby is still not in existence",
    4 : "Baby is possibly just about in existence",
    5 : "Baby is in existence",
    6 : "Baby is getting bigger",
    7 : "Baby is getting bigger",
    8 : "Baby is getting bigger",
    9 : "Baby is getting bigger",
    10 : "Baby is getting bigger",
    11 : "Baby is getting bigger",
    12 : "Baby is getting bigger",
    13 : "Baby is getting bigger",
    14 : "Baby is getting bigger",
    15 : "Baby is getting bigger",
    16 : "Baby is getting bigger",
    17 : "Baby is getting bigger",
    18 : "Baby is getting bigger",
    19 : "Baby is getting bigger",
    20 : "Baby is getting bigger",
    21 : "Baby is getting bigger",
    22 : "Baby is getting bigger",
    23 : "Baby is getting bigger",
    24 : "Baby is getting bigger",
    25 : "Baby is getting bigger",
    26 : "Baby is getting bigger",
    27 : "Baby is getting bigger",
    28 : "Baby is getting bigger",
    29 : "Baby is getting bigger",
    30 : "Baby is getting bigger",
    31 : "Baby is getting bigger",
    32 : "Baby is getting bigger",
    33 : "Baby is getting bigger",
    34 : "Baby is getting bigger",
    35 : "Baby is getting bigger",
    36 : "Baby is getting bigger",
    37 : "Baby is getting bigger",
    38 : "Baby is getting bigger",
    39 : "Baby is getting bigger",
    40 : "Baby is getting bigger",
    41 : "Baby is getting bigger",
    42 : "Baby is getting bigger"
    ]
    
    
    
    

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        
      
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        if personID == "[[0, 0]]" {
            print("Baby")
        } else if personID == "[[0, 1]]" {
            
            print("Mother")
        } else if personID == "[[0, 3]]" {
            
            print("Fact")
            
        }
        
    }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    }
