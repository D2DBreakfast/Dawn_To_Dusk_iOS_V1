//
//  HomeDetailsVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 30/07/21.
//

import UIKit
import Lottie


enum ShowDetailType {
    case None, Food, Meals, Banner, Notification, History, Address, Payment, Coupon, Supports, Settings, HistoryDetails, TrackOrder
}

protocol DetailsShowingDelegates: AnyObject {
    func didselectedAddress(data: UserInfoAddres?)
    func didselectedPaymentmode()
    func didselectedCoupon()
}

class HomeDetailsVC: BaseClassVC {
    
    //    MARK:- IBOutlets
    //    MARK:-
    
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var DetailTBL: UITableView!
    
    @IBOutlet weak var NodataFoundView: NodataView! {
        didSet {
            self.NodataFoundView.fillinfo(title: "No data available!", Notes: "There are no Data available yet!", image: "", enable: false)
            self.NodataFoundView.backgroundColor = ModeBG_Color
            self.NodataFoundView.didActionBlock = {
                self.setupUI()
            }
        }
    }
    
    //    MARK:- Variable Definesua
    //    MARK:-
    
    var FoodDetails: MenuItemsData!
    var MealDetails: MealsModels!
    var BannerDetails: BannerModels!
    
    var notificationDetails: NotificationModels!
    var AddressArry: [UserInfoAddres] = []
    var paymentarry : [PaymentModePayment] = []
    
    var DetailsDelegates: DetailsShowingDelegates!
    
    let optionArry: [UserProfilesOption] = [
        UserProfilesOption.init(title: "FAQ", image: "FAQIC"),
        UserProfilesOption.init(title: "Privacy Policy", image: "PrivacyIC"),
        UserProfilesOption.init(title: "Terms & Conditions", image: "TermsIC"),
        UserProfilesOption.init(title: "Contact", image: "SupportIC"),
    ]
    
    var DetailType: ShowDetailType!
    var DateSelected: Bool = false
    
