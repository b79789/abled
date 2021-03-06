//
//  LocalViewController.swift
//  Abled
//
//  Created by Brian Stacks on 1/15/16.
//  Copyright © 2016 Brian Stacks. All rights reserved.
//


import Foundation
import UIKit
import Parse
import MapKit
import QuadratTouch


class LocalViewController: UIViewController,CLLocationManagerDelegate {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    @IBOutlet weak var myTableView: UITableView!
    let placeArray = ["item1", "item2", "item3","item1", "item2", "item3","item1", "item2", "item3","item1"]
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
        if let userNAme = PFUser.currentUser()?["username"] as? String {
            self.userNameLabel.text = "User:" + userNAme
        }
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
       
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "customcell1")
        
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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        
        self.mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "Here"
        annotation.subtitle = "You Are"
        mapView.addAnnotation(annotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return placeArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let thumbils:[String] = [ pic1,pic2,pic3,pic4,pic5,pic6,pic7,pic8,pic9,pic10]
       
        
        // Load images
        let cell = tableView.dequeueReusableCellWithIdentifier("customcell1", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = placeArray[indexPath.item]
        cell.imageView?.image = UIImage(named: thumbils[indexPath.row])
       
        
       
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        print("Row: \(row)")
        
        print(placeArray[row] )
        
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddPlace");
        self.navigationController!.pushViewController(viewController, animated: true)
        
    }
    
    

}