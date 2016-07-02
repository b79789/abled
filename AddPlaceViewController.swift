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
    
    
    @IBOutlet weak var imageView: UIImageView!
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
        if ((self.addPlaceName.text?.isEmpty) == true) {
            let alert = UIAlertController(title: "Error", message:
                "Please don't leave feilds blank.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }else if((self.addAddress.text?.isEmpty) == true){
            let alert = UIAlertController(title: "Error", message:
                "Please don't leave feilds blank.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }else if((self.addPlaceType.text?.isEmpty) == true){
            let alert = UIAlertController(title: "Error", message:
                "Please don't leave feilds blank.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            userPlace["placeName"] = self.addPlaceName.text
            userPlace["placeAddress"] = self.addAddress.text
            userPlace["placeType"] = self.addPlaceType.text
            userPlace.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    print("saved")
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PlacesReviewed");
                    self.navigationController!.pushViewController(viewController, animated: true)
                } else {
                    // There was a problem, check error.description
                    print(" not saved")
                    let alert = UIAlertController(title: "Error", message:
                        "There was a problem saving", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                        self.removeFromParentViewController()
                    }))
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    
    @IBAction func addPhotoAction(sender: AnyObject) {
        
        let myPicker = UIImagePickerController()
        myPicker.delegate = self;
        myPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        
        //imageView.image = info [UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
        let viewController: AddPlaceViewController = AddPlaceViewController()
        viewController.imageView.image = info [UIImagePickerControllerOriginalImage] as? UIImage
    }
}