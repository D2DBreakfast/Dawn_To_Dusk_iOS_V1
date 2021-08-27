//
//  AddPaymentVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 19/08/21.
//

import UIKit

class AddPaymentVC: BaseClassVC {

    //    MARK:- Varaible Definces
    //    MARK:-
    
    @IBOutlet weak var ScrollView: TPKeyboardAvoidingScrollView!
    
    @IBOutlet weak var MainStack: UIStackView!
    
    @IBOutlet weak var CardStack: UIStackView!
    @IBOutlet weak var CardNameView: UIView!
    @IBOutlet weak var TXTCardName: UITextField!
    @IBOutlet weak var CardNoView: UIView!
    @IBOutlet weak var TXTCardNo: UITextField!
    @IBOutlet weak var CVVView: UIView!
    @IBOutlet weak var TXTCVV: UITextField!
    @IBOutlet weak var ValidView: UIView!
    @IBOutlet weak var TXTValid: UITextField!
    @IBOutlet weak var AddCardBTN: UIButton!
    
    @IBOutlet weak var BankStack: UIStackView!
    @IBOutlet weak var NameView: UIView!
    @IBOutlet weak var TXTName: UITextField!
    @IBOutlet weak var BankNameView: UIView!
    @IBOutlet weak var TXTbankName: UITextField!
    @IBOutlet weak var AccountView: UIView!
    @IBOutlet weak var TXTAccount: UITextField!
    @IBOutlet weak var ConfirmView: UIView!
    @IBOutlet weak var TXTConfirm: UITextField!
    @IBOutlet weak var IFCSView: UIView!
    @IBOutlet weak var TXTIFCS: UITextField!
    @IBOutlet weak var CodeView: UIView!
    @IBOutlet weak var TXTCode: UITextField!
    @IBOutlet weak var AddBankBTN: UIButton!
    
    //    MARK:- View Cycle
    //    MARK:-
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toogleTabbar(hide: true)
        self.view.backgroundColor = TBLBackgroundCOlor
        self.ScrollView.backgroundColor = TBLBackgroundCOlor
        self.MainStack.backgroundColor = TBLBackgroundCOlor
        self.setupUI()
        self.SetupNavBarforback()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //    MARK:- User Define
    //    MARK:-
    
    override func setupUI() {
        
        self.title = "Add payments"
        
        self.CardStack.backgroundColor = .clear
        
        self.CardNameView.clipsToBounds = true
        self.CardNameView.backgroundColor = ModeBG_Color
        self.CardNameView.layer.cornerRadius = 10
        
        self.TXTCardName.placeholder = "Full Name"
        
        self.CardNoView.clipsToBounds = true
        self.CardNoView.backgroundColor = ModeBG_Color
        self.CardNoView.layer.cornerRadius = 10
        
        self.TXTCardNo.placeholder = "Card No"
        
        self.CVVView.clipsToBounds = true
        self.CVVView.backgroundColor = ModeBG_Color
        self.CVVView.layer.cornerRadius = 10
        
        self.TXTCVV.placeholder = "CVV"
        
        self.ValidView.clipsToBounds = true
        self.ValidView.backgroundColor = ModeBG_Color
        self.ValidView.layer.cornerRadius = 10
        
        self.TXTValid.placeholder = "Month / Year"
        
        self.AddCardBTN.GetThemeButtonwithBorder()
        self.AddCardBTN.setTitle("Add Card", for: .normal)
        self.AddCardBTN.clipsToBounds = true
        self.AddCardBTN.layer.cornerRadius = 10
        self.AddCardBTN.alpha = 0.5
        self.AddCardBTN.isEnabled = false
        
        self.BankStack.backgroundColor = .clear
        
        self.NameView.clipsToBounds = true
        self.NameView.backgroundColor = ModeBG_Color
        self.NameView.layer.cornerRadius = 10
        
        self.TXTName.placeholder = "Full Name"
        
        self.BankNameView.clipsToBounds = true
        self.BankNameView.backgroundColor = ModeBG_Color
        self.BankNameView.layer.cornerRadius = 10
        
        self.TXTbankName.placeholder = "Bank Name"
        
        self.AccountView.clipsToBounds = true
        self.AccountView.backgroundColor = ModeBG_Color
        self.AccountView.layer.cornerRadius = 10
        
        self.TXTAccount.placeholder = "Account No"
        
        self.ConfirmView.clipsToBounds = true
        self.ConfirmView.backgroundColor = ModeBG_Color
        self.ConfirmView.layer.cornerRadius = 10
        
        self.TXTConfirm.placeholder = "Confirm Account No"
        
        self.IFCSView.clipsToBounds = true
        self.IFCSView.backgroundColor = ModeBG_Color
        self.IFCSView.layer.cornerRadius = 10
        
        self.TXTIFCS.placeholder = "IFCS Code"
        
        self.CodeView.clipsToBounds = true
        self.CodeView.backgroundColor = ModeBG_Color
        self.CodeView.layer.cornerRadius = 10
        
        self.TXTCode.placeholder = "Code"
        
        self.AddBankBTN.GetThemeButtonwithBorder()
        self.AddBankBTN.setTitle("Add Bank", for: .normal)
        self.AddBankBTN.clipsToBounds = true
        self.AddBankBTN.layer.cornerRadius = 10
        self.AddBankBTN.alpha = 0.5
        self.AddBankBTN.isEnabled = false
        
    }
    
