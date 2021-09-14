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
        self.backgroundColor = TBLBackgroundCOlor
        self.contentView.backgroundColor = TBLBackgroundCOlor
        
        self.MainStack.backgroundColor = ModeBG_Color
        
        self.MainStack.clipsToBounds = true
        self.MainStack.layer.cornerRadius = 10
        
        self.CreditCardView.clipsToBounds = true
        self.CreditCardView.layer.cornerRadius = 10
        
        self.BankinfoView.clipsToBounds = true
        self.BankinfoView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func SetupPaymentmode(indexPath: IndexPath, obj: PaymentModePayment) {
        if obj.paymentType.uppercased() == "Card".uppercased() {
            self.CreditCardView.isHidden = false
            self.BankinfoView.isHidden = true
            
            self.CreditCardView.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.4)
            
            self.UsernameLBL.text = obj.card.name
            self.CardNoLBL.text = obj.card.cardno
            self.ValidyearLBL.text = obj.card.month + "/" + obj.card.year
        }
        else {
            self.BankinfoView.isHidden = false
            self.CreditCardView.isHidden = true
            self.Bank_IMG.tintColor = UIColor.white
            self.BankinfoView.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.4)
            self.NameLBL.text = obj.bank.name
            self.AccountLBL.text = obj.bank.accountno
            self.IFCSLBL.text = obj.bank.ifcsCode
            self.BankLBL.text = obj.bank.bankName
        }
    }
    
    //    MARK:- IBAction Defines
    //    MARK:-
    
}