    lazy var carouselView : iCarousel = {
        let header = iCarousel.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: 200))
        header.backgroundColor = ModeBG_Color
        header.type = .coverFlow2
        header.bounceDistance = 15
        header.isPagingEnabled = true
        header.delegate = self
        header.dataSource = self
        return header
    }()
    
    lazy var SectionHeader: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: 40))
        view.backgroundColor = ModeBG_Color
        view.addSubview(self.Sectiontitle)
        return view
    }()
    
    lazy var Sectiontitle: UILabel = {
        let lbl = UILabel.init(frame: CGRect.init(x: 20, y: 10, width: Screen_width - 20, height: 30))
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textColor = UIColor.label
        return lbl
    }()
    
    lazy var setupBottomOption : DetailsBottomOptionView = {
        let bottom = DetailsBottomOptionView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: 150))
        bottom.setupBottomOption(DetailType: self.DetailType, FoodDetails: self.FoodDetails, MealDetails: self.MealDetails)
        bottom.didcallDateAction = {
            self.CalendarSelection()
        }
        bottom.didcallAgreeAction = {
            if bottom.CheckBoxBTN.isSelected {
                bottom.CheckBoxBTN.isSelected = false
                bottom.CheckBoxBTN.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
            }
            else {
                bottom.CheckBoxBTN.isSelected = true
                bottom.CheckBoxBTN.setImage(UIImage.init(systemName: "checkmark.circle.fill"), for: .normal)
            }
            if self.DateSelected && self.setupBottomOption.CheckBoxBTN.isSelected {
                bottom.AddCartBTN.isEnabled = true
                bottom.AddCartBTN.alpha = 1.0
            }
            else {
                bottom.AddCartBTN.isEnabled = false
                bottom.AddCartBTN.alpha = 0.5
            }
        }
        bottom.didcallAddCartAction = {
            if SharedUserInfo.shared.IsUserLoggedin()! {
                NotificationCenter.default.post(name: Notification.Name(BdgeNotification), object: nil)
//                self.TappedCartBTN(self.AddCartBTN)
                let param = Place_ToCart_OrderParamDict.init(itemMainCategoryName: self.FoodDetails.itemMainCategoryName, itemSubCategoryName: self.FoodDetails.itemSubCategoryName, itemFoodType: self.FoodDetails.itemFoodType, itemName: self.FoodDetails.itemName, itemId: self.FoodDetails.itemId, itemQuantity: "1", itemPrice: self.FoodDetails.itemPrice, userId: SharedUserInfo.shared.GetUserInfoFromEnum(enums: .UserID))
                print(param)
                NetworkingRequests.shared.Call_AddtoCartAPI(param: param) { (responseObject, status) in
                    print(responseObject)
                    if status && responseObject.status && responseObject.statusCode == 200 {
                        self.navigationController?.view.makeToast(responseObject.message.localized(), duration: 3.0, position: .top, title: "Items Added into Cart.".localized(), image: nil)
                        NotificationCenter.default.post(name: Notification.Name(BdgeNotification), object: nil)
                    }
                    self.navigationController?.popViewController(animated: true)
                } onFailure: { message in
                    self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "Something went Wrong!".localized(), image: nil)
                }
            }
            else {
                let vc = LoginVC(nibName: "LoginVC", bundle: nil)
                vc.LoginSelected = 100
                self.navigationController!.pushViewController(vc, animated: true)
            }
        }
        return bottom
    }()
    
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    
//    var CartItems: CartListModelClass? = DummCartdata()
//    var HistoryArry: [OrderHistoryModelData]? = DummyOrderHistory()
    
    var CartItems: OrderHistoryData?
    var HistoryArry: [OrderHistoryData]? = []
    
    //    MARK:- View Cycle
    //    MARK:-
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toogleTabbar(hide: true)
        self.setupUI()
        self.DetailTBL.layoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //    MARK:- User Define
    //    MARK:-
    
    override func setupUI() {
        
        NetworkingRequests.shared.GetbannerListing { (responseObject, status) in
            if status || responseObject.status {
                self.BannerDetails = responseObject.data.banner.first
            }
            else {
                self.navigationController?.view.makeToast(responseObject.message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            }
        } onFailure: { (message) in
            self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
        }
        
        self.DetailTBL.register(UINib.init(nibName: "HomeDetailCell", bundle: nil), forCellReuseIdentifier: "HomeDetailCell")
        self.DetailTBL.register(UINib.init(nibName: "HomeBannerCell", bundle: nil), forCellReuseIdentifier: "HomeBannerCell")
        self.DetailTBL.register(UINib.init(nibName: "HomeFoodListCell", bundle: nil), forCellReuseIdentifier: "HomeFoodListCell")
        self.DetailTBL.register(UINib.init(nibName: "AddressCell", bundle: nil), forCellReuseIdentifier: "AddressCell")
        self.DetailTBL.register(UINib.init(nibName: "UserOptionCell", bundle: nil), forCellReuseIdentifier: "UserOptionCell")
        self.DetailTBL.register(UINib.init(nibName: "CartItemCell", bundle: nil), forCellReuseIdentifier: "CartItemCell")
        self.DetailTBL.register(UINib.init(nibName: "CartConfigureCell", bundle: nil), forCellReuseIdentifier: "CartConfigureCell")
        self.DetailTBL.register(UINib.init(nibName: "RunningOrderTrackCell", bundle: nil), forCellReuseIdentifier: "RunningOrderTrackCell")
        self.DetailTBL.register(UINib.init(nibName: "RunningOrderCell", bundle: nil), forCellReuseIdentifier: "RunningOrderCell")
        self.DetailTBL.register(UINib.init(nibName: "PaymentModeCell", bundle: nil), forCellReuseIdentifier: "PaymentModeCell")
        self.DetailTBL.allowsSelection = true
        
        self.DetailTBL.rowHeight = UITableView.automaticDimension
        self.DetailTBL.estimatedRowHeight = UITableView.automaticDimension
        
        self.DetailTBL.delegate = self
        self.DetailTBL.dataSource = self
        
        switch self.DetailType {
        case .None:
            self.DetailTBL.backgroundColor = ModeBG_Color
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = ModeBG_Color
            self.title = "None"
            self.SetupNavBarforback()
            self.NodataFoundView.isHidden = false
            self.DetailTBL.isHidden = true
            break
            
        case .Food:
            self.DetailTBL.backgroundColor = ModeBG_Color
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = ModeBG_Color
            if self.FoodDetails.itemImageUrl.count != 0 {
                self.DetailTBL.tableHeaderView = self.carouselView
                self.carouselView.reloadData()
            }
//            if self.getcarouselCell() > 0 {
//                self.DetailTBL.tableHeaderView = self.carouselView
//                self.carouselView.reloadData()
//            }
            self.title = self.FoodDetails.itemName
            self.SetupNavBarforback()
//            self.DetailTBL.tableFooterView = self.setupBottomOption
            self.StackView.addArrangedSubview(self.setupBottomOption)
            break
            
        case .Meals:
            self.DetailTBL.backgroundColor = ModeBG_Color
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = ModeBG_Color
//            if self.getcarouselCell() > 0 {
//                self.DetailTBL.tableHeaderView = self.carouselView
//                self.carouselView.reloadData()
//            }
            self.title = self.MealDetails.title
            self.SetupNavBarforback()
//            self.DetailTBL.tableFooterView = self.setupBottomOption
            break
            
        case .Banner:
            self.DetailTBL.backgroundColor = ModeBG_Color
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = ModeBG_Color
            self.title = self.BannerDetails.bannerTitle
            self.SetupNavBarforback()
            break
            
        case .Notification:
            self.DetailTBL.backgroundColor = ModeBG_Color
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = ModeBG_Color
            self.title = self.notificationDetails.title
            if self.getcarouselCell() > 0 {
                self.DetailTBL.tableHeaderView = self.carouselView
                self.carouselView.reloadData()
            }
            self.SetupNavBarforback()
            self.DetailTBL.reloadData()
            break
            
        case .History:
            self.DetailTBL.backgroundColor = ModeBG_Color
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = ModeBG_Color
            self.title = "Order History"
            self.SetupNavBarforback()
            self.NodataFoundView.isHidden = true
            self.DetailTBL.isHidden = false
            
            NetworkingRequests.shared.GetCartHistoryListing { (responseObjects, status) in
                if status || responseObjects.status {
                    self.HistoryArry = responseObjects.data
                }
                else {
                    self.navigationController?.view.makeToast(responseObjects.message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
                }
            } onFailure: { (message) in
                self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            }
            break
            
        case .Address:
            self.DetailTBL.backgroundColor = TBLBackgroundCOlor
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = TBLBackgroundCOlor
            
            self.title = "Addresses"
            self.SetupNavBarforback()
            self.NodataFoundView.isHidden = true
            self.DetailTBL.isHidden = false
            
            NetworkingRequests.shared.GetAddressListing { (responseObject, status) in
                if status || responseObject.status {
                    self.AddressArry = responseObject.data.address
                }
                else {
                    self.navigationController?.view.makeToast(responseObject.message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
                }
            } onFailure: { (message) in
                self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            }
            
            let cartBTN = UIButton().NavAddButton()
            cartBTN.addTarget(self, action: #selector(TappedAddBTN(_:)), for: .touchUpInside)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: cartBTN)
            break
            
        case .Payment:
            self.DetailTBL.backgroundColor = TBLBackgroundCOlor
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = TBLBackgroundCOlor
            
            self.title = "Payment Mode"
            self.SetupNavBarforback()
            self.NodataFoundView.isHidden = true
            self.DetailTBL.isHidden = false
            
            NetworkingRequests.shared.GetPaymentmodeListing { (responseObject, status) in
                if status || responseObject.status {
                    self.paymentarry = responseObject.data.payment
                }
                else {
                    self.navigationController?.view.makeToast(responseObject.message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
                }
            } onFailure: { (message) in
                self.navigationController?.view.makeToast(message.localized(), duration: 3.0, position: .top, title: "The server failed to get data!".localized(), image: nil)
            }
            
//            let payBTN = UIButton().NavAddButton()
//            payBTN.addTarget(self, action: #selector(TappedAddPaymentBTN(_:)), for: .touchUpInside)
//            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: payBTN)
            break
            
        case .Coupon:
            self.DetailTBL.backgroundColor = ModeBG_Color
            self.DetailTBL.separatorStyle = .singleLine
            self.view.backgroundColor = ModeBG_Color
            self.title = "Coupons"
            self.SetupNavBarforback()
            self.NodataFoundView.isHidden = true
            self.DetailTBL.isHidden = false
            break
            
        case .Supports:
            self.DetailTBL.backgroundColor = TBLBackgroundCOlor
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = TBLBackgroundCOlor
            
            self.title = "Help & Supports"
            self.SetupNavBarforback()
            self.NodataFoundView.isHidden = true
            self.DetailTBL.isHidden = false
            break
            
        case .Settings:
            self.DetailTBL.backgroundColor = ModeBG_Color
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = ModeBG_Color
            
            self.title = "App Settings"
            self.SetupNavBarforback()
            self.NodataFoundView.isHidden = false
            self.DetailTBL.isHidden = true
            break
            
        case .HistoryDetails:
            self.DetailTBL.backgroundColor = ModeBG_Color
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = ModeBG_Color
            self.title = "History Details"
            self.SetupNavBarforback()
            self.NodataFoundView.isHidden = true
            self.DetailTBL.isHidden = false
            break
            
        case .TrackOrder:
            self.DetailTBL.backgroundColor = TBLBackgroundCOlor
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = TBLBackgroundCOlor
            self.title = "Order Tracks"
            self.SetupNavBarforback()
            self.NodataFoundView.isHidden = true
            self.DetailTBL.isHidden = false
            break
            
        default:
            self.DetailTBL.backgroundColor = ModeBG_Color
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = ModeBG_Color
            self.SetupNavBarforback()
            self.NodataFoundView.isHidden = false
            self.DetailTBL.isHidden = true
            break
        }
        self.DetailTBL.reloadData()
    }
    
    //    MARK:- IBAction Methods
    //    MARK:-
    
    @IBAction func Tappedbuttons(_ sender: UIButton) {
        
    }
    
    @IBAction func TappedAddBTN(_ sender: UIButton) {
        let add = AddressAddVC.init(nibName: "AddressAddVC", bundle: nil)
        self.navigationController?.pushViewController(add, animated: true)
    }
    
    @IBAction func TappedAddPaymentBTN(_ sender: UIButton) {
        let add = AddPaymentVC.init(nibName: "AddPaymentVC", bundle: nil)
        self.navigationController?.pushViewController(add, animated: true)
    }
    
}

//MARK:- iCarousel Delegates & DataSources
//MARK:-

extension HomeDetailsVC: iCarouselDataSource, iCarouselDelegate {
    
    func getcarouselCell() -> Int {
        switch self.DetailType {
        case .Food:
            return 1 //(self.FoodDetails.gallery?.count)!
            
        case .Meals:
            return (self.MealDetails.gallery?.count)!
        
        case .Notification:
            return self.notificationDetails.gallery!.count
            
        default:
            return 0
        }
    }
    
    func getCarouselImageURL(index: Int) -> String {
        var imageURL: String = ""
        switch self.DetailType {
        case .Food:
            imageURL = self.FoodDetails.itemImageUrl//self.FoodDetails.gallery![index]
            break
            
        case .Meals:
            imageURL = self.MealDetails.gallery![index]
            break
            
        case .Notification:
            imageURL = self.notificationDetails.gallery![index]
            break
            
        default:
            imageURL = ""
            break
        }
        return imageURL
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.getcarouselCell()
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        
        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
        } else {
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.carouselView.frame.height, height: self.carouselView.frame.height))
//            let imageURL: String = self.getCarouselImageURL(index: index)
//            itemView.downloadedFrom(url: URL.init(string: imageURL)!)
            itemView.image = UIImage.init(named: "bannarimage")
            itemView.contentMode = .center
        }
        
        return itemView
    }
    
    private func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
}

//MARK:- TableView Configuration process function
//MARK:-

extension HomeDetailsVC {
    
    //    TODO:- Setup Table Section Index
    func getTBLSections() -> Int? {
        switch self.DetailType {
        case .None:
            return 0
            
        case .Food:
            return 1
            
        case .Meals:
            return 2
            
        case .Banner:
            return 1
            
        case .Notification:
            return 1
            
        case .History:
            return 2
            
        case .Address:
            return 1
            
        case .Payment:
            return 1
            
        case .Coupon:
            return 1
            
        case .Supports:
            return 1
            
        case .Settings:
            return 1
            
        case .HistoryDetails:
            return 3
            
        case .TrackOrder:
            return 2
            
        default:
            return 0
        }
    }
    
    //    TODO:- Setup Table Row index base on Section
    func getTBLRows(section: Int = 0) -> Int? {
        switch self.DetailType {
        case .None:
            return 0
            
        case .Food:
            return 1
            
        case .Meals:
            return section == 0 ? 4 : (self.MealDetails.items?.count)!
            
        case .Banner:
            return 1
            
        case .Notification:
            return 1
            
        case .Address:
            return self.AddressArry.count
            
        case .Payment:
            return self.paymentarry.count
            
        case .Coupon:
            return 5
            
        case .Supports:
            return self.optionArry.count
            
        case .Settings:
            return 1
            
        case .History:
            return section == 0 ? self.HistoryArry?.count : self.HistoryArry?.count
            
        case .HistoryDetails:
            return self.GetRowFromSection(section: section)
            
        case .TrackOrder:
            return 1
            
        default:
            return 0
        }
    }
    
    //    TODO:- Setup Table HistoryDetails row Index
    func GetRowFromSection(section: Int) -> Int? {
        var rows: Int = 0
        if self.CartItems == nil {
            rows = 0
        }
        else if section == 0 && (self.CartItems?.ordersitems!.count)! >= 1 {
            rows = (self.CartItems?.ordersitems!.count)!
        }
        else if section == 1 && (self.CartItems?.mealsitems!.count)! >= 1 {
            rows = (self.CartItems?.mealsitems!.count)!
        }
        else if section == 2 {
            rows = 6
        }
        return rows
    }
    
}

//MARK:- UITableViewDelegate & Datasources
//MARK:-

extension HomeDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.getTBLSections()!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getTBLRows(section: section)!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch self.DetailType {
        case .Meals:
            return section == 1 ? 40 : 0
        case .History:
            return 40
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch self.DetailType {
        case .Meals:
            if section == 1 {
                self.Sectiontitle.text = "Daily variants"
                return self.SectionHeader
            }
            else {
                return nil
            }
            
        case .History:
            self.Sectiontitle.text = section == 0 ? "Running Orders" : "Completed Orders"
            return self.SectionHeader
            
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tap = AppGesture(target: self, action: #selector(self.didSelectRowAt(sender:)))
        tap.indexPath = indexPath
        
        switch self.DetailType {
        case .Food:
            let cell = self.FoodConfigCell(indexPath: indexPath)
            return cell
            
        case .Meals:
            return self.MealsConfigCell(indexPath: indexPath)
            
        case .Banner:
            return self.BannerConfigCell(indexPath: indexPath)
            
        case .Notification:
            return self.NotificationConfigCell(indexPath: indexPath)
            
        case .Address:
            return self.AddressConfigCell(indexPath: indexPath)
            
        case .Payment:
            return self.PaymentConfigCell(indexPath: indexPath)
            
        case .Coupon:
            return self.CouponConfigCell(indexPath: indexPath)
            
        case .Supports:
            let cell = self.SupportsConfigCell(indexPath: indexPath)
            cell.addGestureRecognizer(tap)
            return cell
            
        case .History:
            let cell = self.HistoryConfigCell(indexPath: indexPath)
            cell.addGestureRecognizer(tap)
            return cell
            
        case .HistoryDetails:
            switch indexPath.section {
            case 0:
                return self.FOOD_ConfigCellFor(indexPath: indexPath)
                
            case 1:
                return self.MEAL_ConfigCellFor(indexPath: indexPath)
                
            case 2:
                return self.CART_ConfigCellFor(indexPath: indexPath)
                
            default:
                return UITableViewCell().setupDefaultCell()
            }
            
        case .TrackOrder:
            return self.SetupTrackOrder(indexPath: indexPath)
            
        default:
            return UITableViewCell().setupDefaultCell()
        }
    }
    
    @objc func didSelectRowAt(sender : AppGesture) {
        self.tableView(self.DetailTBL, didSelectRowAt: sender.indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch self.DetailType {
        case .None:
            break
            
        case .Food:
            break
            
        case .Meals:
            break
            
        case .Banner:
            break
            
        case .Notification:
            break
            
        case .History:
            if indexPath.section == 0 {
                let vc = HomeDetailsVC(nibName: "HomeDetailsVC", bundle: nil)
                vc.DetailType = .TrackOrder
                self.navigationController!.pushViewController(vc, animated: true)
            }
            else {
                let details = HomeDetailsVC.init(nibName: "HomeDetailsVC", bundle: nil)
                details.DetailType = .HistoryDetails
                details.CartItems = self.HistoryArry?[indexPath.row]
                self.navigationController?.pushViewController(details, animated: true)
            }
            break
            
        case .Address:
            if self.DetailsDelegates != nil {
                self.DetailsDelegates.didselectedAddress(data: self.AddressArry[indexPath.row])
                self.navigationController?.popViewController(animated: true)
            }
            break
            
        case .Payment:
            if self.DetailsDelegates != nil {
                self.DetailsDelegates.didselectedPaymentmode()
                self.navigationController?.popViewController(animated: true)
            }
            break
            
        case .Coupon:
            if self.DetailsDelegates != nil {
                self.DetailsDelegates.didselectedCoupon()
                self.navigationController?.popViewController(animated: true)
            }
            break
            
        case .Supports:
            if indexPath.row == 3 {
                let vc = EditFormVC.init(nibName: "EditFormVC", bundle: nil)
                vc.FormType = .ContactHelp
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                guard let url = URL(string: "https://stackoverflow.com") else { return }
                UIApplication.shared.open(url)
            }
            break
            
        case .Settings:
            break
            
        case .HistoryDetails:
            break
            
        case .TrackOrder:
            if indexPath.section == 0 {
                
            }
            else {
                let details = HomeDetailsVC.init(nibName: "HomeDetailsVC", bundle: nil)
                details.DetailType = .HistoryDetails
                self.navigationController?.pushViewController(details, animated: true)
            }
            break
            
        default:
            break
        }
    }
    
}

//MARK:- UITableView Config Cells
//MARK:-

extension HomeDetailsVC {
    
    //    TODO:- Food Config Cells
    func FoodConfigCell(indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeDetailCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "HomeDetailCell") as! HomeDetailCell
        cell.setupfoodcell(food: self.FoodDetails, indexPath: indexPath)
        return cell
    }
    
    //    TODO:- Meal Config Cells
    func MealsConfigCell(indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: HomeDetailCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "HomeDetailCell") as! HomeDetailCell
            cell.setupmealcell(meal: self.MealDetails, indexPath: indexPath)
            return cell
        }
        else {
            let cell: HomeFoodListCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "HomeFoodListCell") as! HomeFoodListCell
            cell.setupmealplan_foodcell(meals: self.MealDetails, indexPath: indexPath)
            return cell
        }
    }
    
    //    TODO:- banner Config Cells
    func BannerConfigCell(indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeDetailCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "HomeDetailCell") as! HomeDetailCell
        cell.setupbannercell(banner: self.BannerDetails, indexPath: indexPath)
        return cell
    }
    
    //    TODO:- Notification Config Cells
    func NotificationConfigCell(indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeDetailCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "HomeDetailCell") as! HomeDetailCell
        cell.setupnotificationcell(data: self.notificationDetails, indexPath: indexPath)
        return cell
    }
    
    //    TODO:- Address Config Cells
    func AddressConfigCell(indexPath: IndexPath) -> UITableViewCell {
        let cell: AddressCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "AddressCell") as! AddressCell
        let data = self.AddressArry[indexPath.row]
        cell.SetupCell(indexPath: indexPath, data: data)
        cell.didSelectAddressActionBlock = { (index) in
            if self.DetailsDelegates != nil {
                self.DetailsDelegates.didselectedAddress(data: self.AddressArry[index!])
                self.navigationController?.popViewController(animated: true)
            }
        }
        return cell
    }
    
    //    TODO:- Payment Config Cells
    func PaymentConfigCell(indexPath: IndexPath) -> UITableViewCell {
        let data = self.paymentarry[indexPath.row]
        if data.paymentType.uppercased() == "Card".uppercased() || data.paymentType.uppercased() == "NetBank".uppercased()  {
            let cell: PaymentModeCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "PaymentModeCell") as! PaymentModeCell
            cell.SetupPaymentmode(indexPath: indexPath, obj: data)
            return cell
        }
        else {
            let cell: AddressCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "AddressCell") as! AddressCell
            cell.setupPaymentCell(indexPath: indexPath, obj: data)
            cell.didSelectAddressActionBlock = { (index) in
                if self.DetailsDelegates != nil {
                    self.DetailsDelegates.didselectedPaymentmode()
                    self.navigationController?.popViewController(animated: true)
                }
            }
            return cell
        }
    }
    
    //    TODO:- Coupon Config Cells
    func CouponConfigCell(indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeDetailCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "HomeDetailCell") as! HomeDetailCell
        cell.setupcouponcell(indexPath: indexPath)
        cell.didTappedApplyActionBlock = {
            self.DetailsDelegates.didselectedCoupon()
            self.navigationController?.popViewController(animated: true)
        }
        return cell
    }
    
    //    TODO:- Supports Config Cells
    func SupportsConfigCell(indexPath: IndexPath) -> UITableViewCell {
        let cell: UserOptionCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "UserOptionCell") as! UserOptionCell
        let option = self.optionArry[indexPath.row]
        cell.SetupOptionCell(image: option.image!, title: option.title!)
        return cell
    }
    
    //    TODO:- History Config Cells
    func HistoryConfigCell(indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: RunningOrderCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "RunningOrderCell") as! RunningOrderCell
            cell.setuptrackdata()
            cell.didTappedActionBlock = {
                let vc = HomeDetailsVC(nibName: "HomeDetailsVC", bundle: nil)
                vc.DetailType = .TrackOrder
                self.navigationController!.pushViewController(vc, animated: true)
            }
            return cell
        }
        else {
            let cell: HomeFoodListCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "HomeFoodListCell") as! HomeFoodListCell
            cell.setupHistorycell(history: self.HistoryArry![indexPath.row], indexPath: indexPath)
            return cell
        }
    }
    
    //    TODO:- Cart History Details Cells
    func FOOD_ConfigCellFor(indexPath: IndexPath) -> UITableViewCell {
        
        if (self.CartItems?.ordersitems!.count)! >= 1 {
            let cell: CartItemCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "CartItemCell") as! CartItemCell
//            cell.setupfoodcell(food: self.CartItems!)
            cell.DeleteBTN.isHidden = true
            return cell
        }
        else {
            return self.DetailTBL.SetupBlankCell(indexPath: indexPath)
        }
        
    }
    
    func MEAL_ConfigCellFor(indexPath: IndexPath) -> UITableViewCell {
        if (self.CartItems?.mealsitems!.count)! >= 1 {
            let cell: CartItemCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "CartItemCell") as! CartItemCell
            let meal = self.CartItems?.mealsitems![indexPath.row]
            cell.setupmealcell(meal: meal!)
            cell.DeleteBTN.isHidden = true
            return cell
        }
        else {
            return self.DetailTBL.SetupBlankCell(indexPath: indexPath)
        }
    }
    
    func CART_ConfigCellFor(indexPath: IndexPath) -> UITableViewCell {
        
        if (self.CartItems?.mealsitems!.count)! >= 1 || (self.CartItems?.ordersitems!.count)! >= 1 {
            // Delivery Date Cell Defines
            if indexPath.row == 0 {
                let cell: CartConfigureCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
                cell.DeliverySetup(indexPath: indexPath)
                
                return cell
            }
            // Shipping Cell Defines
            else if indexPath.row == 1 {
                let cell: CartConfigureCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
                cell.Setupshoppingcell(indexPath: indexPath)
                cell.HeaderView.isHidden = false
                cell.DetailBTN.isHidden = true
                return cell
            }
            // Payment Mode Cell Defines
            else if indexPath.row == 2 {
                let cell: CartConfigureCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
                cell.SetupPaymentcell(indexPath: indexPath)
                cell.HeaderView.isHidden = false
                cell.DetailBTN.isHidden = true
                return cell
            }
            // Invoice Cell Defines
            else if indexPath.row == 3 {
                let cell: CartConfigureCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
                cell.SetupInvoicecell(invoiceObj: CartInvoice.init(item: [Cartitems.init(id: "0", title: "fadfsadf", price: 20, qty: 5)]), Cartcoupon: CartCoupon.init(id: 2, code: "ffsfsa", value: 20, isApply: false), indexPath: indexPath)
                cell.HeaderView.isHidden = false
                cell.DetailBTN.isHidden = true
                return cell
            }
            else if indexPath.row == 4 {
                let cell: UserOptionCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "UserOptionCell") as! UserOptionCell
                cell.setupDownloadInvoice()
                cell.didTappedAction1Block = {
                    
                }
                cell.didTappedAction2Block = {
                    
                }
                return cell
            }
            // Apply OR Show Review Cell Defines
            else {
                let cell: CartConfigureCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
                cell.ReviewSetupView(indexPath: indexPath)
                cell.didRatingActionBlock = { (rating, comments) in
                    
                }
                return cell
            }
        }
        else {
            return self.DetailTBL.SetupBlankCell(indexPath: indexPath)
        }
    }
    
