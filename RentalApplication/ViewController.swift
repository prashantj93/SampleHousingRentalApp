//
//  ViewController.swift
//  RentalApplication
//
//  Created by prashant joshi on 12/10/17.
//  Copyright © 2017 prashant joshi. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var postAdd: UIButton!
    
    @IBOutlet weak var seePost: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: ConstantVariable.HouseAdd.bgMainImage)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchProperties(_ sender: UIButton) {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            _ = segue.destination as! TableViewExistingUsers
        }
    }
    
    
    @IBAction func postAdd(_ sender: UIButton) {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            _ = segue.destination as! PostAdvertisement
        }
    }
    
}


