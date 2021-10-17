//
//  HomeBannerCell.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 28/07/21.
//

import UIKit

class HomeBannerCell: UITableViewCell {
    
    //    MARK:- IBOutlets
    //    MARK:-
    @IBOutlet weak var containview: UIView!
    @IBOutlet weak var bannerIMG: UIImageView!
    
    //    MARK:- Variable Defines
    //    MARK:-
    
    //    MARK:- Awake methods
    //    MARK:-
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ModeBG_Color
        self.contentView.backgroundColor = ModeBG_Color
        self.containview.clipsToBounds = true
        self.containview.layer.cornerRadius = 15
        self.bannerIMG.clipsToBounds = true
        self.bannerIMG.layer.cornerRadius = 15
        self.containview.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.3)
        self.ShowSkeleton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func ShowSkeleton() {
        self.bannerIMG.showAnimatedGradientSkeleton()

    }
    
    func HideSkeleton() {
        self.bannerIMG.hideSkeleton()
    }
    
    //    MARK:- Custom Defines
    //    MARK:-
    
    func setupcell(food: MealsModels) {
//        self.bannerIMG.downloadedFrom(url: URL.init(string: food.itemimage!)!)
        self.bannerIMG.image = UIImage.init(named: "bannarimage")
        self.bannerIMG.contentMode = .scaleToFill
        self.HideSkeleton()
    }
    
    func setupBannercell(banner: BannerModels) {
//        self.bannerIMG.downloadedFrom(url: URL.init(string: banner.bannerImage!)!)
        self.bannerIMG.image = UIImage.init(named: "bannarimage")
        self.bannerIMG.contentMode = .scaleToFill
        self.HideSkeleton()
    }
    
    //    MARK:- IBAction Methods Defines
    //    MARK:-
    
}
