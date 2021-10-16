//
//  DetailsBottomOptionView.swift
//  Dawn To Dusk
//
//  Created by Hiren on 28/09/21.
//

import UIKit
import SwiftUI

class DetailsBottomOptionView: UIView {
    
    // MARK: - Properties
    
    @IBOutlet weak var BottomStack: UIStackView!
    @IBOutlet weak var DateView: UIView!
    @IBOutlet weak var DateSelection: UIView!
    @IBOutlet weak var DateLBL: UILabel!
    @IBOutlet weak var DateIMG: UIImageView!
    @IBOutlet weak var DateBTN: UIButton!
    
    @IBOutlet weak var AgreeView: UIView!
    @IBOutlet weak var CheckBoxBTN: UIButton!
    @IBOutlet weak var AgreeLBL: UILabel!
    
    @IBOutlet weak var Price_cart_View: UIView!
    @IBOutlet weak var CartStack: UIStackView!
    @IBOutlet weak var PriceLBL: UILabel!
    @IBOutlet weak var AddCartBTN: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var CartBTN: UIButton!
    @IBOutlet weak var LogoutBTN: UIButton!
    
    var didcallDateAction: (()->())?
    var didcallAgreeAction: (()->())?
    var didcallAddCartAction: (()->())?
    
    @IBInspectable var image: UIImage? {
        get {
            return imageView.image
        }
        set(image) {
            imageView.image = image
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ModeBG_Color
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    fileprivate func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.backgroundColor = ModeBG_Color
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func fillinfo(title: String, isUserProfile: Bool = false) {
        if isUserProfile {
            self.CartBTN.isHidden = true
            self.LogoutBTN.isHidden = false
        }
        else {
            self.CartBTN.isHidden = false
            self.LogoutBTN.isHidden = true
        }
        self.TitleLBL.text = title
        self.CartBTN.isHidden = true
        self.CartBTN.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.LogoutBTN.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.imageView.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
    }
    
    func setupBottomOption(DetailType: ShowDetailType!, FoodDetails: MenuItemsData!, MealDetails: MealsModels!) {
        
        self.DateView.isHidden = true
        self.BottomStack.isHidden = false
        self.Price_cart_View.isHidden = false
        
        self.AgreeLBL.text = "Food will not be delivered on Friday and Saturday. I agree with the Terms of Service."
        self.AgreeLBL.font = .boldSystemFont(ofSize: 17)
        self.AgreeLBL.textColor = .red
        self.AgreeView.isHidden = false
        
//        let tapGest = UITapGestureRecognizer.init(target: self, action: #selector(self.TapGesture()))
//        self.AgreeView.addGestureRecognizer(tapGest)
        
        if DetailType == .Meals {
            self.DateLBL.text = "Plan Start-End date"
        }
        else {
            self.DateLBL.text = "Select Delivery Date"
        }
        
        let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, DetailType == .Food ? FoodDetails.itemPrice : MealDetails.price!.formatprice())
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
    
    @objc func TapGesture() {
        self.TappedButton(self.CheckBoxBTN)
    }
    
    // MARK: - Actions
    
    @objc @IBAction func TappedButton(_ sender: UIButton) {
        if self.DateBTN == sender {
            if self.didcallDateAction != nil {
                self.didcallDateAction!()
            }
        }
        else if sender == self.CheckBoxBTN {
            if self.didcallAgreeAction != nil {
                self.didcallAgreeAction!()
            }
        } else {
            if self.didcallAddCartAction != nil {
                self.didcallAddCartAction!()
            }
        }
    }
}
