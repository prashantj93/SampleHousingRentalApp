//
//  DetailExistingAdd.swift
//  RentalApplication
//
//  Created by prashant joshi on 12/11/17.
//  Copyright © 2017 prashant joshi. All rights reserved.
//

import UIKit
import Haneke

class DetailExistingAdd: UIViewController {
    
    var selectedHouseAdd: Advertisement!
    
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var noOfbedroom: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var noOfBathroom: UILabel!
    // MARK: view methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: ConstantVariable.HouseAdd.bgimage)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        print(selectedHouseAdd.name)
        cityLabel.text = selectedHouseAdd.city
        noOfbedroom.text = selectedHouseAdd.noOfBed
        size.text = selectedHouseAdd.size
        noOfBathroom.text = selectedHouseAdd.noOfBath
        address.text = selectedHouseAdd.address
        
        
        if let image = selectedHouseAdd.image {
            imageView.image = image
        } else {
            print(selectedHouseAdd.imageURL)
            if let imageURL = URL(string: selectedHouseAdd.imageURL) {
                imageView.hnk_setImage(from: imageURL)
            }
        }
        
        if let price = selectedHouseAdd.price {
            priceLabel.text = "$ \(price)"
        } else {
            priceLabel.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ContactOwner
        viewController.contact = selectedHouseAdd
    }
    
    
    
}
