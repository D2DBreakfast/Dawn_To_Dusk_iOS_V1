//
//  UserOptionCell.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 04/08/21.
//

import UIKit

class UserOptionCell: UITableViewCell {
    
    @IBOutlet weak var ProfileOptionView: UIView!
    @IBOutlet weak var OptionView: UIView!
    @IBOutlet weak var OptionIcon: UIImageView!
    @IBOutlet weak var OptionTitleLBL: UILabel!
    
    @IBOutlet weak var LoginOptionStack: UIStackView!
    @IBOutlet weak var RegisterBTN: UIButton!
    @IBOutlet weak var LoginBTN: UIButton!
    
    //    MARK:- Variable Defines
    //    MARK:-
    
    var didTappedAction1Block: (()->())?
    var didTappedAction2Block: (()->())?
    
    //    MARK:- Cell Define
    //    MARK:-
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = TBLBackgroundCOlor
        self.contentView.backgroundColor = TBLBackgroundCOlor
        
        self.OptionView.backgroundColor = ModeBG_Color
        
        self.OptionView.isHidden = false
        self.LoginOptionStack.isHidden = true
         
        self.ProfileOptionView.clipsToBounds = true
        self.ProfileOptionView.layer.cornerRadius = 20
        self.ProfileOptionView.backgroundColor = ModeBG_Color
        
        self.RegisterBTN.GetThemeButtonwithBorder()
        self.LoginBTN.GetThemeButtonwithBorder()
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
    
    func SetupOptionCell(image: String, title: String) {
        self.OptionIcon.contentMode = .scaleAspectFit
        self.OptionTitleLBL.text = ""
        self.OptionIcon.image = UIImage.init(named: image)
        self.OptionIcon.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.OptionTitleLBL.text = title
        self.OptionView.isHidden = false
        self.LoginOptionStack.isHidden = true
    }
    
    func setupSession() {
        self.LoginBTN.setTitle("Login", for: .normal)
        self.RegisterBTN.setTitle("Register", for: .normal)
        self.OptionView.isHidden = true
        self.LoginOptionStack.isHidden = false
    }
    
    func setupPayment() {
        self.LoginBTN.setTitle("Bank", for: .normal)
        self.RegisterBTN.setTitle("Cards", for: .normal)
        self.OptionView.isHidden = true
        self.LoginOptionStack.isHidden = false
    }
    
    func setupDownloadInvoice() {
        self.backgroundColor = ModeBG_Color
        self.contentView.backgroundColor = ModeBG_Color
        self.LoginBTN.setTitle("Download Invoice", for: .normal)
        self.RegisterBTN.setTitle("Mail Invoice", for: .normal)
        self.OptionView.isHidden = true
        self.LoginOptionStack.isHidden = false
    }
    
    //    MARK:- IBAction Methods Defines
    //    MARK:-
    
    @IBAction func TappedButton(_ sender: UIButton) {
        if sender == self.RegisterBTN {
            if self.didTappedAction1Block != nil {
                self.didTappedAction1Block!()
            }
        }
        else {
            if self.didTappedAction2Block != nil {
                self.didTappedAction2Block!()
            }
        }
    }
    
}
