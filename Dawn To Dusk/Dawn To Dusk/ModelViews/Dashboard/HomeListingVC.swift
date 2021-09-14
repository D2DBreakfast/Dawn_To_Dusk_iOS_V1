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
                self.navigationController!.pushViewController(vc, animated: true)
            }
        }
        return header
    }()
    
    var SelectedMainCat: CategoryModels!
    var MainCatArry: [CategoryModels] = []
    
    var SelectedSubCat: CategoryModels!
    var SubCatArry: [CategoryModels] = []
    
    var Bannerarry: [BannerModelClass] = [
        BannerModelClass.init(id: 0, bannerName: "Package 0", bannerImage: "https://source.unsplash.com/random/200x200", bannerdes: randomString(), bannerTitle: "Package 0")
    ]
    
    var FilterWithSub: Bool = true
    
    var SearchSTR: String = ""
    var IsSearching: Bool = false
    
    var foodArry: [FoodModels] = []
    var mealArry: [MealsModels] = []
    var filtermealArry: [MealsModels] = []
    
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
//            self.NodataFoundView.fillinfo(title: "No Internet", Notes: "There is no internet available in device. Please check your setting and try it again!", image: "NoInternetIMG", enable: true)
//            self.NodataFoundView.isHidden = false
//            self.FoodListTBL.isHidden = true
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
        
        NetworkingRequests.shared.GetFoodListing(param: ListingParamDict.init(page: 1, count: 20)) { (responseObject, status) in
            if status {
                if responseObject.data.orders.count > 1 {
                    self.foodArry = responseObject.data.orders
                }
                if responseObject.data.meals.count > 1 {
                    self.mealArry = responseObject.data.meals
                    self.filtermealArry = self.mealArry
                }
            }
            else {
                self.navigationController?.view.makeToast(responseObject.message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            }
        } onFailure: { (message) in
            self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
        }

        self.SearchBar.delegate = self
        
        self.setupCategoryView()
        self.setupsubcatview()
        
        self.FoodListTBL.delegate = self
        self.FoodListTBL.dataSource = self
        self.FoodListTBL.reloadData()
        
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
    
    func setupCategoryView() {
        
        NetworkingRequests.shared.GetCategoryListing { (catData, status) in
            if status {
                if catData.data.category.count != 0 {
                    self.MainCatArry = catData.data.category
                }
            }
            else {
                self.navigationController?.view.makeToast(catData.message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            }
        } onFailure: { (message) in
            self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
        }

        self.CategoryView.backgroundColor = ModeBG_Color
        self.CategoryView.indicatorColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.CategoryView.titleFont = UIFont.boldSystemFont(ofSize: 17)
        self.CategoryView.normalTitleColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.CategoryView.selectedTitleColor = UIColor.white
        self.CategoryView.titles = self.getCatNameArray()!
        self.CategoryView.valueChange = { index in
            self.SelectedMainCat = self.getMaincatOBJ(name: index)
            if index.id == self.SelectedMainCat.id && index.title?.uppercased() == "Order".uppercased() {
                self.SubCat_Height.constant = 55
                self.subHeaderView.isHidden = false
                self.FilterSwitch.isOn = false
                self.FilterWithSub = true
            }
            else {
                self.filtermealArry.removeAll()
                self.filtermealArry = self.mealArry
                self.SubCat_Height.constant = 0
                self.subHeaderView.isHidden = true
                self.FilterWithSub = false
            }
            self.FoodListTBL.reloadData()
        }
    }
    
    func getCatNameArray() -> [PintrestTitle]? {
        let array = self.MainCatArry.compactMap { obj in
            return PintrestTitle.init(id: obj.id, title: obj.catName)
        }
        self.SelectedMainCat = self.getMaincatOBJ(name: array.first!)
        return array
    }
    
    func getMaincatOBJ(name: PintrestTitle) -> CategoryModels? {
        let Singleobj = self.MainCatArry.filter { obj in
            return obj.catName?.uppercased() == name.title!.uppercased()
        }
        return Singleobj.first
    }
    
    func setupsubcatview() {

        NetworkingRequests.shared.GetSubCategoryListing(param: SubCatParamDict.init(id: self.SelectedMainCat.id)) { (subcatData, status) in
            if status {
                if subcatData.data.category.count != 0 {
                    self.SubCatArry = subcatData.data.category
                }
            }
            else {
                self.navigationController?.view.makeToast(subcatData.message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            }
        } onFailure: { (message) in
            self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
        }
        
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
            self.SelectedSubCat = self.getSubcatOBJ(name: index)
            self.FoodListTBL.reloadData()
        }
    }
    
    func getSubCatNameArray() -> [PintrestTitle]? {
        let array = self.SubCatArry.compactMap { obj in
            return PintrestTitle.init(id: obj.id, title: obj.catName)
        }
        self.SelectedSubCat = self.getSubcatOBJ(name: array.first!)
        return array
    }
    
    func getSubcatOBJ(name: PintrestTitle) -> CategoryModels? {
        let Singleobj = self.SubCatArry.filter { obj in
            return obj.catName?.uppercased() == name.title!.uppercased()
        }
        return Singleobj.first
    }
    
    func cellcount() -> Int {
        var count: Int = 0
        if self.FilterWithSub {
            count = self.GetFinalFoodwithSubArry().count
        }
        else {
            count = self.filtermealArry.count
        }
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
    
    func getVegfoodOnly() -> [FoodModels] {
        let veg = self.foodArry.filter { obj in
            return obj.isveg == true
        }
        return veg
    }
    
    func getbothfood() -> [FoodModels] {
        return self.foodArry
    }
    
    func GetFinalFoodwithSubArry() -> [FoodModels] {
        var filter: [FoodModels] = []
        if self.FilterSwitch.isOn {
            let data = self.getVegfoodOnly().filter { obj in
                return ((obj.subCattegory?.id == self.SelectedSubCat.id || obj.subCattegory?.catName?.uppercased() == self.SelectedSubCat.catName?.uppercased()) && (obj.cattegory?.id == self.SelectedMainCat.id || obj.cattegory?.catName?.uppercased() == self.SelectedMainCat.catName?.uppercased()) && obj.isveg == true)
            }
            if self.IsSearching && self.SearchSTR.count > 0 {
                let searchData = data.filter { obj in
                    return (obj.title?.lowercased().contains(self.SearchSTR.lowercased()))!
                }
                filter = searchData
            }
            else {
                filter = data
            }
        }
        else {
            let data = self.foodArry.filter { obj in
                return ((obj.subCattegory?.id == self.SelectedSubCat.id || obj.subCattegory?.catName?.uppercased() == self.SelectedSubCat.catName?.uppercased()) && (obj.cattegory?.id == self.SelectedMainCat.id || obj.cattegory?.catName?.uppercased() == self.SelectedMainCat.catName?.uppercased()))
            }
            if self.IsSearching && self.SearchSTR.count > 0 {
                let searchData = data.filter { obj in
                    return (obj.title?.lowercased().contains(self.SearchSTR.lowercased()))!
                }
                filter = searchData
            }
            else {
                filter = data
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
            self.filtermealArry.removeAll()
            self.filtermealArry = self.mealArry.filter({ obj in
                return (obj.title?.lowercased().contains(usersearch.lowercased()))!
            })
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
            self.filtermealArry.removeAll()
            self.filtermealArry = self.mealArry.filter({ obj in
                return (obj.title?.lowercased().contains(self.SearchBar.text!.lowercased()))!
            })
        }
        self.FoodListTBL.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.SearchBar.showsCancelButton = false
        if self.FilterWithSub {
            self.SearchBar.text = ""
            self.IsSearching = false
        }
        else {
            self.filtermealArry.removeAll()
            self.filtermealArry = self.mealArry
        }
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
                let meal = self.filtermealArry[indexPath.row]
                vc.DetailType = .Meals
                vc.MealDetails = meal
            }
        }
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func SetupBannerCell(indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeBannerCell = self.FoodListTBL.dequeueReusableCell(withIdentifier: "HomeBannerCell") as! HomeBannerCell
        cell.setupBannercell(food: self.Bannerarry[indexPath.row])
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
        cell.setupmealcell(meal: self.filtermealArry[indexPath.row])
        
        let tap = AppGesture(target: self, action: #selector(self.didSelectRowAt(sender:)))
        tap.indexPath = indexPath
        cell.addGestureRecognizer(tap)
        
        return cell
    }
    
}
