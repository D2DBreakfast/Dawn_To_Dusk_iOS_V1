//
//  GlobalSearchVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 26/07/21.
//

import UIKit
import MapKit
import CoreLocation

class GlobalSearchVC: BaseClassVC {
    
    //    MARK:- IBOutlet Define
    //    MARK:-
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var NodataFoundView: NodataView!
    @IBOutlet weak var ListTBL: TPKeyboardAvoidingTableView!
    
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
    
    var Bannerarry: [BannerModelClass] = [
        BannerModelClass.init(id: 0, bannerName: "Package 0", bannerImage: "https://source.unsplash.com/random/200x200", bannerdes: randomString(), bannerTitle: "Package 0")
    ]
    
    var SearchSTR: String = ""
    var IsSearching: Bool = false
    
    var foodArry: [FoodModels] = []
    var mealArry: [MealsModels] = []
    var filterfood: [FoodModels] = []
    var filtermeal: [MealsModels] = []
    
    //    MARK:- View Cycle
    //    MARK:-
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toogleTabbar(hide: false)
        self.view.backgroundColor = ModeBG_Color
        self.navigationController?.navigationBar.isHidden = false
        for item in self.view.subviews {
            item.backgroundColor = ModeBG_Color
        }
        
        self.ListTBL.register(UINib.init(nibName: "HomeBannerCell", bundle: nil), forCellReuseIdentifier: "HomeBannerCell")
        self.ListTBL.register(UINib.init(nibName: "HomeFoodListCell", bundle: nil), forCellReuseIdentifier: "HomeFoodListCell")
        self.ListTBL.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: 180))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navheaderView.fillinfo(title: "Search")
        navigationItem.titleView = self.navheaderView
        self.setupUI()
        if !self.hasLocationPermission() {
            self.navigationController?.view.makeToast("We are unable to get your current location please, try it again!".localized(), duration: 3.0, position: .top, title: "User Location failed".localized(), image: nil)
//            AlertView.showSingleAlertVC(withTitle: "User Location failed".localized(), withMessage: "We are unable to get your current location please, try it again!".localized(), withconfirmbtn: "OK".localized(), withcontroller: self, withTureBlock: {
//                _ = self.hasLocationPermission()
//            })
        }
    }
    
    //    MARK:- User Custome Methods
    //    MARK:-
    
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
    
    override func setupUI() {
        self.SearchBar.delegate = self
        
        self.SearchBar.searchTextField.textColor = PrimaryText_Color
        
        self.ListTBL.delegate = self
        self.ListTBL.dataSource = self
        self.ListTBL.reloadData()
        
        self.NodataFoundView.backgroundColor = ModeBG_Color
        self.NodataFoundView.fillinfo(title: "No data available!", Notes: "There are no Data available yet!", image: "", enable: false)
        self.NodataFoundView.didActionBlock = {
            self.setupUI()
        }
    }
    
    func cellcount(section: Int) -> Int {
        var count: Int = 0
        if section == 0 {
            count = self.Bannerarry.count
        }
        else {
            if section == 1 {
                count = self.filterfood.count
            }
            else {
                count = self.filtermeal.count
            }
        }
        if count == 0 {
            self.NodataFoundView.isHidden = false
            self.ListTBL.isHidden = true
        }
        else {
            self.NodataFoundView.isHidden = true
            self.ListTBL.isHidden = false
        }
        return count
    }
    
    //    MARK:- IBActions Methods
    //    MARK:-
    
    
}

//MARK:- Location methods
//MARK:-

