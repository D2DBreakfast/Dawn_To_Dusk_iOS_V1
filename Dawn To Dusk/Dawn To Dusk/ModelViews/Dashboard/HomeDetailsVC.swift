//
//  HomeDetailsVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 30/07/21.
//

import UIKit


enum ShowDetailType {
    case None, Food, Meals, Banner, Notification, History, Address, Payment, Coupon, Supports, Settings, HistoryDetails, TrackOrder
}

protocol DetailsShowingDelegates: AnyObject {
    func didselectedAddress(data: CommunityModelClass?)
    func didselectedPaymentmode()
    func didselectedCoupon()
}

class HomeDetailsVC: BaseClassVC {
    
    //    MARK:- IBOutlets
    //    MARK:-
    
    @IBOutlet weak var DetailTBL: UITableView!
    
    @IBOutlet weak var BottomStack: UIStackView!
    @IBOutlet weak var DateView: UIView!
    @IBOutlet weak var DateSelection: UIView!
    @IBOutlet weak var DateLBL: UILabel!
    @IBOutlet weak var DateIMG: UIImageView!
    @IBOutlet weak var DateBTN: UIButton!
    
    @IBOutlet weak var Price_cart_View: UIView!
    @IBOutlet weak var CartStack: UIStackView!
    @IBOutlet weak var PriceLBL: UILabel!
    @IBOutlet weak var AddCartBTN: UIButton!
    
    @IBOutlet weak var NodataFoundView: NodataView! {
        didSet {
            self.NodataFoundView.fillinfo(title: "No data available!", Notes: "There are no Data available yet!", image: "", enable: false)
            self.NodataFoundView.backgroundColor = ModeBG_Color
            self.NodataFoundView.didActionBlock = {
                self.setupUI()
            }
        }
    }
    
    //    MARK:- Variable Defines
    //    MARK:-
    
    var FoodDetails: FoodModels!
    var MealDetails: MealsModels!
    var BannerDetails: BannerModelClass! = BannerModelClass.init(id: 0, bannerName: "Package 0", bannerImage: "https://source.unsplash.com/random/200x200", bannerdes: randomString(), bannerTitle: "Package 0")
    
    var notificationDetails: NotificationModelClass!
    var AddressArry: [CommunityModelClass] = DummyCommunitydata()!
    
    var DetailsDelegates: DetailsShowingDelegates!
    
    let optionArry: [UserProfilesOption] = [
        UserProfilesOption.init(title: "FAQ", image: "FAQIC"),
        UserProfilesOption.init(title: "Privacy Policy", image: "PrivacyIC"),
        UserProfilesOption.init(title: "Terms & Conditions", image: "TermsIC"),
        UserProfilesOption.init(title: "Contact", image: "SupportIC"),
    ]
    
    var DetailType: ShowDetailType!
    
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
    
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    
    var CartItems: CartListModelClass? = DummCartdata()
    var HistoryArry: [OrderHistoryModelData]? = DummyOrderHistory()
    
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
        
        self.DetailTBL.register(UINib.init(nibName: "HomeDetailCell", bundle: nil), forCellReuseIdentifier: "HomeDetailCell")
        self.DetailTBL.register(UINib.init(nibName: "HomeBannerCell", bundle: nil), forCellReuseIdentifier: "HomeBannerCell")
        self.DetailTBL.register(UINib.init(nibName: "HomeFoodListCell", bundle: nil), forCellReuseIdentifier: "HomeFoodListCell")
        self.DetailTBL.register(UINib.init(nibName: "AddressCell", bundle: nil), forCellReuseIdentifier: "AddressCell")
        self.DetailTBL.register(UINib.init(nibName: "UserOptionCell", bundle: nil), forCellReuseIdentifier: "UserOptionCell")
        self.DetailTBL.register(UINib.init(nibName: "CartItemCell", bundle: nil), forCellReuseIdentifier: "CartItemCell")
        self.DetailTBL.register(UINib.init(nibName: "CartConfigureCell", bundle: nil), forCellReuseIdentifier: "CartConfigureCell")
        self.DetailTBL.register(UINib.init(nibName: "RunningOrderTrackCell", bundle: nil), forCellReuseIdentifier: "RunningOrderTrackCell")
        self.DetailTBL.register(UINib.init(nibName: "RunningOrderCell", bundle: nil), forCellReuseIdentifier: "RunningOrderCell")
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
            if self.getcarouselCell() > 0 {
                self.DetailTBL.tableHeaderView = self.carouselView
                self.carouselView.reloadData()
            }
            self.title = self.FoodDetails.title
            self.SetupNavBarwithBack_cart()
            self.setupBottomOption()
            break
            
        case .Meals:
            self.DetailTBL.backgroundColor = ModeBG_Color
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = ModeBG_Color
            if self.getcarouselCell() > 0 {
                self.DetailTBL.tableHeaderView = self.carouselView
                self.carouselView.reloadData()
            }
            self.title = self.MealDetails.title
            self.SetupNavBarwithBack_cart()
            self.setupBottomOption()
            break
            
