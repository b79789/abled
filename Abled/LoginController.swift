//
//  ViewController.swift
//  Abled
//
//  Created by Brian Stacks on 1/13/16.
//  Copyright © 2016 Brian Stacks. All rights reserved.
//
import Parse
import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
    }

    @IBAction func loginAction(sender: AnyObject) {
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        if username?.characters.count < 5 {
            let alert = UIAlertController(title: "Invalid", message: "Username must be greater than 5 characters", preferredStyle: UIAlertControllerStyle.Alert);
            showViewController(alert, sender: self);
        } else if password?.characters.count < 8 {
            let alert = UIAlertController(title: "Invalid", message: "Password must be greater than 8 characters",preferredStyle: UIAlertControllerStyle.Alert);
            showViewController(alert, sender: self);
        } else {
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                    spinner.stopAnimating()
                if ((user) != nil) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                    
                } else {
                    let alert = UIAlertController (title:"Error", message: "\(error)",preferredStyle: UIAlertControllerStyle.Alert);
                    self.showViewController(alert, sender: self);
                }
            })
        }
    }
}