extension GlobalSearchVC: CLLocationManagerDelegate {
    
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
//        AlertView.showSingleAlertVC(withTitle: "User Location failed".localized(), withMessage: "We are unable to get your current location please, try it again!".localized(), withconfirmbtn: "OK".localized(), withcontroller: self, withTureBlock: {
//            _ = self.hasLocationPermission()
//        })
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

extension GlobalSearchVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.SearchBar.showsCancelButton = true
        self.IsSearching = true
        self.filterfood = self.foodArry
        self.filtermeal = self.mealArry
        self.ListTBL.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentString: NSString = searchBar.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: text) as NSString
        let usersearch = newString as String
        print(usersearch)
        self.filterfood.removeAll()
        self.filterfood = self.foodArry.filter({ obj in
            return (obj.title?.lowercased().contains(usersearch.lowercased()))!
        })
        
        self.filtermeal.removeAll()
        self.filtermeal = self.mealArry.filter({ obj in
            return (obj.title?.lowercased().contains(usersearch.lowercased()))!
        })
        
        self.IsSearching = true
        self.ListTBL.reloadData()
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.IsSearching = true
        self.ListTBL.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.SearchBar.showsCancelButton = false
        self.IsSearching = false
        self.filterfood.removeAll()
        self.filtermeal.removeAll()
        self.SearchBar.text = ""
        self.SearchBar.resignFirstResponder()
        self.ListTBL.reloadData()
    }
    
}

extension GlobalSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.IsSearching ? 3 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellcount(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : ((self.filterfood.count == 0 && section == 1) || (self.filtermeal.count == 0 && section == 2)) ? 0 : 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 || section == 2 {
            if section == 1 && self.filterfood.count == 0 {
                return nil
            }
            if section == 2 && self.filtermeal.count == 0 {
                return nil
            }
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: 40))
            view.backgroundColor = ModeBG_Color
            let lbl = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: Screen_width - 20, height: 40))
            lbl.text = section == 1 ? "Order List" : "Meal Plan List"
            lbl.font = UIFont.boldSystemFont(ofSize: 24)
            lbl.textColor = UIColor.label
            view.addSubview(lbl)
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: HomeBannerCell = tableView.dequeueReusableCell(withIdentifier: "HomeBannerCell") as! HomeBannerCell
            cell.setupBannercell(food: self.Bannerarry[indexPath.row])
            
            let tap = AppGesture(target: self, action: #selector(self.didSelectRowAt(sender:)))
            tap.indexPath = indexPath
            cell.addGestureRecognizer(tap)
            
            return cell
        }
        else {
            if indexPath.section == 1 {
                return self.ConfigcellwithFood(indexPath: indexPath)
            }
            else {
                return self.ConfigcellwithMeal(indexPath: indexPath)
            }
        }
    }
    
    func ConfigcellwithFood(indexPath: IndexPath) -> UITableViewCell {
        if self.filterfood.count == 0 {
            return UITableViewCell().setupDefaultCell()
        }
        else {
            let cell: HomeFoodListCell = self.ListTBL.dequeueReusableCell(withIdentifier: "HomeFoodListCell") as! HomeFoodListCell
            cell.setupfoodcell(food: self.filterfood[indexPath.row])
            cell.didCartActionBlock = {
                cell.AddCartBTN.isHidden = true
                cell.QTY_View.isHidden = false
                cell.QTY_Count = 1
                cell.QTY_LBL.text = String.init(format: "%d", cell.QTY_Count)
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
    }
    
    func ConfigcellwithMeal(indexPath: IndexPath) -> UITableViewCell {
        if self.filtermeal.count == 0 {
            return UITableViewCell().setupDefaultCell()
        }
        else {
            let cell: HomeFoodListCell = self.ListTBL.dequeueReusableCell(withIdentifier: "HomeFoodListCell") as! HomeFoodListCell
            cell.setupmealcell(meal: self.filtermeal[indexPath.row])
            
            let tap = AppGesture(target: self, action: #selector(self.didSelectRowAt(sender:)))
            tap.indexPath = indexPath
            cell.addGestureRecognizer(tap)
            
            return cell
        }
    }
    
    @objc func didSelectRowAt(sender : AppGesture) {
        self.tableView(self.ListTBL, didSelectRowAt: sender.indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HomeDetailsVC(nibName: "HomeDetailsVC", bundle: nil)
        if indexPath.section == 0 {
            let banner = self.Bannerarry[indexPath.row]
            vc.DetailType = .Banner
            vc.BannerDetails = banner
        }
        else {
            if self.IsSearching {
                if indexPath.section == 1 {
                    let food = self.filterfood[indexPath.row]
                    vc.FoodDetails = food
                    vc.DetailType = .Food
                }
                else {
                    let meal = self.filtermeal[indexPath.row]
                    vc.DetailType = .Meals
                    vc.MealDetails = meal
                }
            }
        }
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
}
