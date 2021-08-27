//
//  LocationPickerVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 10/08/21.
//

import UIKit

class LocationPickerVC: LocationPicker {
    
    var viewController: AddressAddVC!

    override func viewDidLoad() {
        super.addBarButtons()
        super.viewDidLoad()
        self.view.backgroundColor = ModeBG_Color
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.searchTextField.textColor = PrimaryText_Color
        self.tableView.backgroundColor = ModeBG_Color
    }
    
    @objc override func locationDidSelect(locationItem: LocationItem) {
        print("Select overrided method: " + locationItem.name)
    }
    
    @objc override func locationDidPick(locationItem: LocationItem) {
        viewController.showLocation(locationItem: locationItem)
        viewController.storeLocation(locationItem: locationItem)
    }
}
