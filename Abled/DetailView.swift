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
    
    
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var placeNameLAbel: UILabel!
    @IBOutlet weak var userRating: RatingControl!
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var comments: UITextView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    var SecondArray:String! = ""
    
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
        print(SecondArray)
        placeNameLAbel.text = SecondArray
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
        
    }
    
    
    
}