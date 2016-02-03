//
//  editProfile.swift
//  Abled
//
//  Created by Brian Stacks on 2/2/16.
//  Copyright © 2016 Brian Stacks. All rights reserved.
//

import Foundation
import UIKit
import Parse
//import MBProgressHUD

class editProfile: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(PFUser.currentUser()?.objectForKey("profilePic") != nil){
            let userImageFile: PFFile = PFUser.currentUser()?.objectForKey("profilePic") as! PFFile
            userImageFile.getDataInBackgroundWithBlock({(imageData: NSData?,error: NSError?) -> Void in
                
                if(imageData != nil)
                {
                self.profilePic.image = UIImage(data: imageData!)
                }
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func editAction(sender: AnyObject) {
        
        print("edit Hit!!")
        let myPicker = UIImagePickerController()
        myPicker.delegate = self;
        myPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPicker, animated: true, completion: nil)
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func editProfilePic(sender: AnyObject) {
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        profilePic.image = info [UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func saveAction(sender: AnyObject) {
        
        let currentUser: PFUser = PFUser.currentUser()!
        let profileImageData = UIImageJPEGRepresentation(profilePic.image!, 1)
        if(profilePic.image == nil)
        {
            let alert = UIAlertController(title: "Alert", message: "Photo cannot be empty", preferredStyle: UIAlertControllerStyle.Alert);
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(alertAction);
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        if(profileImageData != nil)
        {
            let profileFile = PFFile(data: profileImageData!)
            currentUser.setObject(profileFile!, forKey: "profilePic")
            print("profile image not nil")
        }
        
//        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view,animated: true)
//        loadingNotification.labelText = "Please wait"
        
    }
}