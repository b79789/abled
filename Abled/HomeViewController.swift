//
//  HomeViewController.swift
//  Abled
//
//  Created by Brian Stacks on 1/14/16.
//  Copyright © 2016 Brian Stacks. All rights reserved.
//

import Foundation
import UIKit
import Parse

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    var place = [Places]()
    var myArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
        
        
        if let userNAme = PFUser.currentUser()?["username"] as? String {
            self.userNameLabel.text = "User:" + userNAme
        }
        
        if let userPicture = PFUser.currentUser()?["profilePic"] as? PFFile {
            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    self.userImageView.image = UIImage(data:imageData!)
                }
            }
        }
        
        getParse()
    }
    
    @IBAction func logOutAction(sender: AnyObject){
        
        // Send a request to log out a user
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            self.presentViewController(viewController, animated: true, completion: nil)
        })
        
    }
    
    
    func getParse(){
        let query = PFQuery(className:"userPlaces")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error == nil {
                for object in objects! {
                    self.myArray = [object["placeName"],object["placeAddress"],object["placeType"]]
                    print(self.myArray[0])
                    
                }
            }else{
                print("Error: %@ %@", error!, error!.userInfo)
            }
        }
    }
    
}

