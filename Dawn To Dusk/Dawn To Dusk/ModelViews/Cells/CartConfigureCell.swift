//
//  CartConfigureCell.swift
//  Dawn To Dusk
//
//  Created by Hiren on 05/08/21.
//

import UIKit


enum InputType {
    case Line1, Line2, coupon, Comments
}


class CartConfigureCell: UITableViewCell {
    
    //    MARK:- IBOutlets
    //    MARK:-
    
    @IBOutlet weak var MainContainStack: UIStackView!
    
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var DetailBTN: UIButton!
    
    @IBOutlet weak var ContainVIew: UIStackView!
    
    @IBOutlet weak var PayStack: UIView!
    @IBOutlet weak var LBLTitle: UILabel!
    @IBOutlet weak var LBLValue: UILabel!
    
    @IBOutlet weak var CouponStack: UIView!
    @IBOutlet weak var LBLCoupon: UITextField!
    @IBOutlet weak var CouponBTN: UIButton!
    
    @IBOutlet weak var RecieptStack: UIView!
    @IBOutlet weak var ItemLBL: UILabel!
    @IBOutlet weak var ItemValueLBL: UILabel!
    @IBOutlet weak var ShippingLBL: UILabel!
    @IBOutlet weak var ShippingValueLBL: UILabel!
    @IBOutlet weak var VATLBL: UILabel!
    @IBOutlet weak var VATValueLBL: UILabel!
    @IBOutlet weak var ApplyCouponStack: UIStackView!
    @IBOutlet weak var CouponLBL: UILabel!
    @IBOutlet weak var RemoveCouponBTN: UIButton!
    @IBOutlet weak var CouponValueLBL: UILabel!
    @IBOutlet weak var LineIMG: UIImageView!
    @IBOutlet weak var TotalLBL: UILabel!
    @IBOutlet weak var TotalValueLBL: UILabel!
    @IBOutlet weak var VATTop_constraint: NSLayoutConstraint!
    
    @IBOutlet weak var AgreeView: UIView!
    @IBOutlet weak var CheckBoxBTN: UIButton!
    @IBOutlet weak var AgreeLBL: UILabel!
    @IBOutlet weak var CheckOutBTN: UIButton!
    
    @IBOutlet weak var ShippingView: UIView!
    @IBOutlet weak var CommunityStack: UIStackView!
    @IBOutlet weak var CommunityLBL: UILabel!
    @IBOutlet weak var CommunityView: UIView!
    @IBOutlet weak var SelectedCommunityLBL: UILabel!
    @IBOutlet weak var DownIMG: UIImageView!
    @IBOutlet weak var CommunityBTN: UIButton!
    @IBOutlet weak var VillaStack: UIStackView!
    @IBOutlet weak var Line1LBL: UILabel!
    @IBOutlet weak var TXTVilla: UITextField!
    @IBOutlet weak var LandStack: UIStackView!
    @IBOutlet weak var Line2LBL: UILabel!
    @IBOutlet weak var TXTLand: UITextField!
    
    @IBOutlet weak var Review: UIView!
    @IBOutlet weak var Rating: FloatRatingView!
    @IBOutlet weak var UserComments: UIView!
    @IBOutlet weak var TXTComments: UITextView!
    @IBOutlet weak var SubmitReview: UIButton!
    
    @IBOutlet weak var DeliveryDateView: UIView!
    @IBOutlet weak var DeliveryDateLBL: UILabel!
    @IBOutlet weak var CalenderIMG: UIImageView!
    
    //    MARK:- Variable Defines
    //    MARK:-
    
    var didDetailsActionBlock: (()->())?
    var didCouponActionBlock: ((String?)->())?
    var didRemoveCouponActionBlock: (()->())?
    var didCheckoutActionBlock: (()->())?
    var didTextupdateBlock: ((String?, InputType?)->())?
    var didDropDownActionBlock: ((Bool?)->())?
    var didRatingActionBlock: ((Double?, String?)->())?
    
    var ratting: Double = 0.0
    
    lazy var placeLBL : UILabel = {
        let lbl = UILabel.init(frame: CGRect.init(x: 20, y: 20, width: 100, height: 15))
        lbl.textColor = UIColor.secondaryLabel.withAlphaComponent(0.3)
        lbl.text = "Write us here!"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.isHidden = false
        self.UserComments.addSubview(lbl)
        return lbl
    }()
    
