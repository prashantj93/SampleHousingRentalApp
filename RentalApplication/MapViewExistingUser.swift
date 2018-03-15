//
//  MapViewExistingUserViewController.swift
//  RentalApplication
//
//  Created by prashant joshi on 12/11/17.
//  Copyright © 2017 prashant joshi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import Haneke
import MapKit
import CoreLocation

class MapViewExistingUser: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: ConstantVariable.HouseAdd.bgimage)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        fetchCars()
        
        // Do any additional setup after loading the view.
    }
    
    func fetchCars() {
        fetchCars { [unowned self] (error) in
            if error != nil {
                print(error!)
            } else {
                print("success");
                self.loadMap()
            }
        }
    }
    
    
    private var itemsToDisplay: [Any] = []
    
    private var listener1: ListenerRegistration?
    
    private func baseQuery() -> Query {
        return Firestore.firestore().collection(ConstantVariable.HouseAdd.firebaseFolder).limit(to: 50)
    }
    
    func fetchCars(_ completion: @escaping (_ error: String?) -> Void) {
        listener1 = baseQuery().addSnapshotListener({ [unowned self] (snapshot, error) in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                guard let snapshot = snapshot else {
                    completion(nil)
                    return
                }
                
                self.itemsToDisplay = snapshot.documents.flatMap({ (document) -> Advertisement? in
                    return Advertisement(dictionary: document.data(), objectID: document.documentID)
                })
                
                completion(nil)
            }
        })
    }
    
    func loadMap(){
        for item in itemsToDisplay {
            if let anitem = item as? Advertisement {
                
                
                
                
                //cell.fillWith(car)
                let city = anitem.city
                var rent:String = ConstantVariable.HouseAdd.emptyString
                if let price = anitem.price {
                    rent = "$ \(price)"
                }
                let lat = Double(anitem.latitude)
                let long = Double(anitem.longitude)
                var coordinate = CLLocationCoordinate2DMake(32.715736, -117.161087)
                if(lat != 0.0 && long != 0.0 ){
                    coordinate = CLLocationCoordinate2DMake(lat!, long!)
                    
                    let marker = AnnotatedLocation(
                        coordinate: coordinate,
                        title: ConstantVariable.HouseAdd.emptyString,
                        subtitle: rent)
                    mapView!.addAnnotation(marker)
                }else{
                    let locator = CLGeocoder()
                    locator.geocodeAddressString(city!)
                    { (placemarks, errors) in
                        if let place = placemarks?[0] {
                            coordinate = CLLocationCoordinate2DMake((place.location?.coordinate.latitude)!, (place.location?.coordinate.longitude)!)
                            print(coordinate)
                            let marker = AnnotatedLocation(
                                coordinate: coordinate,
                                title:ConstantVariable.HouseAdd.emptyString,
                                subtitle: rent)
                            self.mapView!.addAnnotation(marker)
                        } else {
                            print( errors! )
                        }
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToMainMenu(_ sender: UIButton) {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            _ = segue.destination as! ViewController
        }
    }
    
    class AnnotatedLocation:NSObject, MKAnnotation {
        let coordinate: CLLocationCoordinate2D
        let subtitle:String?
        
        init(coordinate: CLLocationCoordinate2D,title:String,subtitle:String) {
            self.coordinate = coordinate
            self.subtitle = subtitle
        }
    }
    
    
}
