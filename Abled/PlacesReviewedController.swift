//
//  PlacesReviewedController.swift
//  Abled
//
//  Created by Brian Stacks on 1/15/16.
//  Copyright © 2016 Brian Stacks. All rights reserved.
//

import UIKit
import Parse


class PlacesReviewController: UIViewController
 {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    
    let userObjects = PFObject.init(className: "userPlaces")
    
    var placeArray: NSMutableArray = NSMutableArray()
    let pic1 =  "barCafe.jpg"
    let pic2 = "bjs.png"
    let pic3 = "jackinthebox_restaurant_thumb.png"
    let pic4 = "humpty.png"
    let pic5 = "fan_fang_thumb.png"
    let pic6 = "aw.gif"
    let pic7 =  "brand.gif"
    let pic8 =  "Chi-Chi.gif"
    let pic9 =  "jacks.jpg"
    let pic10 = "tobys_bar_restaurant_87028.jpg"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            if let userName = PFUser.currentUser()?["username"] as? String {
            self.userNameLabel.text = "User:" + userName
        }
        
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "customcell")
        self.getParse()
    }
    
    func getParse(){
        let query = PFQuery(className:"userPlaces")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error == nil {
                for object in objects! {
                    
//                    let name = object["placeName"]
//                    let address = object["placeAddress"]
//                    let type = object["placeType"]

                    self.placeArray.addObject(object["placeName"])
                    self.myTableView.reloadData()
                    
     
                }
            } else {

                print("Error: %@ %@", error!, error!.userInfo)
            }
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath) as UITableViewCell
        let thumbils:[String] = [ pic1,pic2,pic3,pic4,pic5,pic6,pic7,pic8,pic9,pic10]
        cell.textLabel?.text = self.placeArray[indexPath.item] as? String
        cell.imageView?.image = UIImage(named: thumbils[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        _ = indexPath.row
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("EnterData");
            self.navigationController!.pushViewController(viewController, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "toDetail") {
            let row = self.myTableView.indexPathForSelectedRow!.row
            let navVC = segue.destinationViewController as! UINavigationController
            let viewController = navVC.viewControllers.first as! DetailView
            // your new view controller should have property that will store passed value
            
            viewController.SecondArray = self.placeArray[row] as! String
            print(self.placeArray[row] as! String)
        }
        
    }
}
