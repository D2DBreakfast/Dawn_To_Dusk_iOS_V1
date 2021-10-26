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
    
    func MealsitemsDay(index: Int) -> String? {
        switch index {
        case 0:
            return "Sunday"
            
        case 1:
            return "Monday"
            
        case 2:
            return "Tuesday"
            
        case 3:
            return "Wednesday"
            
        case 4:
            return "Thursday"
            
        case 6:
            return "Saturday"
            
        default:
            return ""
        }
    }
    
    func setupmealplan_foodcell(meals: MealsModels, indexPath: IndexPath) {
        let food = meals.items[indexPath.row]
        self.FilterView.isHidden = false
        self.OptionView.isHidden = false
        self.FilterIMG.tintColor = meals.isveg! ? UIColor.colorWithHexString(hexStr: GreenTheme) : .red
        self.FoodIMG.downloadedFrom(url: URL.init(string: food.itemimage!.ImageURL_str())!)
//        self.FoodIMG.image = UIImage.init(named: "DefaultImage")
        self.FoodIMG.contentMode = .scaleToFill
        self.TitleLBL.text = food.title
        self.DescLBL.text = food.shortdesc
        self.AddCartBTN.isHidden = true
        self.PriceLBL.isHidden = false
        self.PriceLBL.text = self.MealsitemsDay(index: indexPath.row)
        self.HideSkeleton()
    }
    
    func setupfoodcell(food: MenuItemsData) {
        self.FilterView.isHidden = false
        self.OptionView.isHidden = false
        self.FilterIMG.tintColor = food.itemFoodType.uppercased() == "Veg".uppercased() ? UIColor.colorWithHexString(hexStr: GreenTheme) : .red
        self.FoodIMG.downloadedFrom(url: URL.init(string: food.itemImageUrl!.ImageURL_str())!)
//        self.FoodIMG.image = UIImage.init(named: "DefaultImage")
        self.FoodIMG.contentMode = .scaleToFill
        self.TitleLBL.text = food.itemName
        self.DescLBL.text = food.itemDescription
//        let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, food.itemPrice.formatprice())
        let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, food.itemPrice.formatprice())
        self.PriceLBL.text = priceSTR
        self.AddCartBTN.isHidden = false
        self.PriceLBL.isHidden = false
        self.HideSkeleton()
    }
    
    func setupmealcell(meal: MealsModels) {
        self.FilterView.isHidden = false
        self.OptionView.isHidden = false
        self.FilterIMG.tintColor = meal.isveg! ? UIColor.colorWithHexString(hexStr: GreenTheme) : .red
        self.FoodIMG.downloadedFrom(url: URL.init(string: meal.itemimage!.ImageURL_str())!)
//        self.FoodIMG.image = UIImage.init(named: "DefaultImage")
        self.FoodIMG.contentMode = .scaleToFill
        self.TitleLBL.text = meal.title
        self.DescLBL.text = meal.shortdesc
        let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, meal.price!.formatprice())
        self.PriceLBL.text = priceSTR
        self.AddCartBTN.isHidden = false
        self.PriceLBL.isHidden = false
        self.HideSkeleton()
    }
    
    func setupHistorycell(history: OrderDetailsOrderDetail, indexPath: IndexPath) {
        self.FilterView.isHidden = true
        self.OptionView.isHidden = true
//        self.FoodIMG.downloadedFrom(url: URL.init(string: history.ordersitems[indexPath.row].itemimage.ImageURL_str())!)
        self.FoodIMG.image = UIImage.init(named: "DefaultImage")
        self.FoodIMG.contentMode = .scaleToFill
        self.TitleLBL.text = history.itemName
        self.DescLBL.text = "history.ordersitems[indexPath.row].shortdesc"
//        let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, history.ordersitems[indexPath.row].price.formatprice())
        let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, history.itemPrice.formatprice())
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
