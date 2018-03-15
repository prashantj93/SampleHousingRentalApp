//
//  GetMapLocation.swift
//  RentalApplication
//
//  Created by prashant joshi on 12/10/17.
//  Copyright © 2017 prashant joshi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class GetMapLocation: UIViewController, UIGestureRecognizerDelegate {
    
    var latVal = 0.0
    var longVal = 0.0
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager:CLLocationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: ConstantVariable.HouseAdd.bgimage)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchPoint = touch.location(in: mapView)
            let location = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            latVal = location.latitude
            longVal = location.longitude
        }
    }
    
    
    
    
}