    //    MARK:- IBActions Methods
    //    MARK:-
    
    @IBAction func TappedAddButton(_ sender: UIButton) {
        if sender == self.AddCardBTN {
            
        }
        else {
            
        }
    }
    
}

//MARK:- Textfield Delegates
//MARK:-

extension AddPaymentVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.TXTCardName {
            self.TXTCardName.keyboardType = .default
            self.TXTCardName.returnKeyType = .next
        }
        else if textField == self.TXTCardNo {
            self.TXTCardNo.keyboardType = .numberPad
            self.TXTCardNo.returnKeyType = .next
        }
        else if textField == self.TXTCVV {
            self.TXTCVV.keyboardType = .numberPad
            self.TXTCVV.returnKeyType = .next
        }
        else if textField == self.TXTValid {
            self.TXTValid.keyboardType = .numbersAndPunctuation
            self.TXTValid.returnKeyType = .next
        }
        else if textField == self.TXTName {
            self.TXTName.keyboardType = .default
            self.TXTName.returnKeyType = .next
        }
        else if textField == self.TXTbankName {
            self.TXTbankName.keyboardType = .default
            self.TXTbankName.returnKeyType = .next
        }
        else if textField == self.TXTAccount {
            self.TXTAccount.keyboardType = .numberPad
            self.TXTAccount.returnKeyType = .next
        }
        else if textField == self.TXTConfirm {
            self.TXTConfirm.keyboardType = .numberPad
            self.TXTConfirm.returnKeyType = .next
        }
        else if textField == self.TXTIFCS {
            self.TXTIFCS.keyboardType = .default
            self.TXTIFCS.returnKeyType = .next
        }
        else if textField == self.TXTCode {
            self.TXTCode.keyboardType = .default
            self.TXTCode.returnKeyType = .next
        }
        else {
            
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        print(newString)
        if textField == self.TXTCardName {
            
        }
        else if textField == self.TXTCardNo {
            
        }
        else if textField == self.TXTCVV {
            
        }
        else if textField == self.TXTValid {
            
        }
        else if textField == self.TXTName {
            
        }
        else if textField == self.TXTbankName {
            
        }
        else if textField == self.TXTAccount {
            
        }
        else if textField == self.TXTConfirm {
            
        }
        else if textField == self.TXTIFCS {
            
        }
        else if textField == self.TXTCode {
            
        }
        else {
            
        }
        return true
    }
    
}
