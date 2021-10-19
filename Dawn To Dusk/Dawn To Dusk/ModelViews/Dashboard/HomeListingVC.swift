//
//  HomeListingVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 26/07/21.
//

import UIKit
import MapKit
import CoreLocation


class HomeListingVC: BaseClassVC {
    
    //    MARK:- IBOutlet Define
    //    MARK:-
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var TopHeaderView: UIView!
    @IBOutlet weak var CategoryView: PinterestSegment!
    @IBOutlet weak var subHeaderView: UIView!
    @IBOutlet weak var SubCat_Height: NSLayoutConstraint!
    
    @IBOutlet weak var FilterView: UIView!
    @IBOutlet weak var filter_LBL: UILabel!
    @IBOutlet weak var FilterSwitch: UISwitch!
    @IBOutlet weak var SubCatView: PinterestSegment!
    @IBOutlet weak var SubCatView2: UICollectionView!
    
    @IBOutlet weak var NodataFoundView: NodataView!
    @IBOutlet weak var FoodListTBL: TPKeyboardAvoidingTableView!
    
    //    MARK:- Variable Defines
    //    MARK:-
    
    var locationManager = CLLocationManager()
    
    lazy var navheaderView : NavHeaderView = {
        let header = NavHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: NavBarHeight))
        header.callbackAction = { Type in
            if SharedUserInfo.shared.IsUserLoggedin()! {
                if Type == .Cart {
                    self.TappedCartBTN(UIButton().NavCartButton())
                }
                else {
                    SharedUserInfo.shared.UserLogout()
                }
            }
            else {
                let vc = LoginVC(nibName: "LoginVC", bundle: nil)
                vc.LoginSelected = 100
                self.navigationController!.pushViewController(vc, animated: true)
            }
        }
        return header
    }()
    
    var SelectedMainCat: MainCategoryData!
    var MainCatArry: [MainCategoryData] = []
    
    var SelectedSubCat: SubCategoryData!
    var SubCatArry: [SubCategoryData] = []
    var SelectedSubCatArry: [SubCategoryData] = []
    var MultipleSelect: Bool = false
    
    var Bannerarry: [BannerModels] = []
    
    var FilterWithSub: Bool = true
    
    var SearchSTR: String = ""
    var IsSearching: Bool = false
    
    var MenuItems_arry: [MenuItemsData] = []
    var filter_MenuItems: [MenuItemsData] = []
    
    //    MARK:- View Cycle
    //    MARK:-
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toogleTabbar(hide: false)
        
        self.SearchBar.searchTextField.textColor = PrimaryText_Color
        
        self.view.backgroundColor = ModeBG_Color
        self.navigationController?.navigationBar.isHidden = false
        for item in self.view.subviews {
            item.backgroundColor = ModeBG_Color
        }
        
        self.FoodListTBL.register(UINib.init(nibName: "HomeBannerCell", bundle: nil), forCellReuseIdentifier: "HomeBannerCell")
        self.FoodListTBL.register(UINib.init(nibName: "HomeFoodListCell", bundle: nil), forCellReuseIdentifier: "HomeFoodListCell")
        self.FoodListTBL.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: 180))
        self.FoodListTBL.allowsSelection = true
        
        self.setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navheaderView.fillinfo(title: "Home")
        navigationItem.titleView = self.navheaderView
        if !self.hasLocationPermission() {
            self.navigationController?.view.makeToast("We are unable to get your current location please, try it again!".localized(), duration: 3.0, position: .top, title: "User Location failed".localized(), image: nil)
        }
    }
    
    //    MARK:- User Custome Methods
    //    MARK:-
    
    override func checkNetworkStatus() {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            self.NodataFoundView.fillinfo(title: "No Internet", Notes: "There is no internet available in device. Please check your setting and try it again!", image: "NoInternetIMG", enable: true)
            self.NodataFoundView.isHidden = false
            self.TopHeaderView.isHidden = true
            self.FoodListTBL.isHidden = true
            break;
            
        case .online(.wwan):
            print("Connected via WWAN")
            self.setupUI()
            break;
            
        case .online(.wiFi):
            print("Connected via WiFi")
            self.setupUI()
            break;
        }
    }
    
    override func setupUI() {
        self.TopHeaderView.isHidden = false
        NetworkingRequests.shared.GetCategoryListing { (catData, status) in
            if status {
                if catData.mainCategoryData.count != 0 && catData.status {
                    self.MainCatArry = catData.mainCategoryData
                    self.setupCategoryView()
                    self.subHeaderView.isHidden = false
                }
                else {
                    self.subHeaderView.isHidden = true
                }
            }
            else {
                self.navigationController?.view.makeToast(catData.message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
                self.subHeaderView.isHidden = true
            }
        } onFailure: { (message) in
            self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            self.subHeaderView.isHidden = true
        }
        
        self.SearchBar.delegate = self
        
        self.FoodListTBL.delegate = self
        self.FoodListTBL.dataSource = self
        
        self.NodataFoundView.backgroundColor = ModeBG_Color
        self.NodataFoundView.fillinfo(title: "No data available!", Notes: "There are no Data available yet!", image: "", enable: false)
        self.NodataFoundView.didActionBlock = {
            self.setupUI()
        }
        
        if self.cellcount() == 0 {
            self.NodataFoundView.isHidden = false
            self.FoodListTBL.isHidden = true
        }
        else {
            self.NodataFoundView.isHidden = true
            self.FoodListTBL.isHidden = false
        }
        
    }
    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        self.locationManager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            switch self.locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                hasPermission = false
                self.locationManager.delegate = self
                self.locationManager.requestWhenInUseAuthorization()
                
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationManager.requestWhenInUseAuthorization()
                if CLLocationManager.locationServicesEnabled() {
                    self.locationManager.delegate = self
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    self.locationManager.startUpdatingLocation()
                }
                hasPermission = true
            @unknown default:
                break
            }
        } else {
            hasPermission = false
        }
        
        return hasPermission
    }
    
    // TODO: Setup Category
    func setupCategoryView() {
        self.CategoryView.backgroundColor = ModeBG_Color
        self.CategoryView.indicatorColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.CategoryView.titleFont = UIFont.boldSystemFont(ofSize: 17)
        self.CategoryView.normalTitleColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.CategoryView.selectedTitleColor = UIColor.white
        self.CategoryView.titles = self.getCatNameArray()!
        self.CategoryView.valueChange = { obj in
            self.SelectedMainCat = self.getMaincatOBJ(dataObj: obj)
            self.SubCat_API(mainCategoryId: self.SelectedMainCat.mainCategoryId)
            self.FoodListTBL.reloadData()
        }
    }
    
    func getCatNameArray() -> [PintrestTitle]? {
        let array = self.MainCatArry.compactMap { obj in
            return PintrestTitle.init(id: obj.id, sub_id: obj.mainCategoryId, title: obj.mainCategoryName)
        }
        if array.count != 0 {
            self.SelectedMainCat = self.getMaincatOBJ(dataObj: array.first!)
            self.SubCat_API(mainCategoryId: self.SelectedMainCat.mainCategoryId)
        }
        var lastobj: [PintrestTitle]! = []
        for item in array {
            if item.title?.uppercased() == "Breakfast".uppercased() && lastobj.count < 2 {
                lastobj.append(item)
            }
            else if item.title?.uppercased() == "Brunch".uppercased() && lastobj.count < 2 {
                lastobj.append(item)
            }
        }
        return lastobj
    }
    
    func getMaincatOBJ(dataObj: PintrestTitle) -> MainCategoryData? {
        let Singleobj = self.MainCatArry.filter { obj in
            return obj.mainCategoryName.uppercased() == dataObj.title?.uppercased() && obj.mainCategoryId == dataObj.sub_id
        }
        return Singleobj.first
    }
    
    // TODO: Setup SubCategory
    
    func SubCat_API(mainCategoryId: String) {
        let param = SubCatParamDict.init(id: mainCategoryId)
        NetworkingRequests.shared.GetSubCategoryListing(param: param) { (subcatData, status) in
            if status {
                self.SubCatArry.removeAll()
                if subcatData.subCategoryData.count != 0 && subcatData.status {
                    self.SubCatArry = subcatData.subCategoryData
                    self.FoodListTBL.reloadData()
                }
            }
            else {
                self.navigationController?.view.makeToast(subcatData.message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
                self.SubCatArry.removeAll()
            }
            self.SubCatView.reloadInputViews()
            self.setupsubcatview()
        } onFailure: { (message) in
            self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            self.SubCatArry.removeAll()
            self.SubCatView.reloadInputViews()
            self.setupsubcatview()
        }
    }
    
    func setupsubcatview() {
        if self.SelectedMainCat == nil {
            self.subHeaderView.isHidden = true
        }
        else {
            if self.SubCatArry.count == 0 {
                self.SubCatView.isHidden = true
                self.SubCatView2.isHidden = true
                self.SubCat_Height.constant = 0
                self.subHeaderView.isHidden = true
                self.FilterWithSub = false
            }
            else {
                self.SubCat_Height.constant = 55
                self.subHeaderView.isHidden = false
                self.FilterSwitch.isOn = false
                self.FilterWithSub = true
                if self.MultipleSelect {
                    self.SubCatView.isHidden = true
                    self.SubCatView2.isHidden = false
                    self.SubCatView2.allowsSelection = true
                    self.SubCatView2.register(UINib(nibName:"SubCategoryCells", bundle: nil), forCellWithReuseIdentifier: "SubCategoryCells")
                    
                    self.SubCatView2.delegate = self
                    self.SubCatView2.dataSource = self
                    self.SubCatView2.reloadData()
                }
                else  {
                    self.SubCatView.isHidden = false
                    self.SubCatView2.isHidden = true
                    self.FilterSwitch.onTintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
                    self.subHeaderView.backgroundColor = ModeBG_Color
                    self.FilterView.backgroundColor = ModeBG_Color
                    self.SubCatView.backgroundColor = ModeBG_Color
                    self.SubCatView.indicatorColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
                    self.SubCatView.titleFont = UIFont.boldSystemFont(ofSize: 17)
                    self.SubCatView.normalTitleColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
                    self.SubCatView.selectedTitleColor = UIColor.white
                    self.SubCatView.titles = self.getSubCatNameArray()!
                    self.SubCatView.valueChange = { index in
                        self.SelectedSubCat = self.getSubcatOBJ(dataObj: index)
                        self.FoodListTBL.reloadData()
                    }
//                    self.SubCatView.CheckUncheckvalueChange = { index in
//                        self.SelectedSubCat = self.getSubcatOBJ(dataObj: index)
//                        self.FoodListTBL.reloadData()
//                    }
                    self.subHeaderView.isHidden = false
                    self.GettingDataFromServer()
                }
            }
        }
    }
    
    func getSubCatNameArray() -> [PintrestTitle]? {
//        var final: [PintrestTitle] = [PintrestTitle.init(id: 1, sub_id: "", title: "All")]
        var final: [PintrestTitle] = []
        final.append(contentsOf: self.SubCatArry.compactMap { obj in
            return PintrestTitle.init(id: obj.id, sub_id: obj.subCategoryId, title: obj.subCategoryName)
        })
        if final.count != 0 {
            self.SelectedSubCat = self.getSubcatOBJ(dataObj: final.first!)
        }
        return final
    }
    
    func getSubcatOBJ(dataObj: PintrestTitle) -> SubCategoryData? {
        let Singleobj = self.SubCatArry.filter { obj in
            return obj.subCategoryName?.uppercased() == dataObj.title!.uppercased()
        }
        return Singleobj.first
    }
    
    // TODO: Call Food API
    func GettingDataFromServer() {
        NetworkingRequests.shared.GetbannerListing { (responseObject, status) in
            if status || responseObject.status {
                self.Bannerarry.removeAll()
                self.Bannerarry = responseObject.data.banner
            }
            else {
                self.navigationController?.view.makeToast(responseObject.message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            }
        } onFailure: { (message) in
            self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
        }
        
        let params = ListingParamDict.init(CatName: self.SelectedMainCat.mainCategoryName, SubCatName: self.SelectedSubCat.subCategoryName)
        NetworkingRequests.shared.GetFoodListing(param: params) { (responseObject, status) in
            if status {
                if responseObject.menuData.data.count >= 1 {
                    self.MenuItems_arry.removeAll()
                    self.MenuItems_arry = responseObject.menuData.data
                    self.filter_MenuItems = self.MenuItems_arry
                    self.FoodListTBL.reloadData()
                }
            }
            else {
                self.navigationController?.view.makeToast(responseObject.message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            }
        } onFailure: { (message) in
            self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
        }
    }
    
    func cellcount() -> Int {
        var count: Int = 0
        if self.FilterWithSub {
            count = self.GetFinalFoodwithSubArry().count
        }
        else {
            count = self.GetFinalFoodwithSubArry().count
        }
        print("Total Food array: \(count)")
        if count == 0 {
            self.NodataFoundView.isHidden = false
            self.FoodListTBL.isHidden = true
        }
        else {
            self.NodataFoundView.isHidden = true
            self.FoodListTBL.isHidden = false
        }
        return count
    }
    
    func getVegfoodOnly() -> [MenuItemsData] {
        let veg = self.MenuItems_arry.filter { obj in
            return true
        }
        return veg
    }
    
    func getbothfood() -> [MenuItemsData] {
        return self.MenuItems_arry
    }
    
    func GetFoodMultiArry() -> [MenuItemsData]? {
        var filter: [MenuItemsData] = []
        if self.FilterSwitch.isOn {
            if self.MultipleSelect {
                if self.SelectedSubCatArry.count == 0 {
                    let data = self.getVegfoodOnly().filter { obj in
                        if self.SelectedSubCatArry.count == 0 {
//                            return ((obj.cattegory?.id == self.SelectedMainCat.id) && obj.isveg == true)
                            return (obj.itemMainCategoryName.uppercased() == self.SelectedMainCat.mainCategoryName.uppercased())
                        }
                        else {
//                            return ((self.SelectedSubCatArry.first(where: { $0.id == obj.subCattegory?.id }) != nil) && (obj.cattegory?.id == self.SelectedMainCat.id) && obj.isveg == true)
                            return ((self.SelectedSubCatArry.first(where: { $0.subCategoryName.uppercased() == obj.itemSubCategoryName.uppercased() }) != nil) && (obj.itemMainCategoryName?.uppercased() == self.SelectedMainCat.mainCategoryName.uppercased()) && obj.itemFoodType.uppercased() == "Veg".uppercased())
                        }
                    }
                    if self.IsSearching && self.SearchSTR.count > 0 {
                        let searchData = data.filter { obj in
                            return (obj.itemName?.lowercased().contains(self.SearchSTR.lowercased()))!
                        }
                        filter = searchData
                    }
                    else {
                        filter = data
                    }
                }
                else {
                    let data = self.getVegfoodOnly().filter { obj in
                        if self.SelectedSubCatArry.count == 0 {
//                            return ((obj.cattegory?.id == self.SelectedMainCat.id) && obj.isveg == true)
                            return (obj.itemMainCategoryName.uppercased() == self.SelectedMainCat.mainCategoryName.uppercased() && obj.itemFoodType.uppercased() == "Veg".uppercased())
                        }
                        else {
                            return (self.SelectedSubCatArry.first(where: { $0.subCategoryName.uppercased() == obj.itemSubCategoryName.uppercased() }) != nil)
                        }
                    }
                    if self.IsSearching && self.SearchSTR.count > 0 {
                        let searchData = data.filter { obj in
                            return (obj.itemName?.lowercased().contains(self.SearchSTR.lowercased()))!
                        }
                        filter = searchData
                    }
                    else {
                        filter = data
                    }
                }
            }
        }
        else {
            var data: [MenuItemsData] = []
            if self.SelectedSubCatArry.count == 0 {
                data = self.MenuItems_arry
            }
            else {
                data = self.MenuItems_arry.filter { obj in
//                    return ((self.SelectedSubCatArry.first(where: { $0.id == obj.subCattegory?.id }) != nil) && (obj.cattegory?.id == self.SelectedMainCat.id))
                    return ((self.SelectedSubCatArry.first(where: { $0.subCategoryName.uppercased() == obj.itemSubCategoryName.uppercased() }) != nil) && (obj.itemMainCategoryName.uppercased() == self.SelectedMainCat.mainCategoryName.uppercased()))
                }
            }
            if self.IsSearching && self.SearchSTR.count > 0 {
                let searchData = data.filter { obj in
                    return (obj.itemName?.lowercased().contains(self.SearchSTR.lowercased()))!
                }
                filter = searchData
            }
            else {
                filter = data
            }
        }
        return filter
    }
    
    func GetFinalFoodwithSubArry() -> [MenuItemsData] {
        var filter: [MenuItemsData] = []
        if self.FilterSwitch.isOn {
            if self.MultipleSelect {
                filter = self.GetFoodMultiArry()!
            }
            else {
                let data = self.getVegfoodOnly().filter { obj in
                    if self.SelectedSubCat == nil {
//                        return ((obj.cattegory?.id == self.SelectedMainCat.id) && obj.isveg == true)
                        return (obj.itemMainCategoryName.uppercased() == self.SelectedMainCat.mainCategoryName.uppercased() && obj.itemFoodType.uppercased() == "Veg".uppercased())
                    }
                    else {
//                        return ((obj.subCattegory?.id == self.SelectedSubCat.id) && (obj.cattegory?.id == self.SelectedMainCat.id) && obj.isveg == true)
                        return ((obj.itemSubCategoryName.uppercased() == self.SelectedSubCat.subCategoryName.uppercased()) && (obj.itemMainCategoryName.uppercased() == self.SelectedMainCat.mainCategoryName.uppercased() && obj.itemFoodType.uppercased() == "Veg".uppercased()))
                    }
                }
                if self.IsSearching && self.SearchSTR.count > 0 {
                    let searchData = data.filter { obj in
                        return (obj.itemName?.lowercased().contains(self.SearchSTR.lowercased()))!
                    }
                    filter = searchData
                }
                else {
                    filter = data
                }
            }
        }
        else {
            if self.MultipleSelect {
                filter = self.GetFoodMultiArry()!
            }
            else {
                var data: [MenuItemsData] = []
                if self.SelectedSubCat == nil {
                    data = self.MenuItems_arry
                }
                else {
                    data = self.MenuItems_arry.filter { obj in
//                        return ((obj.subCattegory?.id == self.SelectedSubCat.id) && (obj.cattegory?.id == self.SelectedMainCat.id))
                        return ((obj.itemSubCategoryName.uppercased() == self.SelectedSubCat.subCategoryName.uppercased()) && (obj.itemMainCategoryName.uppercased() == self.SelectedMainCat.mainCategoryName.uppercased()))
                    }
                }
                if self.IsSearching && self.SearchSTR.count > 0 {
                    let searchData = data.filter { obj in
                        return (obj.itemName?.lowercased().contains(self.SearchSTR.lowercased()))!
                    }
                    filter = searchData
                }
                else {
                    filter = data
                }
            }
        }
        return filter
    }
    
    //    MARK:- IBActions Methods
    //    MARK:-
    
    @IBAction func TappedFilterSwitch(_ sender: Any) {
        self.FoodListTBL.reloadData()
    }
    
}

//MARK:- Location methods
//MARK:-

extension HomeListingVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let placemark = (placemarks?[0])! as CLPlacemark
                
                self.navheaderView.fillinfo(title: String.init(format: "%@ %@ %@ %@", (placemark.locality != nil) ? placemark.locality! : "", (placemark.postalCode != nil) ? placemark.postalCode! : "", (placemark.administrativeArea != nil) ? placemark.administrativeArea! : "", (placemark.country != nil) ? placemark.country! : ""))
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.navigationController?.view.makeToast("We are unable to get your current location please, try it again!".localized(), duration: 3.0, position: .top, title: "User Location failed".localized(), image: nil)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
    
}


//MARK:- SearchBar Delegate
//MARK:-

extension HomeListingVC: UISearchBarDelegate {
    
    func Get_GlobalSearch() {
        let params = GlobalSearcgDict.init(itemSearchKey: self.SearchSTR)
        NetworkingRequests.shared.GlobalSearchlist(param: params) { (responseObject, status) in
            if status {
                if responseObject.menuData.data.count >= 1 {
                    self.MenuItems_arry = responseObject.menuData.data
                    self.filter_MenuItems = self.MenuItems_arry
                }
            }
            else {
                self.navigationController?.view.makeToast(responseObject.message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            }
            self.FoodListTBL.reloadData()
        } onFailure: { (message) in
            self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            self.FoodListTBL.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.SearchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentString: NSString = searchBar.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: text) as NSString
        let usersearch = newString as String
        if self.FilterWithSub {
            self.SearchSTR = usersearch
            self.IsSearching = true
        }
        else {
            self.filter_MenuItems.removeAll()
            self.filter_MenuItems = self.MenuItems_arry.filter({ obj in
                return (obj.itemName?.lowercased().contains(usersearch.lowercased()))!
            })
        }
        if newString.length >= 4 {
            self.Get_GlobalSearch()
        }
        
        self.FoodListTBL.reloadData()
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if self.FilterWithSub {
            self.SearchSTR = self.SearchBar.text!
            self.IsSearching = true
        }
        else {
            self.filter_MenuItems.removeAll()
            self.filter_MenuItems = self.MenuItems_arry.filter({ obj in
                return (obj.itemName?.lowercased().contains(self.SearchBar.text!.lowercased()))!
            })
        }
        self.Get_GlobalSearch()
        self.FoodListTBL.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.SearchBar.showsCancelButton = false
        if self.FilterWithSub {
            self.SearchBar.text = ""
            self.IsSearching = false
        }
        else {
            self.filter_MenuItems.removeAll()
            self.filter_MenuItems = self.MenuItems_arry
        }
        self.GettingDataFromServer()
        self.SearchBar.resignFirstResponder()
        self.FoodListTBL.reloadData()
    }
    
}

//MARK:- UITableViewDelegate
//MARK:-

extension HomeListingVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.Bannerarry.count : self.cellcount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return self.SetupBannerCell(indexPath: indexPath)
        }
        else {
            if self.FilterWithSub {
                return self.SetupFoodCell(indexPath: indexPath)
            }
            else {
                return self.SetupMealCell(indexPath: indexPath)
            }
        }
    }
    
    @objc func didSelectRowAt(sender : AppGesture) {
        self.tableView(self.FoodListTBL, didSelectRowAt: sender.indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HomeDetailsVC(nibName: "HomeDetailsVC", bundle: nil)
        if indexPath.section == 0 {
            let banner = self.Bannerarry[indexPath.row]
            vc.DetailType = .Banner
            vc.BannerDetails = banner
        }
        else {
            if self.FilterWithSub {
                let food = self.GetFinalFoodwithSubArry()[indexPath.row]
                vc.FoodDetails = food
                vc.DetailType = .Food
            }
            else {
//                let meal = self.MenuItems_arry[indexPath.row]
//                vc.DetailType = .Meals
//                vc.MealDetails = meal
            }
        }
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func SetupBannerCell(indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeBannerCell = self.FoodListTBL.dequeueReusableCell(withIdentifier: "HomeBannerCell") as! HomeBannerCell
        cell.setupBannercell(banner: self.Bannerarry[indexPath.row])
        let tap = AppGesture(target: self, action: #selector(self.didSelectRowAt(sender:)))
        tap.indexPath = indexPath
        cell.addGestureRecognizer(tap)
        return cell
    }
    
    func SetupFoodCell(indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeFoodListCell = self.FoodListTBL.dequeueReusableCell(withIdentifier: "HomeFoodListCell") as! HomeFoodListCell
        cell.setupfoodcell(food: self.GetFinalFoodwithSubArry()[indexPath.row])
        cell.didCartActionBlock = {
            if SharedUserInfo.shared.IsUserLoggedin()! {
                //                cell.AddCartBTN.isHidden = true
                //                cell.QTY_View.isHidden = false
                //                cell.QTY_Count = 1
                //                cell.QTY_LBL.text = String.init(format: "%d", cell.QTY_Count)
                self.tableView(self.FoodListTBL, didSelectRowAt: indexPath)
            }
            else {
                let vc = LoginVC(nibName: "LoginVC", bundle: nil)
                vc.LoginSelected = 100
                self.navigationController!.pushViewController(vc, animated: true)
            }
        }
        cell.didMinusActionBlock = {
            cell.QTY_Count -= 1
            cell.QTY_LBL.text = String.init(format: "%d", cell.QTY_Count)
            if cell.QTY_Count <= 0 {
                cell.AddCartBTN.isHidden = false
                cell.QTY_View.isHidden = true
            }
        }
        cell.didPlusActionBlock = {
            cell.QTY_Count += 1
            cell.QTY_LBL.text = String.init(format: "%d", cell.QTY_Count)
        }
        let tap = AppGesture(target: self, action: #selector(self.didSelectRowAt(sender:)))
        tap.indexPath = indexPath
        cell.addGestureRecognizer(tap)
        return cell
    }
    
    func SetupMealCell(indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeFoodListCell = self.FoodListTBL.dequeueReusableCell(withIdentifier: "HomeFoodListCell") as! HomeFoodListCell
//        cell.setupmealcell(meal: self.filtermealArry[indexPath.row])
        
        let tap = AppGesture(target: self, action: #selector(self.didSelectRowAt(sender:)))
        tap.indexPath = indexPath
        cell.addGestureRecognizer(tap)
        
        return cell
    }
    
}

//MARK:- CollectionView Delegate and Datasource
//MARK:-
extension HomeListingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.SubCatArry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.configCell(indexPath: indexPath)
    }
    
    @objc func didSelectSubcatRowAt(sender : AppGesture) {
        self.collectionView(self.SubCatView2, didSelectItemAt: sender.indexPath)
    }
    
    func configCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.SubCatView2.dequeueReusableCell(withReuseIdentifier: "SubCategoryCells", for: indexPath as IndexPath) as! SubCategoryCells
        let tap = AppGesture(target: self, action: #selector(self.didSelectSubcatRowAt(sender:)))
        tap.indexPath = indexPath
        cell.addGestureRecognizer(tap)
        let obj = self.SubCatArry[indexPath.row]
        cell.TitleLBL.text = obj.subCategoryName
        if self.SelectedSubCatArry.count != 0 {
            let element = self.SelectedSubCatArry.filter { item in
                return item.id == obj.id
            }.first
            if element?.id == obj.id {
                cell.View.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
                cell.TitleLBL.textColor = .white
                cell.TitleLBL.font = UIFont.boldSystemFont(ofSize: 17)
            }
            else {
                cell.View.backgroundColor = UIColor.clear
                cell.TitleLBL.textColor = .label
                cell.TitleLBL.font = UIFont.systemFont(ofSize: 15)
            }
        }
        else {
            cell.View.backgroundColor = UIColor.clear
            cell.TitleLBL.textColor = .label
            cell.TitleLBL.font = UIFont.systemFont(ofSize: 15)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = self.SubCatArry[indexPath.row]
        if self.SelectedSubCatArry.count == 0 {
            self.SelectedSubCatArry.append(data)
        }
        else {
            let index = self.SelectedSubCatArry.enumerated().filter({ $0.element.id == data.id }).map({ $0.offset }).first
            if index == nil {
                self.SelectedSubCatArry.append(data)
            }
            else {
                self.SelectedSubCatArry.remove(at: index!)
            }
        }
        self.FoodListTBL.reloadData()
        self.SubCatView2.reloadData()
    }
    
}
