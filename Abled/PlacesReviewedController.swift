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
    @IBOutlet weak var userNameLabel: UILabel!
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
        
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "customcell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return placeArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath) as UITableViewCell
        let thumbils:[String] = [ pic1,pic2,pic3,pic4,pic5,pic6,pic7,pic8,pic9,pic10]
        cell.textLabel?.text = placeArray[indexPath.item]
        cell.imageView?.image = UIImage(named: thumbils[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        print("Row: \(row)")
        
        print(placeArray[row] )
       
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("EnterData");
            self.navigationController!.pushViewController(viewController, animated: true)
        
    }
}
