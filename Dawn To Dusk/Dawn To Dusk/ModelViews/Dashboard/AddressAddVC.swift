//
//  AddressAddVC.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 07/08/21.
//

import UIKit
import MapKit


class AddressAddVC: BaseClassVC {

    //    MARK:- IBOutlets
    //    MARK:-
    
    @IBOutlet weak var MainStack: UIStackView!
    
    @IBOutlet weak var GoogleView: UIView!
    @IBOutlet weak var subgoogleview: UIView!
    @IBOutlet weak var locationIMG: UIImageView!
    @IBOutlet weak var GoogleLBL: UILabel!
    @IBOutlet weak var GoogleBTN: UIButton!
    
    @IBOutlet weak var ORView: UIView!
    
    @IBOutlet weak var ManuleView: UIView!
    
    @IBOutlet weak var InputsView1: UIView!
    @IBOutlet weak var TXTinputs1: UITextField!
    @IBOutlet weak var InputsView2: UIView!
    @IBOutlet weak var TXTinputs2: UITextField!
    @IBOutlet weak var InputsView3: UIView!
    @IBOutlet weak var TXTinputs3: UITextField!
    
    @IBOutlet weak var AddTypeView1: UIView!
    @IBOutlet weak var AddTypeIMG1: UIImageView!
    @IBOutlet weak var AddTypeLBL1: UILabel!
    @IBOutlet weak var AddTypeBTN1: UIButton!
    
    @IBOutlet weak var AddTypeView2: UIView!
    @IBOutlet weak var AddTypeIMG2: UIImageView!
    @IBOutlet weak var AddTypeLBL2: UILabel!
    @IBOutlet weak var AddTypeBTN2: UIButton!
    
    @IBOutlet weak var AddTypeView3: UIView!
    @IBOutlet weak var AddTypeIMG3: UIImageView!
    @IBOutlet weak var AddTypeLBL3: UILabel!
    @IBOutlet weak var AddTypeBTN3: UIButton!
    
    @IBOutlet weak var AddAddressBTN: UIButton!
    
//    MARK:- Variable Defines
//    MARK:-
    
    var historyLocationList: [LocationItem] {
        get {
            if let locationDataList = UserDefaults.standard.array(forKey: "HistoryLocationList") as? [Data] {
                // Decode NSData into LocationItem object.
                return locationDataList.map({ NSKeyedUnarchiver.unarchiveObject(with: $0) as! LocationItem })
            } else {
                return []
            }
        }
        set {
            // Encode LocationItem object.
            let locationDataList = newValue.map({ NSKeyedArchiver.archivedData(withRootObject: $0) })
            UserDefaults.standard.set(locationDataList, forKey: "HistoryLocationList")
        }
    }
    
    var AddressData: SelectedCommunity!
    var addressobj: UserInfoAddres!
    
    //    MARK:- View Cycle
    //    MARK:-
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toogleTabbar(hide: true)
        self.setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //    MARK:- User Define
    //    MARK:-
    
    override func setupUI() {
        
        self.view.backgroundColor = TBLBackgroundCOlor
        self.MainStack.backgroundColor = UIColor.clear
        
        self.GoogleView.backgroundColor = UIColor.clear
        self.subgoogleview.backgroundColor = ModeBG_Color
        self.subgoogleview.clipsToBounds = true
        self.subgoogleview.layer.cornerRadius = 10.0
        
        self.InputsView1.backgroundColor = ModeBG_Color
        self.InputsView1.clipsToBounds = true
        self.InputsView1.layer.cornerRadius = 10.0
        
        self.InputsView2.backgroundColor = ModeBG_Color
        self.InputsView2.clipsToBounds = true
        self.InputsView2.layer.cornerRadius = 10.0
        
        self.InputsView3.backgroundColor = ModeBG_Color
        self.InputsView3.clipsToBounds = true
        self.InputsView3.layer.cornerRadius = 10.0

        
        self.AddTypeView1.backgroundColor = ModeBG_Color
        self.AddTypeView1.clipsToBounds = true
        self.AddTypeView1.layer.cornerRadius = 10.0
        
        self.AddTypeView2.backgroundColor = ModeBG_Color
        self.AddTypeView2.clipsToBounds = true
        self.AddTypeView2.layer.cornerRadius = 10.0
        
        self.AddTypeView3.backgroundColor = ModeBG_Color
        self.AddTypeView3.clipsToBounds = true
        self.AddTypeView3.layer.cornerRadius = 10.0
        
        self.AddTypeIMG1.image = UIImage.init(named: "HomeAddressIC")
        self.AddTypeLBL1.text = "Home"
        self.AddTypeIMG2.image = UIImage.init(named: "OfficeAddressIC")
        self.AddTypeLBL2.text = "Office"
        self.AddTypeIMG3.image = UIImage.init(named: "OtherAddressIC")
        self.AddTypeLBL3.text = "Other"
        
        self.AddTypeView1.alpha = 1.0
        self.AddTypeView2.alpha = 0.5
        self.AddTypeView3.alpha = 0.5
        
        self.AddAddressBTN.GetThemeButtonwithBorder()
        self.AddAddressBTN.setTitle("Add Address", for: .normal)
        self.AddAddressBTN.alpha = 0.5
        self.AddAddressBTN.isEnabled = false
        
        self.title = "Add Addresse"
        self.SetupNavBarforback()
    }
    
