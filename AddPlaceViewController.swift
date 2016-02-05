//
//  AddPlaceViewController.swift
//  Abled
//
//  Created by Brian Stacks on 1/15/16.
//  Copyright © 2016 Brian Stacks. All rights reserved.
//

import UIKit
import Parse


class AddPlaceViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var addPicButton: UIButton!
    @IBOutlet weak var addPlaceName: UITextField!
    @IBOutlet weak var addAddress: UITextField!
    @IBOutlet weak var addPlaceType: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userNAme = PFUser.currentUser()?["username"] as? String {
            self.userNameLabel.text = "User:" + userNAme
        }

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
    
    
    @IBAction func saveAction(sender: AnyObject) {
        

        let userPlace = PFObject(className:"userPlaces")
        userPlace["placeName"] = self.addPlaceName.text
        userPlace["placeAddress"] = self.addAddress.text
        userPlace["placeType"] = self.addPlaceType.text
        userPlace.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("saved")
            } else {
                // There was a problem, check error.description
                print(" not saved")
            }
        }
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PlacesReviewed");
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func addPhotoAction(sender: AnyObject) {
        
        let myPicker = UIImagePickerController()
        myPicker.delegate = self;
        myPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        //profilePic.image = info [UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}