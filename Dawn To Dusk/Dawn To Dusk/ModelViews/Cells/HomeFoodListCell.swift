//
//  HomeFoodListCell.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 28/07/21.
//

import UIKit
import SkeletonView

class HomeFoodListCell: UITableViewCell {

    //    MARK:- IBOutlets
    //    MARK:-
    
    @IBOutlet weak var ContainView: UIView!
    @IBOutlet weak var FoodIMG: UIImageView!
    @IBOutlet weak var FilterView: UIView!
    @IBOutlet weak var FilterIMG: UIImageView!
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var DescLBL: UILabel!
    @IBOutlet weak var PriceLBL: UILabel!
    @IBOutlet weak var OptionView: UIView!
    @IBOutlet weak var AddCartBTN: UIButton!
    @IBOutlet weak var QTY_View: UIView!
    @IBOutlet weak var MinusBTN: UIButton!
    @IBOutlet weak var QTY_LBL: UILabel!
    @IBOutlet weak var PlusBTN: UIButton!
    @IBOutlet weak var Card_height: NSLayoutConstraint!
    
    //    MARK:- Variable Defines
    //    MARK:-
    
    var didCartActionBlock: (()->())?
    var didMinusActionBlock: (()->())?
    var didPlusActionBlock: (()->())?
    
    var QTY_Count: Int = 1
    
    //    MARK:- Awake methods
    //    MARK:-
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ModeBG_Color
        self.contentView.backgroundColor = ModeBG_Color
        self.OptionView.backgroundColor = .clear
        self.FilterView.backgroundColor = .clear
        
        self.FoodIMG.contentMode = .scaleToFill
        
        self.ContainView.clipsToBounds = true
        self.ContainView.layer.cornerRadius = 15
        self.ContainView.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.3)
        
        self.QTY_View.isHidden = true
        self.QTY_View.clipsToBounds = true
        self.QTY_View.layer.cornerRadius = 10
        self.MinusBTN.setTitleColor(UIColor.colorWithHexString(hexStr: GetDefaultTheme()!), for: .normal)
        self.PlusBTN.setTitleColor(UIColor.colorWithHexString(hexStr: GetDefaultTheme()!), for: .normal)
        self.QTY_View.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.QTY_LBL.text = String.init(format: "%d", self.QTY_Count)
        self.QTY_View.layer.borderColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).cgColor
        self.QTY_View.layer.borderWidth = 1.0
        
        self.AddCartBTN.GetThemeButtonwithBorder()
        
        self.ShowSkeleton()
    }
    
    func ShowSkeleton() {
        self.FoodIMG.showAnimatedGradientSkeleton()
        self.FilterIMG.showAnimatedGradientSkeleton()
        self.TitleLBL.showAnimatedGradientSkeleton()
        self.DescLBL.showAnimatedGradientSkeleton()
        self.PriceLBL.showAnimatedGradientSkeleton()
        self.AddCartBTN.showAnimatedGradientSkeleton()
        self.QTY_View.showAnimatedGradientSkeleton()
    }
    
    func HideSkeleton() {
        self.FoodIMG.hideSkeleton()
        self.FilterIMG.hideSkeleton()
        self.TitleLBL.hideSkeleton()
        self.DescLBL.hideSkeleton()
        self.PriceLBL.hideSkeleton()
        self.AddCartBTN.hideSkeleton()
        self.QTY_View.hideSkeleton()
    }
    
    //    MARK:- Custom Defines
    //    MARK:-
    
    func setupmealplan_foodcell(food: FoodModelClass) {
        self.FilterView.isHidden = false
        self.OptionView.isHidden = false
        self.FilterIMG.tintColor = food.isveg! ? UIColor.colorWithHexString(hexStr: GreenTheme) : .red
        self.FoodIMG.downloadedFrom(url: URL.init(string: food.foodimage!)!)
        self.FoodIMG.contentMode = .scaleToFill
        self.TitleLBL.text = food.title
        self.DescLBL.text = food.foodShortdesc
        let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, food.price!.formatprice())
        self.PriceLBL.text = priceSTR
        self.AddCartBTN.isHidden = true
        self.HideSkeleton()
    }
    
    func setupfoodcell(food: FoodModels) {
        self.FilterView.isHidden = false
        self.OptionView.isHidden = false
        self.FilterIMG.tintColor = food.isveg! ? UIColor.colorWithHexString(hexStr: GreenTheme) : .red
        self.FoodIMG.downloadedFrom(url: URL.init(string: food.itemimage!)!)
        self.FoodIMG.contentMode = .scaleToFill
        self.TitleLBL.text = food.title
        self.DescLBL.text = food.shortdesc
        let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, food.price.formatprice())
        self.PriceLBL.text = priceSTR
        self.AddCartBTN.isHidden = false
        self.HideSkeleton()
    }
    
    func setupmealcell(meal: MealModelClass) {
        self.FilterView.isHidden = false
        self.OptionView.isHidden = false
        self.FilterIMG.tintColor = meal.isveg! ? UIColor.colorWithHexString(hexStr: GreenTheme) : .red
        self.FoodIMG.downloadedFrom(url: URL.init(string: meal.mealimage!)!)
        self.FoodIMG.contentMode = .scaleToFill
        self.TitleLBL.text = meal.title
        self.DescLBL.text = meal.mealShortdesc
        let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, meal.price!.formatprice())
        self.PriceLBL.text = priceSTR
        self.AddCartBTN.isHidden = false
        self.HideSkeleton()
    }
    
    func setupHistorycell(history: OrderHistoryModelData, indexPath: IndexPath) {
        self.FilterView.isHidden = true
        self.OptionView.isHidden = true
        self.FoodIMG.downloadedFrom(url: URL.init(string: history.foodimage!)!)
        self.FoodIMG.contentMode = .scaleToFill
        self.TitleLBL.text = history.title
        self.DescLBL.text = history.foodShortdesc
        let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, history.paybleamount!.formatprice())
        self.PriceLBL.text = priceSTR
        self.HideSkeleton()
    }
    
    //    MARK:- IBAction Methods Defines
    //    MARK:-
    
    @IBAction func TappedButton(_ sender: UIButton) {
        if sender == self.AddCartBTN {
            if self.didCartActionBlock != nil {
                self.didCartActionBlock!()
            }
        }
        else if sender == self.MinusBTN {
            if self.didMinusActionBlock != nil {
                self.didMinusActionBlock!()
            }
        }
        else if sender == self.PlusBTN {
            if self.didPlusActionBlock != nil {
                self.didPlusActionBlock!()
            }
        }
        else {
            
        }
    }
    
    
}