    //    MARK:- Awake methods
    //    MARK:-
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ModeBG_Color
        self.contentView.backgroundColor = ModeBG_Color
        self.MainContainStack.backgroundColor = ModeBG_Color
        
        self.DeliveryDateView.backgroundColor = ModeBG_Color
        
        self.HeaderView.backgroundColor = ModeBG_Color
        
        self.DetailBTN.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.LineIMG.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        
        self.ContainVIew.clipsToBounds = true
        self.ContainVIew.layer.cornerRadius = 10
        self.ContainVIew.backgroundColor = ModeBG_Color
        self.ContainVIew.layer.borderColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).cgColor
        
        self.ShippingView.backgroundColor = ModeBG_Color
        self.CommunityStack.backgroundColor = ModeBG_Color
        self.VillaStack.backgroundColor = ModeBG_Color
        self.LandStack.backgroundColor = ModeBG_Color
        
        self.TitleLBL.font = UIFont.boldSystemFont(ofSize: 24)
        self.TotalLBL.font = UIFont.boldSystemFont(ofSize: 20)
        self.TotalValueLBL.font = UIFont.boldSystemFont(ofSize: 20)
        
        self.LBLCoupon.font = UIFont.boldSystemFont(ofSize: 18)
        self.CouponBTN.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.CouponBTN.setTitleColor(.white, for: .normal)
        self.CouponBTN.setTitle("Apply", for: .normal)
        
        self.LBLCoupon.delegate = self
        self.TXTLand.delegate = self
        self.TXTVilla.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.removeCoupons(sender:)))
        self.CouponLBL.addGestureRecognizer(tap)
        self.CouponValueLBL.addGestureRecognizer(tap)
        self.CouponValueLBL.textColor = UIColor.colorWithHexString(hexStr: "#D81919")
        
        self.AgreeLBL.text = "I am agree with above all selection and delivery address which is mention above place."
        self.CheckBoxBTN.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
        self.CheckBoxBTN.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.CheckOutBTN.GetThemeButtonwithBorder()
        self.CheckOutBTN.setTitleColor(.white, for: .normal)
        self.CheckOutBTN.setTitle("Check Out", for: .normal)
        self.CheckOutBTN.isEnabled = false
        self.CheckOutBTN.alpha = 0.5
        self.CheckBoxBTN.isSelected = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //    MARK:- Custom Defines
    //    MARK:-
    
    func Setupshoppingcell(indexPath: IndexPath) {
        
        self.CommunityBTN.isSelected = false
        
        self.backgroundColor = ModeBG_Color
        self.contentView.backgroundColor = ModeBG_Color
        
        self.ContainVIew.layer.borderWidth = 1.0
    
        self.ShippingView.isHidden = false
        self.DetailBTN.isHidden = false
        self.HeaderView.isHidden = false
        self.PayStack.isHidden = true
        self.CouponStack.isHidden = true
        self.RecieptStack.isHidden = true
        self.AgreeView.isHidden = true
        self.Review.isHidden = true
        self.DeliveryDateView.isHidden = true
        
        self.TitleLBL.text = "Delivery Details"
        self.CommunityLBL.text = "Community"
        self.SelectedCommunityLBL.text = "Select the Community"
        self.Line1LBL.text = "Landmark 1"
        self.TXTVilla.placeholder = "Enter Landmark 1"
        self.Line2LBL.text = "Landmark 2"
        self.TXTLand.placeholder = "Enter Landmark 2"
    }
    
    func SetupPaymentcell(indexPath: IndexPath) {
        self.HeaderView.isHidden = false
        self.ContainVIew.layer.borderWidth = 1
        self.TitleLBL.text = "Payment Mode"
        self.LBLTitle.text = "Payment Gateway"
        self.LBLValue.text = "COD"
        self.PayStack.isHidden = false
        self.ShippingView.isHidden = true
        self.CouponStack.isHidden = true
        self.RecieptStack.isHidden = true
        self.DetailBTN.isHidden = false
        self.AgreeView.isHidden = true
        self.Review.isHidden = true
        self.DeliveryDateView.isHidden = true
    }
    
    func SetupCouponcell(indexPath: IndexPath) {
        
        self.HeaderView.isHidden = false
        self.ContainVIew.layer.borderWidth = 1
        self.TitleLBL.text = "Coupon"
        self.PayStack.isHidden = true
        self.ShippingView.isHidden = true
        self.CouponStack.isHidden = false
        self.RecieptStack.isHidden = true
        self.DetailBTN.isHidden = false
        self.AgreeView.isHidden = true
        self.Review.isHidden = true
        self.DeliveryDateView.isHidden = true
        
    }
    
    func SetupInvoicecell(invoiceObj: CartInvoice, Cartcoupon: CartCoupon, indexPath: IndexPath) {
    
        self.ContainVIew.layer.borderWidth = 1
        self.HeaderView.isHidden = false
        self.TitleLBL.text = "Bill Details"
        self.DetailBTN.isHidden = true
        self.PayStack.isHidden = true
        self.ShippingView.isHidden = true
        self.CouponStack.isHidden = true
        self.RecieptStack.isHidden = false
        self.AgreeView.isHidden = true
        self.Review.isHidden = true
        self.DeliveryDateView.isHidden = true
        
        self.ItemLBL.text = String.init(format: "Items Total(%d)", invoiceObj.items.count)
        
        var coupon: Double = 0.0
        if Cartcoupon.isApply! {
            coupon = Cartcoupon.value!
        }
        
        let price = invoiceObj.items.map({ $0.price! * Double($0.qty!)}).reduce(0, +)
        let shiping = 18.0
        let vat = (price * 5 ) / 100
        let finalprice = (price + shiping + vat) - coupon
        
        self.ApplyCouponStack.isHidden = !Cartcoupon.isApply!
        self.VATTop_constraint.constant = self.ApplyCouponStack.isHidden ? -20 : +20
        
        self.ItemValueLBL.text = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, price.formatprice())
        self.ShippingLBL.text = "Delivery Charges "
        self.ShippingValueLBL.text = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, shiping.formatprice())
        self.VATLBL.text = "VAT(5%)"
        self.VATValueLBL.text = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, vat.formatprice())
        self.CouponLBL.text = "Coupon Discount"
        self.TotalLBL.textColor = UIColor.colorWithHexString(hexStr: "#D81919")
        self.CouponValueLBL.text = String.init(format: "- %@ %@", (getdefaultCountry()?.symbol)!, coupon.formatprice())

        self.TotalLBL.text = "TOTAL To Pay"
        self.TotalLBL.textColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.TotalValueLBL.text = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, finalprice.formatprice())
        self.TotalValueLBL.textColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
    }
    
    func AgreeSetupView(indexPath: IndexPath) {
        self.ContainVIew.layer.borderWidth = 0.0
        self.AgreeView.isHidden = false
        self.ShippingView.isHidden = true
        self.HeaderView.isHidden = true
        self.DetailBTN.isHidden = true
        self.PayStack.isHidden = true
        self.CouponStack.isHidden = true
        self.RecieptStack.isHidden = true
        self.Review.isHidden = true
        self.DeliveryDateView.isHidden = true
    }
    
    func ReviewSetupView(isItShow: Bool = false, indexPath: IndexPath) {
        self.ContainVIew.layer.borderWidth = 0.0
        self.Review.isHidden = false
        self.HeaderView.isHidden = false
        self.TitleLBL.text = "Rate the Order"
        self.DetailBTN.isHidden = true
        self.AgreeView.isHidden = true
        self.ShippingView.isHidden = true
        self.DetailBTN.isHidden = true
        self.PayStack.isHidden = true
        self.CouponStack.isHidden = true
        self.RecieptStack.isHidden = true
        self.DeliveryDateView.isHidden = true
        
        self.Rating.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        
        if isItShow {
            self.Rating.editable = false
            self.TXTComments.isEditable = false
            self.SubmitReview.isHidden = true
            self.placeLBL.isHidden = true
        }
        else {
            self.Rating.delegate = self
            self.Rating.rating = 0
            self.TXTComments.delegate = self
            self.Rating.editable = true
            self.TXTComments.isEditable = true
            self.SubmitReview.isHidden = false
            self.placeLBL.isHidden = false
        }
        
        self.UserComments.clipsToBounds = true
        self.UserComments.layer.cornerRadius = 10
        self.UserComments.backgroundColor = ModeBG_Color
        self.UserComments.layer.borderColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).cgColor
        self.UserComments.layer.borderWidth = 1.0
        
        self.SubmitReview.tintColor = UIColor.clear
        self.SubmitReview.GetThemeButtonwithBorder()
        self.SubmitReview.setTitleColor(.white, for: .normal)
        self.SubmitReview.setTitle("Submit", for: .normal)
        self.SubmitReview.isEnabled = false
        self.SubmitReview.alpha = 0.5
        
    }
    
    func DeliverySetup(indexPath: IndexPath) {
        self.DeliveryDateView.clipsToBounds = true
        self.DeliveryDateView.layer.cornerRadius = 10
        self.DeliveryDateView.backgroundColor = ModeBG_Color
        self.DeliveryDateView.layer.borderColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).cgColor
        self.DeliveryDateView.layer.borderWidth = 1.0
        
        self.DeliveryDateLBL.textColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.CalenderIMG.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        
        self.ContainVIew.layer.borderWidth = 0.0
        self.DeliveryDateView.isHidden = false
        self.Review.isHidden = true
        self.HeaderView.isHidden = false
        self.TitleLBL.text = "Delivery Date"
        self.DetailBTN.isHidden = true
        self.AgreeView.isHidden = true
        self.ShippingView.isHidden = true
        self.DetailBTN.isHidden = true
        self.PayStack.isHidden = true
        self.CouponStack.isHidden = true
        self.RecieptStack.isHidden = true
    }
    
    //    MARK:- Action Defines
    //    MARK:-
    
    @objc func removeCoupons(sender : UITapGestureRecognizer) {
        if self.didRemoveCouponActionBlock != nil {
            self.didRemoveCouponActionBlock!()
        }
    }
    
    @IBAction func TappedActionBTN(_ sender: UIButton) {
        if sender == self.DetailBTN {
            if self.didDetailsActionBlock != nil {
                self.didDetailsActionBlock!()
            }
        }
        else if sender == self.RemoveCouponBTN {
            if self.didRemoveCouponActionBlock != nil {
                self.didRemoveCouponActionBlock!()
            }
        }
        else if sender == self.CouponBTN {
            if self.didCouponActionBlock != nil {
                if self.LBLCoupon.text!.count > 0 {
                    self.didCouponActionBlock!(self.LBLCoupon.text)
                }
            }
        }
        else if sender == self.CheckBoxBTN {
            if sender.isSelected {
                self.CheckOutBTN.isEnabled = false
                self.CheckOutBTN.alpha = 0.5
                sender.isSelected = false
                self.CheckBoxBTN.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
            }
            else {
                self.CheckOutBTN.isEnabled = true
                self.CheckOutBTN.alpha = 1.0
                sender.isSelected = true
                self.CheckBoxBTN.setImage(UIImage.init(systemName: "checkmark.circle.fill"), for: .normal)
            }
        }
        else if sender == self.CheckOutBTN {
            if self.didCheckoutActionBlock != nil {
                self.didCheckoutActionBlock!()
            }
        }
        else if sender == self.SubmitReview {
            if self.Rating.rating != 0 {
                if self.didRatingActionBlock != nil {
                    self.didRatingActionBlock!(self.ratting, self.TXTComments.text)
                }
            }
        }
        else {
            if self.didDropDownActionBlock != nil {
                if self.CommunityBTN.isSelected {
                    self.CommunityBTN.isSelected = true
                }
                else {
                    self.CommunityBTN.isSelected = false
                }
                self.didDropDownActionBlock!(self.CommunityBTN.isSelected)
            }
        }
    }

}

