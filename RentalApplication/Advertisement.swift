//
//  Advertisement.swift
//  RentalApplication
//
//  Created by prashant joshi on 12/19/17.
//  Copyright © 2017 prashant joshi. All rights reserved.
//

import Foundation

import UIKit

struct Advertisement {
    
    var objectID: String!
    var name: String!
    var price: NSNumber!
    var city: String!
    var email: String!
    var mobile: String!
    var noOfBed: String!
    var noOfBath: String!
    var latitude: String!
    var longitude: String!
    var zipcode: String!
    var size : String!
    var address : String!
    var image: UIImage?
    var imageURL: String!
    
    init?(dictionary: [String: Any]?, objectID: String) {
        guard let dictionary = dictionary,
            let name = dictionary["name"] as? String,
            let price = dictionary["price"] as? NSNumber,
            let city = dictionary["city"] as? String,
            let email = dictionary["email"] as? String,
            let mobile = dictionary["mobile"] as? String,
            let noOfBed = dictionary["noOfBed"] as? String,
            let noOfBath = dictionary["noOfBath"] as? String,
            let latitude = dictionary["latitude"] as? String,
            let longitude = dictionary["longitude"] as? String,
            let zipcode = dictionary["zipcode"] as? String,
            let address = dictionary["address"] as? String,
            let size = dictionary["size"] as? String,
            let imageURL = dictionary["imageURL"] as? String else {
                return nil
        }
        
        self.init(objectID: objectID, name: name, price: price, city: city, email: email, mobile: mobile, noOfBed: noOfBed, noOfBath: noOfBath, latitude: latitude, longitude: longitude, zipcode: zipcode, size: size,address: address, imageURL: imageURL)
    }
    
    init(objectID: String?, name: String, price: NSNumber, city: String, email: String, mobile: String, noOfBed: String, noOfBath: String, latitude: String, longitude: String, zipcode: String, size : String,address : String, imageURL: String) {
        self.objectID = objectID ?? ""
        self.name = name
        self.price = price
        self.city = city
        self.email = email
        self.mobile = mobile
        self.noOfBath = noOfBath
        self.noOfBed = noOfBed
        self.latitude = latitude
        self.longitude = longitude
        self.zipcode = zipcode
        self.size = size
        self.address = address
        self.imageURL = imageURL
    }
    
    func dictionary() -> [String: Any] {
        return ["name": name, "price": price,"city": city,"email": email,"mobile": mobile,"noOfBed": noOfBed,"noOfBath": noOfBath, "latitude": latitude,"longitude": longitude,"zipcode": zipcode,"size": size,"address": address, "imageURL": imageURL]
    }
    
}
