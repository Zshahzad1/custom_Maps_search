//
//  MapQuestVC.swift
//  AnimationFun
//
//  Created by user user on 28/08/2018.
//  Copyright © 2018 Believerz. All rights reserved.
//

import UIKit
import GooglePlaces

class MapQuestVC: UIViewController,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.address.text = secData[indexPath.row]
        cell.LocName.text = tableData[indexPath.row]
      //  cell.markerImage.image = Images[indexPath.row]
        return cell
    }
    
    var tableData=[String]()
    var secData = [String]()
    var Images = [UIImage]()
    var fetcher: GMSAutocompleteFetcher?
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var PlaceTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = .all
        
        // Set bounds to inner-west Sydney Australia.
        let neBoundsCorner = CLLocationCoordinate2D(latitude: -33.843366,
                                                    longitude: 151.134002)
        let swBoundsCorner = CLLocationCoordinate2D(latitude: -33.875725,
                                                    longitude: 151.200349)
        let bounds = GMSCoordinateBounds(coordinate: neBoundsCorner,
                                         coordinate: swBoundsCorner)
        
        // Set up the autocomplete filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        
        // Create the fetcher.
        fetcher = GMSAutocompleteFetcher(bounds: bounds, filter: filter)
        fetcher?.delegate = self
        
        PlaceTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)),for: .editingChanged)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        PlaceTextField.layer.borderWidth = 2.0
        PlaceTextField.layer.cornerRadius = 6.0
        PlaceTextField.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        self.tableView.reloadData()
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        fetcher?.sourceTextHasChanged(PlaceTextField.text!)
    }

   
}

extension MapQuestVC: GMSAutocompleteFetcherDelegate {
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        tableData.removeAll()
        secData.removeAll()
        Images.removeAll()
        
        for prediction in predictions {
            
            tableData.append(prediction.attributedPrimaryText.string)
            secData.append(prediction.attributedSecondaryText?.string ?? "No")
             let placeID =  prediction.placeID ?? "ChIJV4k8_9UodTERU5KXbkYpSYs"
            let placeClient = GMSPlacesClient()
             placeClient.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
                if let error = error {
                    print("lookup place id query error: \(error.localizedDescription)")
                    return
                }
                
                guard let place = place else {
                    print("No place details for \(placeID)")
                    return
                }
                
                print("Place name \(place.name)")
                print("Place address \(place.formattedAddress)")
                print("Place placeID \(place.placeID)")
                print("Place attributions \(place.attributions)")
            })
            
            //print("\n",prediction.attributedFullText.string)
            //print("\n",prediction.attributedPrimaryText.string)
            //print("\n********")
        }
        tableView.reloadData()
    }
    
   
    func didFailAutocompleteWithError(_ error: Error) {
        //resultText?.text = error.localizedDescription
        print(error.localizedDescription)
    }
    
    
}