    func SetupAddress() {
        if self.addressobj == nil || self.AddressData == nil {
            self.AddAddressBTN.alpha = 0.5
            self.AddAddressBTN.isEnabled = false
        }
        else {
            self.AddAddressBTN.alpha = 1
            self.AddAddressBTN.isEnabled = true
        }
    }
    
    func getaddresstype() -> String? {
        if self.AddTypeView1.alpha == 1.0 {
            return "Home"
        }
        else if self.AddTypeView2.alpha == 1.0 {
            return "Office"
        }
        else {
            return "Other"
        }
    }
    
    //    MARK:- IBActions Define
    //    MARK:-

    @IBAction func TappedGoogle(_ sender: UIButton) {
        if self.GoogleBTN == sender {
            let customLocationPicker = LocationPickerVC()
            customLocationPicker.isAllowArbitraryLocation = true
            customLocationPicker.viewController = self
            let navigationController = UINavigationController(rootViewController: customLocationPicker)
            present(navigationController, animated: true, completion: nil)
        }
        else {
            
        }
    }
    
    @IBAction func TappedAddType(_ sender: UIButton) {
        if sender == self.AddTypeBTN1 {
            self.AddTypeView1.alpha = 1.0
            self.AddTypeView2.alpha = 0.5
            self.AddTypeView3.alpha = 0.5
        }
        else if sender == self.AddTypeBTN2 {
            self.AddTypeView1.alpha = 0.5
            self.AddTypeView2.alpha = 1.0
            self.AddTypeView3.alpha = 0.5
        }
        else {
            self.AddTypeView1.alpha = 0.5
            self.AddTypeView2.alpha = 0.5
            self.AddTypeView3.alpha = 1.0
        }
    }
    
}

//MARK:- Textfield Delegates
//MARK:-

extension AddressAddVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        if textField == self.TXTinputs1 {

        }
        else if textField == self.TXTinputs1 {
            
        }
        else {
            
        }
        self.SetupAddress()
        return true
    }
    
}

//MARK:- LocationPicker AppDelegate
//MARK:-

extension AddressAddVC: LocationPickerDelegate, LocationPickerDataSource {
    
    func locationDidSelect(locationItem: LocationItem) {
        print("Select delegate method: " + locationItem.name)
    }
    
    func locationDidPick(locationItem: LocationItem) {
        showLocation(locationItem: locationItem)
        storeLocation(locationItem: locationItem)
    }
    
    func numberOfAlternativeLocations() -> Int {
        return historyLocationList.count
    }
    
    func alternativeLocation(at index: Int) -> LocationItem {
        return historyLocationList.reversed()[index]
    }
    
    func commitAlternativeLocationDeletion(locationItem: LocationItem) {
        historyLocationList.remove(at: historyLocationList.firstIndex(of: locationItem)!)
    }
    
    func showLocation(locationItem: LocationItem) {
        self.GoogleLBL.text = String.init(format: "%@ %@", locationItem.name, locationItem.formattedAddressString == nil ? "" : locationItem.formattedAddressString!)
        self.SetupAddress()
    }
    
    func storeLocation(locationItem: LocationItem) {
        if let index = historyLocationList.firstIndex(of: locationItem) {
            historyLocationList.remove(at: index)
        }
        historyLocationList.append(locationItem)
    }
    
}
