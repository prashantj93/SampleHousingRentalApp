//
//  FilterExistingUser.swift
//  RentalApplication
//
//  Created by prashant joshi on 12/11/17.
//  Copyright © 2017 prashant joshi. All rights reserved.
//

import UIKit

class FilterExistingUser: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var bedroomPicker: UIPickerView!
    
    @IBOutlet weak var bathroomPicker: UIPickerView!
    @IBOutlet weak var rentSlider: UISlider!
    
    @IBOutlet weak var rentSilderMax: UISlider!
    var pickerData: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        rentSlider.maximumValue = 5000
        rentSlider.minimumValue = 0
        rentSilderMax.maximumValue = 10000
        rentSilderMax.minimumValue = 0
        rentSilderMax.value = 10000
        rentSlider.value = 0
        pickerData = ["1", "2", "3", "4", "5", "5+"]
        self.bedroomPicker.delegate = self
        self.bedroomPicker.dataSource = self
        self.bathroomPicker.delegate = self
        self.bathroomPicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == bedroomPicker {
            return  pickerData.count
        } else if pickerView == bathroomPicker {
            return  pickerData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(pickerData)
        if pickerView == bedroomPicker {
            let titleRow = pickerData[row]
            return titleRow
        } else if pickerView == bathroomPicker {
            let titleRow = pickerData[row]
            return titleRow
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == bedroomPicker {
            GlobalVariable.bedFilter  = pickerData[row]
            
        } else if pickerView == bathroomPicker {
          GlobalVariable.bathFilter = pickerData[row]
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func rentSliderMaxMove(_ sender: Any) {
     GlobalVariable.rentFilermax = rentSilderMax.value
    }
    @IBAction func rentSliderMove(_ sender: Any) {
        GlobalVariable.rentFilter = rentSlider.value
    }
    
    //var tabBarController: UITabBarController?
    
    @IBAction func applyFilter(_ sender: Any) {
         tabBarController!.selectedIndex = 0
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.reloadData()
//    }
    
    @IBAction func goToMainMenu(_ sender: UIButton) {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let viewController = segue.destination as! ViewController
        }
    }
    
    struct GlobalVariable {
        static var rentFilter:Float = 0
        static var rentFilermax:Float = 10000
        static var bedFilter:String = ""
        static var bathFilter:String = ""
    }

}
