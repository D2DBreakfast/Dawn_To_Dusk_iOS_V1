//
//  NotificationVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 26/07/21.
//

import UIKit
import MapKit
import CoreLocation

class NotificationVC: BaseClassVC {
    
    //    MARK:- IBOutlet Define
    //    MARK:-
    
    @IBOutlet weak var NodataFoundView: NodataView! {
        didSet {
            self.NodataFoundView.fillinfo(title: "No data available!", Notes: "There are no Data available yet!", image: "", enable: false)
            self.NodataFoundView.didActionBlock = {
                self.setupUI()
            }
        }
    }
    @IBOutlet weak var ListTBL: TPKeyboardAvoidingTableView! {
        didSet {
            self.ListTBL.register(UINib.init(nibName: "BasicTableCell", bundle: nil), forCellReuseIdentifier: "BasicTableCell")
            self.ListTBL.register(UINib.init(nibName: "HomeBannerCell", bundle: nil), forCellReuseIdentifier: "HomeBannerCell")
            self.ListTBL.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: 180))
            self.ListTBL.backgroundColor = ModeBG_Color
        }
    }
    
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
    
    var notificationarry: [NotificationModelClass] = dummyNotification()
    var Bannerarry: [BannerModelClass] = [
        BannerModelClass.init(id: 0, bannerName: "Package 0", bannerImage: "https://source.unsplash.com/random/200x200", bannerdes: "", bannerTitle: "Package 0")
    ]
    
    //    MARK:- View Cycle
    //    MARK:-
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toogleTabbar(hide: false)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navheaderView.fillinfo(title: "Notification")
        navigationItem.titleView = self.navheaderView
        self.setupUI()
        if !self.hasLocationPermission() {
            self.navigationController?.view.makeToast("We wont be able to get your current location please, try it again!".localized(), duration: 3.0, position: .top, title: "User Location failed".localized(), image: nil)
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
        self.ListTBL.delegate = self
        self.ListTBL.dataSource = self
        self.ListTBL.reloadData()
        
        self.NodataFoundView.backgroundColor = ModeBG_Color
        self.NodataFoundView.fillinfo(title: "No data available!", Notes: "There are no Data available yet!", image: "", enable: false)
        self.NodataFoundView.didActionBlock = {
            self.setupUI()
        }
    }
    
    func cellcount() -> Int {
        let count: Int = self.notificationarry.count
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

extension NotificationVC: CLLocationManagerDelegate {
    
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
        self.navigationController?.view.makeToast("We wont be able to get your current location please, try it again!".localized(), duration: 3.0, position: .top, title: "User Location failed".localized(), image: nil)
//        AlertView.showSingleAlertVC(withTitle: "User Location failed".localized(), withMessage: "We wont be able to get your current location please, try it again!".localized(), withconfirmbtn: "OK".localized(), withcontroller: self, withTureBlock: {
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

extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    
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
            return self.SetupNotificationCell(indexPath: indexPath)
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
            let notification = self.notificationarry[indexPath.row]
            vc.notificationDetails = notification
            vc.DetailType = .Notification
        }
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func SetupBannerCell(indexPath: IndexPath) -> UITableViewCell {
        if self.Bannerarry.count == 0 {
            return UITableViewCell().setupDefaultCell()
        }
        else {
            let cell: HomeBannerCell = self.ListTBL.dequeueReusableCell(withIdentifier: "HomeBannerCell") as! HomeBannerCell
            cell.setupBannercell(food: self.Bannerarry[indexPath.row])
            
            let tap = AppGesture(target: self, action: #selector(self.didSelectRowAt(sender:)))
            tap.indexPath = indexPath
            cell.addGestureRecognizer(tap)
            
            return cell
        }
    }
    
    func SetupNotificationCell(indexPath: IndexPath) -> UITableViewCell {
        if self.notificationarry.count == 0 {
            return UITableViewCell().setupDefaultCell()
        }
        else {
            let cell: BasicTableCell = self.ListTBL.dequeueReusableCell(withIdentifier: "BasicTableCell") as! BasicTableCell
            
            let tap = AppGesture(target: self, action: #selector(self.didSelectRowAt(sender:)))
            tap.indexPath = indexPath
            cell.addGestureRecognizer(tap)
            
            cell.setupcell(data: self.notificationarry[indexPath.row], indexPath: indexPath)
            
            return cell
        }
    }
    
}
