//
//  PaymentModeCell.swift
//  Dawn To Dusk
//
//  Created by Hiren on 18/08/21.
//

import UIKit

class PaymentModeCell: UITableViewCell {

    //    MARK:- IBOutlet Defines
    //    MARK:-
    
    @IBOutlet weak var MainStack: UIStackView!
    
    @IBOutlet weak var CreditCardView: UIView!
    @IBOutlet weak var CardType_IMG: UIImageView!
    @IBOutlet weak var CardChipIMG: UIImageView!
    @IBOutlet weak var CardNoLBL: UILabel!
    @IBOutlet weak var UserLBL: UILabel!
    @IBOutlet weak var UsernameLBL: UILabel!
    @IBOutlet weak var validLBL: UILabel!
    @IBOutlet weak var ValidyearLBL: UILabel!
    
    @IBOutlet weak var BankinfoView: UIView!
    @IBOutlet weak var Bank_IMG: UIImageView!
    @IBOutlet weak var NameLBL: UILabel!
    @IBOutlet weak var AccountLBL: UILabel!
    @IBOutlet weak var IFCSLBL: UILabel!
    @IBOutlet weak var BankLBL: UILabel!
    
    //    MARK:- Variable Defines
    //    MARK:-
    
    //    MARK:- Custome methods Defines
    //    MARK:-
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ModeBG_Color
        self.contentView.backgroundColor = ModeBG_Color
        
        self.MainStack.backgroundColor = ModeBG_Color
        
        self.CreditCardView.clipsToBounds = true
        self.CreditCardView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func SetupCreditcard() {
        
        self.CreditCardView.isHidden = false
        self.BankinfoView.isHidden = true
        
        self.CreditCardView.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        
        self.CreditCardView.backgroundColor = ModeBG_Color
        self.UserLBL.text = "CARD HOLDER"
        self.validLBL.text = "VALID TILL"
        
    }
    
    func Setupbankdetail() {
        
        self.BankinfoView.isHidden = false
        self.CreditCardView.isHidden = true
        
    }
    
    //    MARK:- IBAction Defines
    //    MARK:-
    
}
