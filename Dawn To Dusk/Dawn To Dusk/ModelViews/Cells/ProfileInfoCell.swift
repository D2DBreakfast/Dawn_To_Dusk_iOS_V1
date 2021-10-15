//
//  ProfileInfoCell.swift
//  Dawn To Dusk
//
//  Created by Hiren on 04/08/21.
//

import Foundation

class ProfileInfoCell: UITableViewCell {

    @IBOutlet weak var ProfileUserView: UIView!
    
    @IBOutlet weak var UserInfoStack: UIStackView!
    @IBOutlet weak var InfoView: UIView!
    @IBOutlet weak var NameLBL: UILabel!
    @IBOutlet weak var EmailLBL: UILabel!
    @IBOutlet weak var emailValue: UILabel!
    @IBOutlet weak var MobileLBL: UILabel!
    @IBOutlet weak var MobileValue: UILabel!
    @IBOutlet weak var AddressLBL: UILabel!
    @IBOutlet weak var AddressValue: UILabel!
    
    //    MARK:- Variable Defines
    //    MARK:-

    
    //    MARK:- Cell Define
    //    MARK:-
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = TBLBackgroundCOlor
        self.contentView.backgroundColor = TBLBackgroundCOlor
        
        self.ProfileUserView.clipsToBounds = true
        self.ProfileUserView.layer.cornerRadius = 20
        
        self.ProfileUserView.backgroundColor = ModeBG_Color
        
        self.InfoView.backgroundColor = ModeBG_Color
        
        self.NameLBL.text = ""
        self.EmailLBL.text = "Email"
        self.emailValue.text = ""
        self.MobileLBL.text = "Mobile No"
        self.MobileValue.text = ""
        self.AddressLBL.text = "Address"
        self.AddressValue.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //    MARK:- Custom Defines
    //    MARK:-
    
    func ShowSkeleton() {
        self.textLabel!.showAnimatedGradientSkeleton()
        self.detailTextLabel!.showAnimatedGradientSkeleton()
    }
    
    func HideSkeleton() {
        self.textLabel!.hideSkeleton()
        self.detailTextLabel!.hideSkeleton()
    }
    
    func SetupUserInfoCell(IndexPath: IndexPath) {
        let userinfo = SharedUserInfo.shared.GetUserInfodata()
        self.NameLBL.text = userinfo?.fullName
        self.emailValue.text = userinfo?.email
        guard let code = userinfo?.countryCode, let mobile = userinfo?.mobileNo else {
            return
        }
        self.MobileValue.text = String.init(format: "%@ %@", code, mobile)
        self.AddressValue.text = ""
    }
    
    //    MARK:- IBAction Methods Defines
    //    MARK:-
    
}
