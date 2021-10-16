//
//  CartManageVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 30/07/21.
//

import UIKit
import MapKit
import CoreLocation


class CartManageVC: BaseClassVC {
    
    //    MARK:- IBOutlets
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
            self.ListTBL.register(UINib.init(nibName: "CartItemCell", bundle: nil), forCellReuseIdentifier: "CartItemCell")
            self.ListTBL.register(UINib.init(nibName: "CartConfigureCell", bundle: nil), forCellReuseIdentifier: "CartConfigureCell")
            self.ListTBL.backgroundColor = ModeBG_Color
            self.ListTBL.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: 180))
        }
    }
    
    @IBOutlet weak var CommunityPopup: UIView!
    @IBOutlet weak var popupview: UIView!
    @IBOutlet weak var popupheaderview: UIView!
    @IBOutlet weak var popuptitle: UILabel!
    @IBOutlet weak var DonePopupBTN: UIButton!
    @IBOutlet weak var communityPicker: UIPickerView!
    @IBOutlet weak var popup_height: NSLayoutConstraint!
    
    //    MARK:- Variable Defines
    //    MARK:-
    
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
    
    var locationManager = CLLocationManager()
    var currentLocation: CartLocation?
    var CartItems: MyCartCartData?
    var cartInvoice: CartInvoice!
    var Cartcoupon: CartCoupon = CartCoupon.init(id: 0, code: "", value: 0.0, isApply: false)
    var CartCommunity: UserInfoCommunity!
    var CartPayment: PaymentMode!
    var CommunityArry: [UserInfoCommunity] = []
    
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
        self.setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navheaderView.fillinfo(title: "Manage Cart")
        navigationItem.titleView = self.navheaderView
        self.setupUI()
        if !self.hasLocationPermission() {
            self.navigationController?.view.makeToast("We are unable to get your current location please, try it again!".localized(), duration: 3.0, position: .top, title: "User Location failed".localized(), image: nil)
        }
    }
    
    //    MARK:- User Define
    //    MARK:-
    
    override func setupUI() {
        
        self.view.backgroundColor = ModeBG_Color
        
        if !self.hasLocationPermission() {
            self.navigationController?.view.makeToast("We are unable to get your current location please, try it again!".localized(), duration: 3.0, position: .top, title: "User Location failed".localized(), image: nil)
        }
        
        if SharedUserInfo.shared.IsUserLoggedin()! {
            
            NetworkingRequests.shared.GetAddressListing { (responseObject, status) in
                if status || responseObject.status {
                    self.CommunityArry = responseObject.data.community
                }
                else {
                    self.navigationController?.view.makeToast(responseObject.message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
                }
            } onFailure: { (message) in
                self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            }
            
            let param = MyCartParamDict.init(userId: SharedUserInfo.shared.GetUserInfoFromEnum(enums: .UserID))
            NetworkingRequests.shared.GetCartListingAPI(param: param) { (responseObjects, status) in
                if status && responseObjects.status && responseObjects.statusCode == 200 {
                    self.ListTBL.isHidden = false
                    self.NodataFoundView.isHidden = true
                    self.CartItems = responseObjects.cartData.first
                }
                else {
                    self.ListTBL.isHidden = true
                    self.NodataFoundView.isHidden = false
                }
            } onFailure: { message in
                self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            }
            
            if self.CartItems == nil {
                self.NodataFoundView.backgroundColor = ModeBG_Color
                self.NodataFoundView.fillinfo(title: "No data available!", Notes: "There are no Data available yet!", image: "", enable: false)
                self.NodataFoundView.isHidden = false
                self.ListTBL.isHidden = true
            }
            else {
                self.NodataFoundView.isHidden = true
                self.ListTBL.isHidden = false
                
                self.ListTBL.delegate = self
                self.ListTBL.dataSource = self
                self.ListTBL.reloadData()
            }
            self.reloadcart()
            self.SetupCommunityPopup()
        }
        else {
            self.ListTBL.isHidden = true
            self.NodataFoundView.isHidden = false
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
    
    func GetTBLSection() -> Int? {
        if self.CartItems == nil {
            return 0
        }
        else {
//            return 3
            return 2
        }
    }
    
    func GetRowFromSection(section: Int) -> Int? {
        var rows: Int = 0
        if section == 0 {
            rows = 1
        }
        else {
            rows = 4
        }
//        if section == 0 && (self.CartItems?.ordersitems!.count)! >= 1 {
//            rows = (self.CartItems?.ordersitems!.count)!
//        }
//        else if section == 1 && (self.CartItems?.mealsitems!.count)! >= 1 {
//            rows = (self.CartItems?.mealsitems!.count)!
//        }
//        else if section == 2 {
//            rows = 4
//        }
        return rows
    }
    
    func reloadcart() {
//        if (self.CartItems?.mealsitems!.count)! == 0 && (self.CartItems?.ordersitems!.count)! == 0 {
//            self.NodataFoundView.isHidden = false
//            self.ListTBL.isHidden = true
//        }
//        else {
//            self.NodataFoundView.isHidden = true
//            self.ListTBL.isHidden = false
//        }
        if self.CartItems != nil {
            self.NodataFoundView.isHidden = false
            self.ListTBL.isHidden = true
        }
        else {
            self.NodataFoundView.isHidden = true
            self.ListTBL.isHidden = false
        }
        self.ListTBL.reloadData()
    }
    
    func SetupCommunityPopup() {
        self.CommunityPopup.isHidden = true
        self.CommunityPopup.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.popupview.backgroundColor = ModeBG_Color
        self.popupheaderview.backgroundColor = UIColor.colorWithHexString(hexStr: SecondaryBlackColor)
        self.popuptitle.text = "Community Listing"
        self.communityPicker.delegate = self
        self.communityPicker.dataSource = self
        self.communityPicker.reloadAllComponents()
        self.popuptitle.font = UIFont.boldSystemFont(ofSize: 24)
        self.DonePopupBTN.GetThemeButtonwithBorder()
        self.DonePopupBTN.setTitle("Done", for: .normal)
        self.popup_height.constant = Screen_height / 3
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissCommunitypopup))
        self.CommunityPopup.addGestureRecognizer(tap)
    }
    
    
    //    MARK:- IBAction Methods
    //    MARK:-
    
    
    @objc func dismissCommunitypopup() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        self.CommunityPopup.isHidden = true
    }
    
    @IBAction func TappedDone(_ sender: UIButton) {
        if sender.tag != -1 {
            let data = self.CommunityArry[sender.tag]
            self.CartCommunity = data
            self.CommunityPopup.isHidden = true
            self.reloadcart()
        }
    }
    
}

