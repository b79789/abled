//
//  AddPlaceViewController.swift
//  Abled
//
//  Created by Brian Stacks on 1/15/16.
//  Copyright © 2016 Brian Stacks. All rights reserved.
//

import UIKit
import Parse


class AddPlaceViewController: UIViewController {
    
    
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
}