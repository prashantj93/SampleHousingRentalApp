//
//  ContactOwner.swift
//  RentalApplication
//
//  Created by prashant joshi on 12/13/17.
//  Copyright © 2017 prashant joshi. All rights reserved.
//

import UIKit

class ContactOwner: UIViewController {
    
    var contact: Advertisement!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: ConstantVariable.HouseAdd.bgimage)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        if let ownerName = contact.name {
            name.text = ownerName
        } else {
            name.isHidden = true
        }
        if let ownerPhoneNumber = contact.mobile {
            phoneNumber.text = ownerPhoneNumber
        } else {
            phoneNumber.isHidden = true
        }
        if let ownerEmail = contact.email {
            email.text = ownerEmail
        } else {
            email.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToMainMenuBut(_ sender: UIButton) {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let viewController = segue.destination as! ViewController
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
