//
//  TableViewCell.swift
//  RentalApplication
//
//  Created by prashant joshi on 12/13/17.
//  Copyright © 2017 prashant joshi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellCity: UILabel!
    @IBOutlet weak var cellRent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImage.hnk_cancelSetImage()
        cellImage.image = nil
    }
    
    func fillWith(_ car: Advertisement) {
        cellImage.image = car.image
        cellCity?.text = car.city
        if let price = car.price {
            cellRent?.text = "$ \(price)"
        }        
        if let url = URL(string: car.imageURL) {
            cellImage.hnk_setImage(from: url)
        }
    }
    
}
