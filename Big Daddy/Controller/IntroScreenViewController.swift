//
//  IntroScreenViewController.swift
//  Big Daddy
//
//  Created by Georgie and Chris on 12/08/2018.
//  Copyright © 2018 Dumpy Developments. All rights reserved.
//

import UIKit

class IntroScreenViewController: UIViewController {

    
    // Setup outlets
    
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var mothersName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var mothersTick: UIImageView!
    @IBOutlet weak var dueDateTick: UIImageView!
    @IBAction func skipPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "introSegue", sender: self)
        
    }
    @IBAction func donePressed(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
