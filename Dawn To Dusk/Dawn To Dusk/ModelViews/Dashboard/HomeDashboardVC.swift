//
//  HomeDashboardVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 20/07/21.


import UIKit
import CoreLocation

class HomeDashboardVC: UITabBarController {
    
    //    MARK:- Varaible Definces
    //    MARK:-
    var hub: BadgeHub?
    
    let floatingTabbarView = FloatingBarView(["Home.tab", "CartIC", "Bell.tab", "Profile.tab"])
    
    var locationManager = CLLocationManager()
    
    lazy var TrackerVIew : UIView = {
//        let view = UIView(frame: CGRect(x: 25, y: 0.0, width: Screen_width - 50, height: 80.0))
        let view = UIView.init(frame: CGRect.init(x: 25, y: (Screen_height - 200), width: Screen_width - 50, height: 80))
        view.clipsToBounds = true
        view.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.4)
        view.isHidden = false
        view.addSubview(TrackMSG)
        view.addSubview(TrackBTN)
        let tap = UITapGestureRecognizer(target: self, action: #selector(TappedTrackBTN(_:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var TrackMSG: UILabel = {
        let lbl = UILabel.init(frame: CGRect.init(x: 15, y: 15, width: ((Screen_width / 2) - 60), height: 50))
        lbl.text = "Track your order here with status"
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.font = UIFont.systemFont(ofSize: 15.0)
        lbl.textColor = .label
        return lbl
    }()
    
    lazy var TrackBTN: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: (Screen_width - 210), y: 15, width: 150, height: 50))
        btn.GetThemeButtonwithBorder()
        btn.setTitle("Track Order", for: .normal)
        btn.addTarget(self, action: #selector(TappedTrackBTN(_:)), for: .touchUpInside)
        return btn
    }()
    
    //    MARK:- View Cycle
    //    MARK:-
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
//        NotificationCenter.default.post(name: Notification.Name(BdgeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SetupbadgeCount), name: Notification.Name(BdgeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Setupremovebadgecount), name: Notification.Name(RemoveBdgeNotification), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = self.hasLocationPermission()
        SharedUserInfo.shared.isFirstLaunch = true
        viewControllers = [
            createNavViewController(viewController: HomeListingVC.init(nibName: "HomeListingVC", bundle: nil), title: "Home", imageName: "Home.tab"),
            createNavViewController(viewController: CartManageVC.init(nibName: "CartManageVC", bundle: nil), title: "Cart", imageName: "CartIC"),
            createNavViewController(viewController: NotificationVC.init(nibName: "NotificationVC", bundle: nil), title: "Notification", imageName: "Bell.tab"),
            createNavViewController(viewController: UserAccountVC.init(nibName: "UserAccountVC", bundle: nil), title: "Profile", imageName: "Profile.tab")
        ]
        tabBar.isHidden = true
        tabBar.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        setupFloatingTabBar()
    }
    
    //    MARK:- Custom methods
    //    MARK:-
    
    func addTrackerview() {
        self.navigationController?.view.showToast(self.TrackerVIew, duration: 3.0, position: .top)
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
    
    private func createNavViewController(viewController: UIViewController, title: String, imageName: String = "") -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = false
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage.init(named: imageName)
        return navController
    }
    
    func setupFloatingTabBar() {
        self.floatingTabbarView.delegate = self
        self.view.addSubview(self.floatingTabbarView)
        if SharedUserInfo.shared.IsUserLoggedin()! {
//            self.addTrackerview()
//            self.view.addSubview(self.TrackerVIew)
        }
        self.SetupbadgeCount()
        self.floatingTabbarView.centerXInSuperview()
        self.floatingTabbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -BottomTabbarHeight).isActive = true
    }
    
    func toggle(hide: Bool) {
        floatingTabbarView.toggle(hide: hide)
        if SharedUserInfo.shared.IsUserLoggedin()! {
            self.TrackerVIew.isHidden = hide
        }
        else {
            self.TrackerVIew.isHidden = true
        }
    }
    
    func setupMainScreen(index: Int) {
        self.floatingTabbarView.updateUI(selectedIndex: index)
    }
    
    @objc func SetupbadgeCount() {
        if SharedUserInfo.shared.IsUserLoggedin()! {
            let param = MyCartParamDict.init(userId: SharedUserInfo.shared.GetUserInfoFromEnum(enums: .UserID))
            NetworkingRequests.shared.GetCartListingAPI(param: param) { (responseObjects, status) in
                if status && responseObjects.status && responseObjects.statusCode == 200 {
                    if responseObjects.cartData.count == 0 {
                        self.floatingTabbarView.removeBadgeHub(indexBD: 0, Counts: 0)
                    }
                    else {
                        self.floatingTabbarView.setupBadgeHub(indexBD: 0, Counts: responseObjects.cartData.count)
                    }
                }
                else {
                    self.floatingTabbarView.removeBadgeHub(indexBD: 0, Counts: 0)
                }
            } onFailure: { message in
                self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            }
//            NetworkingRequests.shared.GetNotificationListing { (responseObject, status) in
//                if status || responseObject.status {
//                    self.floatingTabbarView.setupBadgeHub(indexBD: 1, Counts: responseObject.data.notification.count)
//                }
//                else {
//                    self.floatingTabbarView.removeBadgeHub(indexBD: 1, Counts: 0)
//                }
//            } onFailure: { (message) in
//                self.floatingTabbarView.removeBadgeHub(indexBD: 1, Counts: 0)
//            }
        }
    }
    
    @objc func Setupremovebadgecount() {
        self.floatingTabbarView.removeBadgeHub(indexBD: 0, Counts: 0)
        self.floatingTabbarView.removeBadgeHub(indexBD: 1, Counts: 0)
    }
    
    //    MARK:- IBAction Methods
    //    MARK:-
    
    @IBAction func TappedTrackBTN(_ sender: UIButton) {
        let vc = HomeDetailsVC(nibName: "HomeDetailsVC", bundle: nil)
        vc.DetailType = .TrackOrder
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}

//MARK:- Delegate Methods
//MARK:-

extension HomeDashboardVC: FloatingBarViewDelegate {
    func did(selectindex: Int) {
        selectedIndex = selectindex
    }
}


//MARK:- Location methods
//MARK:-

extension HomeDashboardVC: CLLocationManagerDelegate {
    
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
                print(placemark)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
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