//MARK:- Communitydelegate methods
//MARK:-

extension CartManageVC: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.CommunityArry.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "Select the Community"
        }
        else {
            let data = self.CommunityArry[row - 1]
            return data.address
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            self.DonePopupBTN.tag = -1
        }
        else {
            self.DonePopupBTN.tag = row - 1
        }
    }
    
}
//MARK:- Location methods
//MARK:-

extension CartManageVC: CLLocationManagerDelegate {
    
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
                
                self.currentLocation?.Address = String.init(format: "%@ %@ %@ %@", (placemark.locality != nil) ? placemark.locality! : "", (placemark.postalCode != nil) ? placemark.postalCode! : "", (placemark.administrativeArea != nil) ? placemark.administrativeArea! : "", (placemark.country != nil) ? placemark.country! : "")
                self.currentLocation?.lat = locValue.latitude
                self.currentLocation?.long = locValue.longitude
                
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

//MARK:- UITableViewDelegate
//MARK:-

extension CartManageVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.GetTBLSection()!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.GetRowFromSection(section: section)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            return self.FOOD_ConfigCellFor(indexPath: indexPath)
            
        case 1:
            return self.MEAL_ConfigCellFor(indexPath: indexPath)
            
        case 2:
            return self.CART_ConfigCellFor(indexPath: indexPath)
            
