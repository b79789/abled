//
//  SettingsViewController.swift
//  Abled
//
//  Created by Brian Stacks on 1/15/16.
//  Copyright © 2016 Brian Stacks. All rights reserved.
//

import UIKit
import Parse


class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var userNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let userName = PFUser.currentUser()?["username"] as? String {
            self.userNameLabel.text = "User:" + userName
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