//MARK:- Textfield Delegates
extension CartConfigureCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        if textField == self.LBLCoupon {
//            if self.didTextupdateBlock != nil {
//                self.didTextupdateBlock!(newString as String, .coupon)
//            }
        }
        else if textField == self.TXTVilla {
            if self.didTextupdateBlock != nil {
                self.didTextupdateBlock!(newString as String, .Line1)
            }
        }
        else {
            if self.didTextupdateBlock != nil {
                self.didTextupdateBlock!(newString as String, .Line2)
            }
        }
        return true
    }
    
}

//MARK:- FloatRatingViewDelegate
extension CartConfigureCell: FloatRatingViewDelegate {

    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        self.ratting = rating
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        self.ratting = rating
    }
    
}

//MARK:- UITextView Delegate
extension CartConfigureCell: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentString: NSString = textView.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: text) as NSString
        if self.didTextupdateBlock != nil {
            self.didTextupdateBlock!(newString as String, .Comments)
        }
        if newString.length == 0 {
            self.SubmitReview.isEnabled = false
            self.SubmitReview.alpha = 0.5
            self.placeLBL.isHidden = false
        }
        else {
            self.SubmitReview.isEnabled = true
            self.SubmitReview.alpha = 1.0
            self.placeLBL.isHidden = true
        }
        return true
    }
    
}
