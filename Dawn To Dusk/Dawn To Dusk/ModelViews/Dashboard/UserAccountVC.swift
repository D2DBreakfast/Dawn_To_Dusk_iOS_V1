//
//  UserAccountVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 26/07/21.
//

import UIKit
import MapKit
import CoreLocation
import UserNotifications


class UserProfilesOption {
    var title: String?
    var image: String?
    
    init(title: String?, image: String?) {
        self.title = title
        self.image = image
    }
    
}


class UserAccountVC: BaseClassVC {
    
    //    MARK:- IBoutlet Defines
    //    MARK:-
    
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
                    AlertView.showAleartVc(withTitle: "Logout Permission", withMessage: "Are you sure you wanted to Logout from this account?", withconfirmbtn: "Confirm", withcontroller: self) {
                        SharedUserInfo.shared.UserLogout()
                        self.reloadViewFromNib()
                        header.CartBTN.isHidden = false
                        header.LogoutBTN.isHidden = true
                        self.toogleTabbar(hide: false)
                        self.setupUI()
                    } withCancelBlock: {
                        
                    }
                }
            }
            else {
                let vc = LoginVC(nibName: "LoginVC", bundle: nil)
                self.navigationController!.pushViewController(vc, animated: true)
            }
        }
        return header
    }()
    
    let userinfo = SharedUserInfo.shared.GetUserInfodata()
    
    let option: [UserProfilesOption] = [
        UserProfilesOption.init(title: "Help & Supports", image: "HelpSupportIC"),
        UserProfilesOption.init(title: "Payments mode", image: "PaymentIC"),
        UserProfilesOption.init(title: "Addresses", image: "LocationIC"),
        UserProfilesOption.init(title: "Order History", image: "HistoryIC"),
        UserProfilesOption.init(title: "App settings", image: "SettingIC"),
    ]
    
    //    MARK:- View Cycle
    //    MARK:-
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navheaderView.fillinfo(title: "Accounts", isUserProfile: SharedUserInfo.shared.IsUserLoggedin()!)
        toogleTabbar(hide: false)
        self.navigationController?.navigationBar.isHidden = false
        self.setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = self.navheaderView
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
        
        self.view.backgroundColor = TBLBackgroundCOlor
        
        self.ListTBL.register(UINib.init(nibName: "UserOptionCell", bundle: nil), forCellReuseIdentifier: "UserOptionCell")
        self.ListTBL.register(UINib.init(nibName: "ProfileInfoCell", bundle: nil), forCellReuseIdentifier: "ProfileInfoCell")
        self.ListTBL.backgroundColor = TBLBackgroundCOlor
        self.ListTBL.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: 180))
        
        self.ListTBL.delegate = self
        self.ListTBL.dataSource = self
        self.ListTBL.reloadData()
    }
    
    //    MARK:- IBActions Methods
    //    MARK:-
    
    
}

//MARK:- Location methods
//MARK:-

extension UserAccountVC: CLLocationManagerDelegate {
    
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
                
                self.navheaderView.fillinfo(title: String.init(format: "%@ %@ %@ %@", (placemark.locality != nil) ? placemark.locality! : "", (placemark.postalCode != nil) ? placemark.postalCode! : "", (placemark.administrativeArea != nil) ? placemark.administrativeArea! : "", (placemark.country != nil) ? placemark.country! : ""), isUserProfile: SharedUserInfo.shared.IsUserLoggedin()!)
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

//MARK:- UITableViewDelegate
//MARK:-

extension UserAccountVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.option.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tap = AppGesture(target: self, action: #selector(self.didSelectRowAt(sender:)))
        tap.indexPath = indexPath
        
        if indexPath.section == 0 {
            if SharedUserInfo.shared.IsUserLoggedin()! {
                let cell: ProfileInfoCell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell") as! ProfileInfoCell
                cell.SetupUserInfoCell(IndexPath: indexPath)
                cell.addGestureRecognizer(tap)
                return cell
            }
            else {
                let cell: UserOptionCell = tableView.dequeueReusableCell(withIdentifier: "UserOptionCell") as! UserOptionCell
                cell.setupSession()
                cell.didTappedAction1Block = {
                    let vc = RegisterVC(nibName: "RegisterVC", bundle: nil)
                    self.navigationController!.pushViewController(vc, animated: true)
                }
                cell.didTappedAction2Block = {
                    let vc = LoginVC(nibName: "LoginVC", bundle: nil)
                    self.navigationController!.pushViewController(vc, animated: true)
                }
                return cell
            }
        }
        else {
            let cell: UserOptionCell = tableView.dequeueReusableCell(withIdentifier: "UserOptionCell") as! UserOptionCell
            let option = self.option[indexPath.row]
            cell.SetupOptionCell(image: option.image!, title: option.title!)
            cell.addGestureRecognizer(tap)
            return cell
        }
    }
    
    @objc func didSelectRowAt(sender : AppGesture) {
        self.tableView(self.ListTBL, didSelectRowAt: sender.indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if SharedUserInfo.shared.IsUserLoggedin()! {
            if indexPath.section == 0 {
                let vc = EditFormVC.init(nibName: "EditFormVC", bundle: nil)
                vc.FormType = .EditProfile
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                switch indexPath.row {
                case 0:
                    let vc = HomeDetailsVC.init(nibName: "HomeDetailsVC", bundle: nil)
                    vc.DetailType = .Supports
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                    
                case 1:
                    let vc = HomeDetailsVC.init(nibName: "HomeDetailsVC", bundle: nil)
                    vc.DetailType = .Payment
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                    
                case 2:
                    let vc = HomeDetailsVC.init(nibName: "HomeDetailsVC", bundle: nil)
                    vc.DetailType = .Address
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                    
                case 3:
                    // Pending Carts
//                    let vc = HomeDetailsVC.init(nibName: "HomeDetailsVC", bundle: nil)
//                    vc.DetailType = .History
//                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                    
                case 4:
                    let vc = HomeDetailsVC.init(nibName: "HomeDetailsVC", bundle: nil)
                    vc.DetailType = .Settings
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                    
                default:
                    break
                }
            }
        }
        else {
            let vc = LoginVC(nibName: "LoginVC", bundle: nil)
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    
}

