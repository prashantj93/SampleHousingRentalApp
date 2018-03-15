//
//  TableViewExistingUsersTableViewController.swift
//  RentalApplication
//
//  Created by prashant joshi on 12/11/17.
//  Copyright © 2017 prashant joshi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import Haneke

var itemList = [String]();


class TableViewExistingUsers: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHouseAdds()
    }
    
    
    func fetchHouseAdds() {
        fetchHouseAdds { [unowned self] (error) in
            if let error = error {
                // TODO: display errors
            } else {
                print("success");
                self.tableView.reloadData()
            }
        }
    }
    
    
    private var itemsToDisplay: [Any] = []
    private var filtereditems: [Any] = []
    
    private var listener: ListenerRegistration?
    
    private func baseQuery() -> Query {
        return Firestore.firestore().collection(ConstantVariable.HouseAdd.firebaseFolder).limit(to: 50)
    }
    
    func fetchHouseAdds(_ completion: @escaping (_ error: String?) -> Void) {
        listener = baseQuery().addSnapshotListener({ [unowned self] (snapshot, error) in
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let numberOfRows = itemsToDisplay.count
        print(numberOfRows)
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantVariable.HouseAdd.cellIdentifier , for: indexPath) as! TableViewCell
        let item = itemsToDisplay[indexPath.item]
        if let houseAdd = item as? Advertisement {
            let cell = tableView.dequeueReusableCell(withIdentifier: ConstantVariable.HouseAdd.cellIdentifier , for: indexPath) as! TableViewCell
            cell.fillWith(houseAdd)
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator;
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let row = indexPath.row
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        //print(indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewController = segue.destination as! DetailExistingAdd
        let cell = sender as! UITableViewCell
        let selectedRow = tableView.indexPath(for: cell)!.row
        let item = itemsToDisplay[selectedRow]
        if let houseAdd = item as? Advertisement {
            viewController.selectedHouseAdd = houseAdd
        }
    }
    
    
    @IBAction func goToMainMenu(_ sender: Any) {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let viewController = segue.destination as! ViewController
        }
    }
    
    
}
