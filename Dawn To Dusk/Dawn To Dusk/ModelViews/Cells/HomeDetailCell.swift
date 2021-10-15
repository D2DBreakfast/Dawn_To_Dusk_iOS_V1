//
//  HomeDetailCell.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 30/07/21.
//

import UIKit

class HomeDetailCell: UITableViewCell {
    
    
    //    MARK:- Outlets Defines
    //    MARK:-
    
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var DetailsLBL: UILabel!
    @IBOutlet weak var ButtonView: UIView!
    @IBOutlet weak var ApplyBTN: UIButton!
    
    //    MARK:- Variable Defines
    //    MARK:-
    
    var QTY_Count: Int = 1
    
    var didTappedApplyActionBlock: (()->())?
    
    
    //    MARK:- Awake Defines
    //    MARK:-
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ModeBG_Color
        self.contentView.backgroundColor = ModeBG_Color
        self.TitleLBL.text = ""
        self.TitleLBL.font = UIFont.boldSystemFont(ofSize: 24)
        self.DetailsLBL.text = ""
        self.ApplyBTN.GetThemeButtonwithoutBorder()
        self.ShowSkeleton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func ShowSkeleton() {
        self.TitleLBL.showAnimatedGradientSkeleton()
        self.DetailsLBL.showAnimatedGradientSkeleton()
    }
    
    func HideSkeleton() {
        self.TitleLBL.hideSkeleton()
        self.DetailsLBL.hideSkeleton()
    }
    
    //    MARK:- Custom Defines
    //    MARK:-
    
    func setupfoodcell(food: MenuItemsData, indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            self.TitleLBL.text = food.itemName
            self.DetailsLBL.text = food.itemDescription
        }
//        else if indexPath.section == 0 && indexPath.row == 1 {
//            self.TitleLBL.text = "Nutritional Info."
//            self.DetailsLBL.text = food.nutriInfo
//        }
//        else if indexPath.section == 0 && indexPath.row == 2 {
//            self.TitleLBL.text = "Terms & Conditions"
//            self.DetailsLBL.text = food.info
//        }
        self.ButtonView.isHidden = true
        self.HideSkeleton()
    }
    
    func setupmealcell(meal: MealsModels, indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            self.TitleLBL.text = meal.title
            self.DetailsLBL.text = meal.longdesc
        }
        else if indexPath.section == 0 && indexPath.row == 1 {
            self.TitleLBL.text = "Nutritional Info."
            self.DetailsLBL.text = meal.nutriInfo
        }
        else if indexPath.section == 0 && indexPath.row == 2 {
            self.TitleLBL.text = "Terms & Conditions"
            self.DetailsLBL.text = meal.terms
        }
        else if indexPath.section == 0 && indexPath.row == 3 {
            self.TitleLBL.text = "How it's Work?"
            self.DetailsLBL.text = meal.works
        }
        self.ButtonView.isHidden = true
        self.HideSkeleton()
    }
    
    func setupbannercell(banner: BannerModels, indexPath: IndexPath) {
        self.TitleLBL.text = banner.bannerTitle
        self.DetailsLBL.text = banner.bannerDes
        self.ButtonView.isHidden = true
        self.HideSkeleton()
    }
    
    func setupnotificationcell(data: NotificationModels, indexPath: IndexPath) {
        self.TitleLBL.text = data.title
        self.DetailsLBL.text = data.longdesc
        self.ButtonView.isHidden = true
        self.HideSkeleton()
    }
    
    func setupcouponcell(indexPath: IndexPath) {
        self.TitleLBL.text = randomString(length: 10)
        self.DetailsLBL.text = randomString(length: 50)
        self.ApplyBTN.setTitle("Apply", for: .normal)
        self.ButtonView.isHidden = false
        self.HideSkeleton()
    }
    
//    MARK:- IBAction Methods
//    MARK:-
    
    @IBAction func TappedButtonAction(_ sender: UIButton) {
        if self.ApplyBTN == sender {
            if self.didTappedApplyActionBlock != nil {
                self.didTappedApplyActionBlock!()
            }
        }
    }
    
}
