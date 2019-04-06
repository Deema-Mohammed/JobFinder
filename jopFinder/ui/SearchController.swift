//
//  SearchController.swift
//  jopFinder
//
//  Created by Deema on 4/4/19.
//  Copyright © 2019 Deema. All rights reserved.
//

import UIKit
import GooglePlacesSearchController

class SearchController: UIViewController {
    
    private let _providers = ["Github","Search.gov"]
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var locationSelected: UILabel!
    @IBOutlet weak var jobTitle: UITextField!
    @IBOutlet weak var locationName: UILabel!
    
    static var parameters = SearchObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchController.parameters.provider = .github
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    @IBAction func SelectJobLocation(_ sender: Any) {
        let controller = GooglePlacesSearchController(delegate: self,
                                                      apiKey: "AIzaSyDtXw7JfSK5cwlM-Rx0Pc7ooedEbgiNZQ4",
                                                      placeType: .address,
                                                      searchBarPlaceholder: "Start typing..."
        )
        
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func search(_ sender: Any) {
        SearchController.parameters.title = jobTitle.text!
        performSegue(withIdentifier: Constants.JLSegue , sender: self)
    }    
}

extension SearchController: GooglePlacesAutocompleteViewControllerDelegate{
    func viewController(didAutocompleteWith place: PlaceDetails) {
        
        locationName.text = place.country
        SearchController.parameters.latitude = place.coordinate?.latitude
        SearchController.parameters.longitude = place.coordinate?.longitude
    }
}
extension SearchController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _providers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return _providers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SearchController.parameters.provider = _providers[row] == "Github" ? .github : .searchGov
    }
}