        case .Banner:
            self.DetailTBL.backgroundColor = ModeBG_Color
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = ModeBG_Color
            self.title = self.BannerDetails.bannerTitle
            self.DateView.isHidden = true
            self.Price_cart_View.isHidden = true
            self.SetupNavBarwithBack_cart()
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
            self.DateView.isHidden = true
            self.Price_cart_View.isHidden = true
            self.SetupNavBarwithBack_cart()
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
            break
            
        case .Address:
            self.DetailTBL.backgroundColor = TBLBackgroundCOlor
            self.DetailTBL.separatorStyle = .none
            self.view.backgroundColor = TBLBackgroundCOlor
            
            self.title = "Addresses"
            self.SetupNavBarforback()
            self.NodataFoundView.isHidden = true
            self.DetailTBL.isHidden = false
            
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
            
            
            let payBTN = UIButton().NavAddButton()
            payBTN.addTarget(self, action: #selector(TappedAddPaymentBTN(_:)), for: .touchUpInside)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: payBTN)
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
    
    func setupBottomOption() {
        
        self.DateView.isHidden = false
        self.Price_cart_View.isHidden = false
        
        if self.DetailType == .Meals {
            self.DateLBL.text = "Plan Start-End date"
        }
        else {
            self.DateLBL.text = "Select Delivery Date"
        }
        
        let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, self.DetailType == .Food ? self.FoodDetails.price!.formatprice() : self.MealDetails.price!.formatprice())
        self.PriceLBL.text = priceSTR
        
        self.BottomStack.backgroundColor = ModeBG_Color
        self.DateView.backgroundColor = ModeBG_Color
        self.DateSelection.backgroundColor = ModeBG_Color
        
        self.DateIMG.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.DateLBL.textColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        
        self.DateSelection.clipsToBounds = true
        self.DateSelection.layer.cornerRadius = 10
        self.DateSelection.layer.borderColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).cgColor
        self.DateSelection.layer.borderWidth = 1
        
        self.AddCartBTN.GetThemeButtonwithBorder()
        self.AddCartBTN.isEnabled = false
        self.AddCartBTN.alpha = 0.5
        