        default:
            return self.BlankCell(indexPath: indexPath)
        }

    }
    
    func BlankCell(indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell().setupDefaultCell()
    }
    
    func FOOD_ConfigCellFor(indexPath: IndexPath) -> UITableViewCell {
        
        if (self.CartItems?.ordersitems!.count)! >= 1 {
            let cell: CartItemCell = self.ListTBL.dequeueReusableCell(withIdentifier: "CartItemCell") as! CartItemCell
            let food = self.CartItems?.ordersitems![indexPath.row]
            
            cell.setupfoodcell(food: food!)
            if self.cartInvoice == nil {
                self.cartInvoice = CartInvoice.init(item: [Cartitems.init(id: food?.id, title: food?.title, price: food?.price, qty: 1)])
            }
            else {
                let old = self.cartInvoice.items.filter { (obj) in
                    return obj.id == food?.id && obj.title?.uppercased() == food?.title?.uppercased()
                }
                if old.count == 0 {
                    self.cartInvoice.items.append(Cartitems.init(id: food?.id, title: food?.title, price: food?.price, qty: 1))
                }
                else {
                    cell.QTY_Count = (old.first?.qty)!
                    let result:Double = Double(((food!.price)! * Double((old.first?.qty)!)))
                    let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, result.formatprice())
                    cell.PriceLBL.text = priceSTR
                    cell.QTY_LBL.text = String.init(format: "%d", cell.QTY_Count)
                }
            }
            
            let CartIndex = self.cartInvoice.items.enumerated().filter({$0.element.id == food?.id && $0.element.title?.uppercased() == food?.title?.uppercased()}).map({ $0.offset }).first
            
            cell.didMinusActionBlock = {
                cell.QTY_Count -= 1
                self.cartInvoice.items.remove(at: CartIndex!)
                self.cartInvoice.items.append(Cartitems.init(id: food?.id, title: food?.title, price: food?.price, qty: cell.QTY_Count))
                cell.QTY_LBL.text = String.init(format: "%d", cell.QTY_Count)
                let result:Double = Double(((food?.price)! * Double(cell.QTY_Count)))
                let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, result.formatprice())
                cell.PriceLBL.text = priceSTR
                if cell.QTY_Count <= 0 {
                    self.CartItems?.ordersitems?.remove(at: indexPath.row)
                    self.cartInvoice.items.remove(at: CartIndex!)
                }
                self.reloadcart()
            }
            cell.didDeleteActionBlock = {
                self.CartItems?.ordersitems?.remove(at: indexPath.row)
                self.cartInvoice.items.remove(at: CartIndex!)
                self.reloadcart()
            }
            cell.didPlusActionBlock = {
                cell.QTY_Count += 1
                self.cartInvoice.items.remove(at: CartIndex!)
                self.cartInvoice.items.append(Cartitems.init(id: food?.id, title: food?.title, price: food?.price, qty: cell.QTY_Count))
                cell.QTY_LBL.text = String.init(format: "%d", cell.QTY_Count)
                let result:Double = Double(((food?.price)! * Double(cell.QTY_Count)))
                let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, result.formatprice())
                cell.PriceLBL.text = priceSTR
                self.reloadcart()
            }
            return cell
        }
        else {
            return self.BlankCell(indexPath: indexPath)
        }
    
    }
    
