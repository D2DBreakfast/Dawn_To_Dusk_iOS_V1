//
//  CartItemCell.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 04/08/21.
//

import UIKit

class CartItemCell: UITableViewCell {
    
    //    MARK:- IBoutlet Defines
    //    MARK:-
    
    @IBOutlet weak var ItemCell: UIView!
    
    @IBOutlet weak var ItemIMG: UIImageView!
    @IBOutlet weak var PriceLBL: UILabel!
    @IBOutlet weak var DeleteBTN: UIButton!
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var DescLBL: UILabel!
    @IBOutlet weak var DateLBL: UILabel!
    
    @IBOutlet weak var QTYView: UIView!
    @IBOutlet weak var MinusBTN: UIButton!
    @IBOutlet weak var PlusBTN: UIButton!
    @IBOutlet weak var QTY_LBL: UILabel!
    
    
    //    MARK:- Variable Defines
    //    MARK:-
    
    var QTY_Count: Int = 1
    
    var didDeleteActionBlock: (()->())?
    var didMinusActionBlock: (()->())?
    var didPlusActionBlock: (()->())?
    
    
    //    MARK:- Awake Defines
    //    MARK:-
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = ModeBG_Color
        self.contentView.backgroundColor = ModeBG_Color
        
        self.ItemIMG.contentMode = .scaleToFill
        
        self.ItemCell.clipsToBounds = true
        self.ItemCell.layer.cornerRadius = 15
        self.ItemCell.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.3)
        
        self.PriceLBL.text = ""
        self.TitleLBL.text = ""
        self.DescLBL.text = ""
        self.DateLBL.text = ""
        
        self.QTYView.isHidden = false
        self.QTYView.clipsToBounds = true
        self.QTYView.layer.cornerRadius = 10
        self.MinusBTN.setTitleColor(UIColor.colorWithHexString(hexStr: GetDefaultTheme()!), for: .normal)
        self.PlusBTN.setTitleColor(UIColor.colorWithHexString(hexStr: GetDefaultTheme()!), for: .normal)
        self.QTYView.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.QTYView.layer.borderColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).cgColor
        self.QTYView.layer.borderWidth = 1.0
        self.QTY_LBL.text = String.init(format: "%d", self.QTY_Count)
        
        self.ItemCell.layer.borderColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).cgColor
        self.ItemCell.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //    MARK:- Custom Defines
    //    MARK:-
    
    func setupfoodcell(food: FoodModelClass) {
        self.ItemIMG.tintColor = food.isveg! ? UIColor.colorWithHexString(hexStr: GreenTheme) : .red
        self.ItemIMG.downloadedFrom(url: URL.init(string: food.foodimage!)!)
        self.ItemIMG.contentMode = .scaleToFill
        self.TitleLBL.text = food.title
        self.DescLBL.text = food.foodShortdesc
        let result:Double = Double(((food.price)! * Double(QTY_Count)))
        let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, result.formatprice())
        self.PriceLBL.text = priceSTR
    }
    
    func setupmealcell(meal: MealModelClass) {
        self.ItemIMG.tintColor = meal.isveg! ? UIColor.colorWithHexString(hexStr: GreenTheme) : .red
        self.ItemIMG.downloadedFrom(url: URL.init(string: meal.mealimage!)!)
        self.ItemIMG.contentMode = .scaleToFill
        self.TitleLBL.text = meal.title
        self.DescLBL.text = meal.mealShortdesc
        let result:Double = Double(((meal.price)! * Double(QTY_Count)))
        let priceSTR: String = String.init(format: "%@ %@", (getdefaultCountry()?.symbol)!, result.formatprice())
        self.PriceLBL.text = priceSTR
    }
    
    
    //    MARK:- IBAction Defines
    //    MARK:-

    @IBAction func TappedButton(_ sender: UIButton) {
        if sender == self.DeleteBTN {
            if self.didDeleteActionBlock != nil {
                self.didDeleteActionBlock!()
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