        self.Price_cart_View.backgroundColor = ModeBG_Color
        self.CartStack.backgroundColor = ModeBG_Color
    }
    
    //    MARK:- IBAction Methods
    //    MARK:-
    
    @IBAction func Tappedbuttons(_ sender: UIButton) {
        if sender == self.AddCartBTN {
            if SharedUserInfo.shared.IsUserLoggedin()! {
                self.TappedCartBTN(self.AddCartBTN)
            }
            else {
                let vc = LoginVC(nibName: "LoginVC", bundle: nil)
                self.navigationController!.pushViewController(vc, animated: true)
            }
        }
        else {
            self.CalendarSelection()
        }
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
            return (self.FoodDetails.gallery?.count)!
            
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
            imageURL = self.FoodDetails.gallery![index]
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
            let imageURL: String = self.getCarouselImageURL(index: index)
            itemView.downloadedFrom(url: URL.init(string: imageURL)!)
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
            return 2
            
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
            return 3
            
        case .Meals:
            return section == 0 ? 4 : (self.MealDetails.items?.count)!
            
        case .Banner:
            return 1
            
        case .Notification:
            return 1
            
        case .Address:
            return self.AddressArry.count
            
        case .Payment:
            return section == 0 ? 1 : self.AddressArry.count
            
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
        if section == 0 && (self.CartItems?.fooditems!.count)! >= 1 {
            rows = (self.CartItems?.fooditems!.count)!
        }
        else if section == 1 && (self.CartItems?.mealitems!.count)! >= 1 {
            rows = (self.CartItems?.mealitems!.count)!
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
                self.Sectiontitle.text = "Upcoming Meals"
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
            // Pending Carts
//            if indexPath.section == 0 {
//                let vc = HomeDetailsVC(nibName: "HomeDetailsVC", bundle: nil)
//                vc.DetailType = .TrackOrder
//                self.navigationController!.pushViewController(vc, animated: true)
//            }
//            else {
//                let details = HomeDetailsVC.init(nibName: "HomeDetailsVC", bundle: nil)
//                details.DetailType = .HistoryDetails
//                //            details.CartItems = self.HistoryArry[indexPath.row]
//                self.navigationController?.pushViewController(details, animated: true)
//            }
            break
            
        case .Address:
            if self.DetailsDelegates != nil {
                self.DetailsDelegates.didselectedAddress(data: self.AddressArry[indexPath.row])
                self.navigationController?.popViewController(animated: true)
            }
            break
            
        case .Payment:
            if indexPath.section == 0 {
                
            }
            else {
                if self.DetailsDelegates != nil {
                    self.DetailsDelegates.didselectedPaymentmode()
                    self.navigationController?.popViewController(animated: true)
                }
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
                // Pending Carts
//                let details = HomeDetailsVC.init(nibName: "HomeDetailsVC", bundle: nil)
//                details.DetailType = .HistoryDetails
//                self.navigationController?.pushViewController(details, animated: true)
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
        cell.SetupCell(indexPath: indexPath, data: AddressListModelClass.init(id: data.id, isprimary: false, address: data.address))
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
        if indexPath.section == 0 {
            let cell: UserOptionCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "UserOptionCell") as! UserOptionCell
            cell.setupPayment()
            cell.didTappedAction1Block = {
                
            }
            cell.didTappedAction2Block = {
                
            }
            return cell
        }
        else {
            let cell: AddressCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "AddressCell") as! AddressCell
            cell.setupPaymentCell(indexPath: indexPath)
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
                // Pending Carts
//                let vc = HomeDetailsVC(nibName: "HomeDetailsVC", bundle: nil)
//                vc.DetailType = .TrackOrder
//                self.navigationController!.pushViewController(vc, animated: true)
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
        
        if (self.CartItems?.fooditems!.count)! >= 1 {
            let cell: CartItemCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "CartItemCell") as! CartItemCell
            let food = self.CartItems?.fooditems![indexPath.row]
            cell.setupfoodcell(food: food!)
            cell.DeleteBTN.isHidden = true
            return cell
        }
        else {
            return self.DetailTBL.SetupBlankCell(indexPath: indexPath)
        }
        
    }
    
    func MEAL_ConfigCellFor(indexPath: IndexPath) -> UITableViewCell {
        if (self.CartItems?.mealitems!.count)! >= 1 {
            let cell: CartItemCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "CartItemCell") as! CartItemCell
            let meal = self.CartItems?.mealitems![indexPath.row]
            cell.setupmealcell(meal: meal!)
            cell.DeleteBTN.isHidden = true
            return cell
        }
        else {
            return self.DetailTBL.SetupBlankCell(indexPath: indexPath)
        }
    }
    
    func CART_ConfigCellFor(indexPath: IndexPath) -> UITableViewCell {
        
        if (self.CartItems?.mealitems!.count)! >= 1 || (self.CartItems?.fooditems!.count)! >= 1 {
            // Delivery Date Cell Defines
            if indexPath.row == 0 {
                let cell: CartConfigureCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
                cell.DeliverySetup(indexPath: indexPath)
                return cell
            }
            // Shipping Cell Defines
            else if indexPath.row == 1 {
                let cell: CartConfigureCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
                cell.Setupshoppingcell()
                cell.HeaderView.isHidden = false
                cell.DetailBTN.isHidden = true
                return cell
            }
            // Payment Mode Cell Defines
            else if indexPath.row == 2 {
                let cell: CartConfigureCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
                cell.SetupPaymentcell()
                cell.HeaderView.isHidden = false
                cell.DetailBTN.isHidden = true
                return cell
            }
            // Invoice Cell Defines
            else if indexPath.row == 3 {
                let cell: CartConfigureCell = self.DetailTBL.dequeueReusableCell(withIdentifier: "CartConfigureCell") as! CartConfigureCell
                cell.SetupInvoicecell(invoiceObj: CartInvoice.init(item: [Cartitems.init(id: 0, title: "fadfsadf", price: 20, qty: 5)]), Cartcoupon: CartCoupon.init(id: 2, code: "ffsfsa", value: 20, isApply: false))
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
                cell.ReviewSetupView()
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
            cell.setupBannercell(food: self.BannerDetails)
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
        if self.DetailType == .Food {
            calendarVC.optionStyles.showDateMonth(true)
            calendarVC.optionStyles.showMonth(false)
            calendarVC.optionStyles.showYear(false)
            calendarVC.optionStyles.showTime(false)
        }
        else if self.DetailType == .Meals {
            calendarVC.optionSelectionType = WWCalendarTimeSelectorSelection.range
            calendarVC.optionCurrentDates = Set(multipleDates)
        }
        present(calendarVC, animated: true, completion: nil)
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        singleDate = date
        self.AddCartBTN.isEnabled = true
        self.AddCartBTN.alpha = 1.0
        self.DateLBL.text = String.init(format: "%@", self.singleDate.convertDateFormater())
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, dates: [Date]) {
        print("Selected Multiple Dates \n\(dates)\n---")
        multipleDates = dates
        self.AddCartBTN.isEnabled = true
        self.AddCartBTN.alpha = 1.0
        self.DateLBL.text = dates.first?.convertDaterang(dt1: self.multipleDates.first!, dt2: self.multipleDates.last!)
    }
    
    func WWCalendarTimeSelectorShouldSelectDate(_ selector: WWCalendarTimeSelector, date: Date) -> Bool {
        if date > Date() || date.convertDateFormater() == Date().convertDateFormater() {
            return true
        }
        return false
    }
    
}