//    func MEAL_ConfigCellFor(indexPath: IndexPath) -> UITableViewCell {
//        
//        if (self.CartItems?.mealsitems!.count)! >= 1 {
//            let cell: CartItemCell = self.ListTBL.dequeueReusableCell(withIdentifier: "CartItemCell") as! CartItemCell
//            let meal = self.CartItems?.mealsitems![indexPath.row]
//            cell.setupmealcell(meal: meal!)
//            
//            if self.cartInvoice == nil {
//                self.cartInvoice = CartInvoice.init(item: [Cartitems.init(id: meal?.id, title: meal?.title, price: meal?.price, qty: 1)])
//            }
//            else {
//                let old = self.cartInvoice.items.filter { (obj) in
//                    return obj.id == meal?.id && obj.title?.uppercased() == meal?.title?.uppercased()
//                }
//                if old.count == 0 {
//                    self.cartInvoice.items.append(Cartitems.init(id: meal?.id, title: meal?.title, price: meal?.price, qty: 1))
//                }
//                else {
//                    cell.QTY_Count = (old.first?.qty)!
//                    let result:Double = Double(((meal!.price)! * Double((old.first?.qty)!)))
//                    let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, result.formatprice())
//                    cell.PriceLBL.text = priceSTR
//                    cell.QTY_LBL.text = String.init(format: "%d", cell.QTY_Count)
//                }
//            }
//            
//            let CartIndex = self.cartInvoice.items.enumerated().filter({$0.element.id == meal?.id && $0.element.title?.uppercased() == meal?.title?.uppercased()}).map({ $0.offset }).first
//            
//            cell.didMinusActionBlock = {
//                cell.QTY_Count -= 1
//                self.cartInvoice.items.remove(at: CartIndex!)
//                self.cartInvoice.items.append(Cartitems.init(id: meal?.id, title: meal?.title, price: meal?.price, qty: cell.QTY_Count))
//                cell.QTY_LBL.text = String.init(format: "%d", cell.QTY_Count)
//                let result:Double = Double(((meal?.price)! * Double(cell.QTY_Count)))
//                let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, result.formatprice())
//                cell.PriceLBL.text = priceSTR
//                if cell.QTY_Count <= 0 {
//                    self.CartItems?.mealsitems?.remove(at: indexPath.row)
//                    self.cartInvoice.items.remove(at: CartIndex!)
//                }
//                self.reloadcart()
//            }
//            cell.didDeleteActionBlock = {
//                self.CartItems?.mealsitems?.remove(at: indexPath.row)
//                self.cartInvoice.items.remove(at: CartIndex!)
//                self.reloadcart()
//            }
//            cell.didPlusActionBlock = {
//                cell.QTY_Count += 1
//                self.cartInvoice.items.remove(at: CartIndex!)
//                self.cartInvoice.items.append(Cartitems.init(id: meal?.id, title: meal?.title, price: meal?.price, qty: cell.QTY_Count))
//                cell.QTY_LBL.text = String.init(format: "%d", cell.QTY_Count)
//                let result:Double = Double(((meal?.price)! * Double(cell.QTY_Count)))
//                let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, result.formatprice())
//                cell.PriceLBL.text = priceSTR
//                self.reloadcart()
//            }
//            return cell
//        }
//        else {
//            return self.BlankCell(indexPath: indexPath)
//        }
//        
//    }
    
    func CART_ConfigCellFor(indexPath: IndexPath) -> UITableViewCell {
        // Shipping Cell Defines
        if (self.CartItems?.mealsitems!.count)! >= 1 || (self.CartItems?.ordersitems!.count)! >= 1 {
            if indexPath.row == 0 {
                let cell: CartConfigureCell = self.ListTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
                cell.Setupshoppingcell(indexPath: indexPath)
                
                if self.CartCommunity != nil {
                    cell.SelectedCommunityLBL.text = self.CartCommunity.address
                    cell.TXTVilla.text = self.CartCommunity.line1?.count == 0 ? "" : self.CartCommunity.line1
                    cell.TXTLand.text = self.CartCommunity.line2?.count == 0 ? "" : self.CartCommunity.line2
                }
                
                cell.didDetailsActionBlock = {
                    let vc = HomeDetailsVC(nibName: "HomeDetailsVC", bundle: nil)
                    vc.DetailType = .Address
                    vc.DetailsDelegates = self
                    self.navigationController!.pushViewController(vc, animated: true)
                }
                cell.didDropDownActionBlock = { (isStatus) in
                    self.CommunityPopup.isHidden = isStatus!
                }
                cell.didTextupdateBlock = { (string, type) in
                    if type == .Line1 {
                        self.CartCommunity.line1 = string
                    }
                    else {
                        self.CartCommunity.line2 = string
                    }
                }
                return cell
            }
            // Payment Mode Cell Defines
            else if indexPath.row == 1 {
                let cell: CartConfigureCell = self.ListTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
                cell.SetupPaymentcell(indexPath: indexPath)
                cell.didDetailsActionBlock = {
                    let vc = HomeDetailsVC(nibName: "HomeDetailsVC", bundle: nil)
                    vc.DetailType = .Payment
                    vc.DetailsDelegates = self
                    self.navigationController!.pushViewController(vc, animated: true)
                }
                return cell
            }
//            // Copuon Cell Defines
//            else if indexPath.row == 2 {
//                let cell: CartConfigureCell = self.ListTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
//                cell.SetupCouponcell(indexPath: indexPath)
//                cell.didDetailsActionBlock = {
//                    let vc = HomeDetailsVC(nibName: "HomeDetailsVC", bundle: nil)
//                    vc.DetailType = .Coupon
//                    self.navigationController!.pushViewController(vc, animated: true)
//                }
//                cell.didCouponActionBlock = { (string) in
//                    cell.LBLCoupon.text = ""
//                    cell.LBLCoupon.resignFirstResponder()
//                    self.Cartcoupon.id = 1
//                    self.Cartcoupon.code = string
//                    self.Cartcoupon.value = 10.0
//                    self.Cartcoupon.isApply = true
//                    self.reloadcart()
//                }
//                return cell
//            }
            else if indexPath.row == 2 {
                let cell: CartConfigureCell = self.ListTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
                cell.SetupInvoicecell(invoiceObj: self.cartInvoice, Cartcoupon: self.Cartcoupon, indexPath: indexPath)
                cell.didRemoveCouponActionBlock = {
                    self.Cartcoupon.code = ""
                    self.Cartcoupon.value = 0.0
                    self.Cartcoupon.isApply = false
                    self.reloadcart()
                }
                return cell
            }
            else {
                let cell: CartConfigureCell = self.ListTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
                cell.AgreeSetupView(indexPath: indexPath)
                cell.didCheckoutActionBlock = {
                    
                }
                return cell
            }
        }
        else {
            return self.BlankCell(indexPath: indexPath)
        }
    }
    
}

//MARK:- Details Custom Delegates
//MARK:-

extension CartManageVC: DetailsShowingDelegates {
    
    func didselectedAddress(data: UserInfoAddres?) {
        self.reloadcart()
    }
    
    func didselectedPaymentmode() {
        
    }
    
    func didselectedCoupon() {
        
    }
    
}