//    TODO:- Running Order Track
    func SetupTrackOrder(indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: HomeBannerCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "HomeBannerCell") as! HomeBannerCell
            cell.setupBannercell(banner: self.BannerDetails)
            cell.backgroundColor = TBLBackgroundCOlor
            cell.contentView.backgroundColor = TBLBackgroundCOlor
            return cell
        }
        else {
            let cell: RunningOrderTrackCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "RunningOrderTrackCell") as! RunningOrderTrackCell
            cell.SelectedPoints()
            let tap = AppGesture(target: self, action: #selector(self.didSelectRowAt(sender:)))
            tap.indexPath = indexPath
            cell.addGestureRecognizer(tap)
            return cell
        }
    }
    
}

//MARK:- WWCalendar Delegates & Setup Functions
//MARK:-

extension HomeDetailsVC: WWCalendarTimeSelectorProtocol {
    
    func CalendarSelection() {
        let calendarVC = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        calendarVC.delegate = self
        calendarVC.optionCurrentDate = singleDate
        calendarVC.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        calendarVC.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
//        if self.DetailType == .Food {
            calendarVC.optionStyles.showDateMonth(true)
            calendarVC.optionStyles.showMonth(false)
            calendarVC.optionStyles.showYear(false)
            calendarVC.optionStyles.showTime(false)
//        }
//        else if self.DetailType == .Meals {
//            calendarVC.optionSelectionType = WWCalendarTimeSelectorSelection.range
//            calendarVC.optionCurrentDates = Set(multipleDates)
//        }
        present(calendarVC, animated: true, completion: nil)
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        self.singleDate = date
        self.DateSelected = true
        if self.DateSelected && self.setupBottomOption.CheckBoxBTN.isSelected {
            self.setupBottomOption.AddCartBTN.isEnabled = true
            self.setupBottomOption.AddCartBTN.alpha = 1.0
        }
        else {
            self.setupBottomOption.AddCartBTN.isEnabled = false
            self.setupBottomOption.AddCartBTN.alpha = 0.5
        }
        self.setupBottomOption.DateLBL.text = String.init(format: "%@", self.singleDate.convertDateFormater())
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, dates: [Date]) {
        print("Selected Multiple Dates \n\(dates)\n---")
        multipleDates = dates
        if self.singleDate != nil && self.setupBottomOption.CheckBoxBTN.isSelected {
            self.setupBottomOption.AddCartBTN.isEnabled = true
            self.setupBottomOption.AddCartBTN.alpha = 1.0
        }
        else {
            self.setupBottomOption.AddCartBTN.isEnabled = false
            self.setupBottomOption.AddCartBTN.alpha = 0.5
        }
        self.setupBottomOption.DateLBL.text = dates.first?.convertDaterang(dt1: self.multipleDates.first!, dt2: self.multipleDates.last!)
    }
    
    func WWCalendarTimeSelectorShouldSelectDate(_ selector: WWCalendarTimeSelector, date: Date) -> Bool {
        if date > Date() || date.convertDateFormater() == Date().convertDateFormater() {
            return true
        }
        return false
    }
    
}
