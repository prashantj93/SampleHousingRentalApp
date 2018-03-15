//
//  PostAdvetisement.swift
//  RentalApplication
//
//  Created by prashant joshi on 12/10/17.
//  Copyright © 2017 prashant joshi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PostAdvertisement: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var noOfBedroom :String = ConstantVariable.HouseAdd.defaultValue
    var noOfBathroom : String = ConstantVariable.HouseAdd.defaultValue
    var latitude : String = ConstantVariable.HouseAdd.emptyString
    var longitude : String = ConstantVariable.HouseAdd.emptyString
    var imageURL: String = ConstantVariable.HouseAdd.emptyString
    var imageUploadManager: ImageUploadManager?
    
    private let collection = Firestore.firestore().collection(ConstantVariable.HouseAdd.firebaseFolder)
    
    
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var size: UITextField!
    @IBOutlet weak var zipcode: UITextField!
    @IBOutlet weak var rent: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var imageToAddBut: UIButton!
    @IBOutlet weak var imageToAdd: UIImageView!
    
    @IBAction func setLocationClicked(_ sender: Any) {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            _ = segue.destination as! GetMapLocation
        }
    }
    
    
    @IBAction func backToMainBut(_ sender: UIButton) {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            _ = segue.destination as! ViewController
        }
    }
    
    @IBAction func postAdvetisement(_ sender: Any) {
        guard let image = imageToAdd.image, let city = city.text, let size = size.text, let zipcode = zipcode.text, let mobile = mobile.text,  let name = name.text, let email = email.text, let priceString = rent.text,let address = address.text, let price = Int(priceString) else {
            let alert = UIAlertController(title: "Alert", message: ConstantVariable.HouseAdd.alertMessage , preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            return
        }
        createHouseAdd(withImage: image, city: city, price: price,size: size,zipcode: zipcode,mobile: mobile,name: name,email: email,latitude: latitude,longitude: longitude,noOfBed: noOfBedroom,  noOfBath: noOfBathroom,address: address)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == bedRoomPicker {
            return  pickerData.count
        } else if pickerView == bathRoomPicker {
            return  pickerData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(pickerData)
        if pickerView == bedRoomPicker {
            let titleRow = pickerData[row]
            return titleRow
        } else if pickerView == bathRoomPicker {
            let titleRow = pickerData[row]
            return titleRow
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == bedRoomPicker {
            noOfBedroom  = pickerData[row]
            
        } else if pickerView == bathRoomPicker {
            noOfBathroom = pickerData[row]
        }
    }
    
    var pickerData: [String] = [String]()
    
    
    @IBOutlet weak var bedRoomPicker: UIPickerView!
    @IBOutlet weak var bathRoomPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: ConstantVariable.HouseAdd.bgimage)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        pickerData = ["1", "2", "3", "4", "5", "5+"]
        self.bedRoomPicker.delegate = self
        self.bedRoomPicker.dataSource = self
        self.bathRoomPicker.delegate = self
        self.bathRoomPicker.dataSource = self
        self.hideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setMapLocationClicked(unwindSegue:UIStoryboardSegue) {
        if let source = unwindSegue.source as? GetMapLocation {
            if((source.latVal != 0.0) && (source.longVal != 0.0) ){
                latitude = String(source.latVal)
                longitude = String(source.longVal)
                print(latitude)
                print(longitude)
            }
        }
        
    }
    
    // MARK: image picker
    @objc func showImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func addImage(_ sender: UIButton) {
        // MARK: image picker
        showImagePicker()
    }
    func createHouseAdd(withImage image: UIImage, city: String, price: Int,size: String,zipcode: String,mobile: String,name: String,email: String,latitude: String,longitude: String, noOfBed: String, noOfBath: String, address: String){
        
        imageUploadManager = ImageUploadManager()
        imageUploadManager?.uploadImage(image, progressBlock: { (percentage) in
            print(percentage)
        }, completionBlock: { [weak self] (fileURL, errorMessage) in
            guard let strongSelf = self else {
                return
            }            
            print(fileURL)
            self?.createHouseAdd(city: city, price: price,size: size,zipcode: zipcode,mobile: mobile,name: name,email: email,latitude: latitude,longitude: longitude, noOfBed: noOfBed, noOfBath: noOfBath,address: address,imageURL: (fileURL?.absoluteString)!)
            print("imageUploaded")
            
        })
        
    }
    
    private func createHouseAdd(city: String, price: Int,size: String,zipcode: String,mobile: String,name: String,email: String,latitude: String,longitude: String, noOfBed: String, noOfBath: String,address: String,imageURL: String) {
        
        let houseAdd = Advertisement(objectID: nil, name: name, price: NSNumber(value: price), city: city, email: email, mobile: mobile, noOfBed: noOfBed, noOfBath: noOfBath, latitude: latitude , longitude: longitude , zipcode: zipcode, size: size,address:address, imageURL: imageURL)
        
        collection.addDocument(data: houseAdd.dictionary()) { [unowned self] (error) in
            if let error = error {
                print(error)
            } else {
                print("success")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
}

extension PostAdvertisement: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func userSelectedImage(_ image: UIImage) {
        imageToAdd.image = image
        
        imageToAddBut.setTitle(nil, for: .normal)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            userSelectedImage(image)
        }
    }
    
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

