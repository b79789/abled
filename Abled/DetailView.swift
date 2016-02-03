//
//  DetailView.swift
//  Abled
//
//  Created by Brian Stacks on 1/21/16.
//  Copyright © 2016 Brian Stacks. All rights reserved.
//

import UIKit
import Parse


class DetailView: UIViewController {
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func CloseAction(sender: AnyObject) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
        self.navigationController?.pushViewController(viewController, animated: true)
        print("Hello Swift")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userNAme = PFUser.currentUser()?["username"] as? String {
            self.userNameLabel.text = "User:" + userNAme
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}