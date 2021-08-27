//
//  RegisterVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 23/07/21.
//

import UIKit
import Foundation
import libPhoneNumber

class RegisterVC: BaseClassVC {
    
    //    MARK:- IBOutlets
    //    MARK:-
    
    @IBOutlet weak var Scroll: TPKeyboardAvoidingScrollView!
    
    @IBOutlet weak var LogoIMG: UIImageView!
    @IBOutlet weak var TitleLBL: UILabel!
    
    @IBOutlet weak var NameView: UIView!
    @IBOutlet weak var TXTName: UITextField!
    
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var TXTEmail: UITextField!
    
    @IBOutlet weak var CountryView: UIView!
    @IBOutlet weak var CountryLBL: UILabel!
    @IBOutlet weak var CountryBTN: UIButton!
    
    @IBOutlet weak var ContactNoView: UIView!
    @IBOutlet weak var TXTMobileno: UITextField!
    
    @IBOutlet weak var BackBTN: UIButton!
    @IBOutlet weak var Back2BTN: UIButton!
    @IBOutlet weak var GetRegisterBTN: UIButton!
    
    //    MARK:- Variables
    //    MARK:-
    
    var countryList = CountryList()
    var SelectedCountry: Country!
    var phoneUtil = NBPhoneNumberUtil.sharedInstance()
    var phoneNumber: NBPhoneNumber!
    
    //    MARK:- View Classes
    //    MARK:-
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        toogleTabbar(hide: true)
        self.setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getdefaultCountry()
    }
    
    //    MARK:- User's Custome Methods
    //    MARK:-
    
    override func setupUI() {
        
        self.view.backgroundColor = ModeBG_Color
        
        self.LogoIMG.image = UIImage.init(named: "HomeLogo")
        
        self.TitleLBL.text = "Register"
        self.TitleLBL.textColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        
        self.BackBTN.clipsToBounds = true
        self.BackBTN.layer.cornerRadius = 10
        self.Back2BTN.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.40)
        
        self.NameView.clipsToBounds = true
        self.NameView.layer.cornerRadius = 10
        self.NameView.layer.borderColor = ModeBorder_Color?.cgColor
        self.NameView.layer.borderWidth = 1
        
        self.EmailView.clipsToBounds = true
        self.EmailView.layer.cornerRadius = 10
        self.EmailView.layer.borderColor = ModeBorder_Color?.cgColor
        self.EmailView.layer.borderWidth = 1
        
        self.CountryLBL.textColor = PrimaryText_Color
        self.CountryView.clipsToBounds = true
        self.CountryView.layer.cornerRadius = 10
        self.CountryView.layer.borderColor = ModeBorder_Color?.cgColor
        self.CountryView.layer.borderWidth = 1
        
        self.TXTName.delegate = self
        self.TXTEmail.delegate = self
        self.TXTMobileno.delegate = self
        
        self.ContactNoView.clipsToBounds = true
        self.ContactNoView.layer.cornerRadius = 10
        self.ContactNoView.layer.borderColor = ModeBorder_Color?.cgColor
        self.ContactNoView.layer.borderWidth = 1
        self.TXTMobileno.textColor = PrimaryText_Color
        
        self.GetRegisterBTN.setTitleColor(.white, for: .normal)
        self.GetRegisterBTN.clipsToBounds = true
        self.GetRegisterBTN.layer.cornerRadius = 10
        self.GetRegisterBTN.layer.borderColor = WhiteBorderColor?.cgColor
        self.GetRegisterBTN.layer.borderWidth = 1
        
        let status: Bool? = self.phoneUtil?.isValidNumber(phoneNumber)
        if status! && self.TXTName.text!.count >= 0 && AppUtillity.shared.validateEmail(enteredEmail: self.TXTEmail.text!) {
            self.GetRegisterBTN.isEnabled = true
            self.GetRegisterBTN.alpha = 1.0
        }
        else {
            self.GetRegisterBTN.isEnabled = false
            self.GetRegisterBTN.alpha = 0.5
        }
        
    }
    
    //    MARK:- IBAction Methods
    //    MARK:-
    
    @IBAction func TappedcountryBTN(_ sender: UIButton) {
        self.countryList.delegate = self
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
    
    @IBAction override func TappedBackBTN(_ sender: UIButton) {
        if isModal {
            self.dismiss(animated: true, completion:nil)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func TappedGetRegisterBTN(_ sender: UIButton) {
        let status: Bool? = self.phoneUtil?.isValidNumber(self.phoneNumber)
        if status! && self.TXTName.text!.count >= 0 && AppUtillity.shared.validateEmail(enteredEmail: self.TXTEmail.text!) {
            let status: Bool? = self.phoneUtil?.isValidNumber(self.phoneNumber)
            if self.SelectedCountry != nil && status! {
                self.showLoaderActivity()
                let param = RegisterParamDict.init(fullname: self.TXTName.text, email: self.TXTEmail.text, mobile: self.TXTMobileno.text, countryCode: self.SelectedCountry.phoneExtension)
                NetworkingRequests.shared.Request_RegisterUser(param: param) { (responseObject, status) in
                    if status {
                        let vc = OTPVerifyVC(nibName: "OTPVerifyVC", bundle: nil)
                        vc.OTP_Type = .Register
                        vc.Message = String.init(format: "Please, enter the OTP which was we shared on +%@ %@?", self.SelectedCountry.phoneExtension, self.TXTMobileno.text!)
                        vc.full_name = self.TXTName.text!
                        vc.mobile = self.TXTMobileno.text!
                        vc.email = self.TXTEmail.text!
                        vc.countrycode = self.SelectedCountry.phoneExtension
                        self.navigationController!.pushViewController(vc, animated: true)
                    }
                    else {
                        self.navigationController?.view.makeToast(responseObject.message!, duration: 3.0, position: .top)
                    }
                    self.hideLoaderActivity()
                } onFailure: { message in
                    if IsInternetIssue(message: message) {
                        
                    }
                    else {
                        self.navigationController?.view.makeToast(message, duration: 3.0, position: .top)
                        self.hideLoaderActivity()
                    }
                }
                
            }
        }
    }
    
}

//MARK:- CountryListing Delegates
//MARK:-

extension RegisterVC: CountryListDelegate {
    
    func getdefaultCountry() {
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            let countries = Countries()
            let countryList = countries.countries
            print(countryCode)
            let country = countryList.filter { COU in
                COU.countryCode.uppercased().contains("IN")
//                COU.countryCode.uppercased().contains(countryCode.uppercased())
            }
            self.SelectedCountry = country.first
            self.selectedCountry(country: country.first!)
        }
    }
    
    func selectedCountry(country: Country) {
        self.SelectedCountry = country
        do {
            let phoneNumber: NBPhoneNumber = try phoneUtil!.parse(self.TXTMobileno.text, defaultRegion: self.SelectedCountry.countryCode)
            let formattedString: String = try phoneUtil!.format(phoneNumber, numberFormat: .E164)
            
            NSLog("[%@]", formattedString)
            
            let status: Bool? = self.phoneUtil?.isValidNumber(phoneNumber)
            if status! && self.TXTName.text!.count >= 0 && AppUtillity.shared.validateEmail(enteredEmail: self.TXTEmail.text!) {
                self.GetRegisterBTN.isEnabled = true
                self.GetRegisterBTN.alpha = 1.0
            }
            else {
                self.GetRegisterBTN.isEnabled = false
                self.GetRegisterBTN.alpha = 0.5
            }
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        self.CountryLBL.text = String.init(format: "%@ +%@", country.flag!, country.phoneExtension)
        
    }
    
}

//MARK:- Textfield Delegates
extension RegisterVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField)  {
        if textField == self.TXTName {
            self.TXTName.becomeFirstResponder()
            self.TXTName.returnKeyType = .next
            self.TXTName.keyboardType = .default
        }
        else if textField == self.TXTEmail {
            self.TXTEmail.becomeFirstResponder()
            self.TXTEmail.returnKeyType = .next
            self.TXTEmail.keyboardType = .default
        }
        else {
            self.TXTMobileno.becomeFirstResponder()
            self.TXTMobileno.returnKeyType = .done
            self.TXTMobileno.keyboardType = .numberPad
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        if textField == self.TXTName {
            if self.TXTName.text!.count >= 1 {
                self.NameView.layer.borderColor = ModeBorder_Color?.cgColor
            }
            else {
                self.NameView.layer.borderColor = UIColor.red.cgColor
            }
        }
        else if textField == self.TXTEmail {
            if AppUtillity.shared.validateEmail(enteredEmail: self.TXTEmail.text!) {
                self.EmailView.layer.borderColor = ModeBorder_Color?.cgColor
            }
            else {
                self.EmailView.layer.borderColor = UIColor.red.cgColor
            }
        }
        else {
            do {
                self.phoneNumber = try phoneUtil!.parse(newString as String, defaultRegion: self.SelectedCountry.countryCode)
                print(newString)
                if ((self.phoneUtil?.isValidNumber(self.phoneNumber)) != nil) {
                    self.ContactNoView.layer.borderColor = ModeBorder_Color?.cgColor
                }
                else {
                    self.ContactNoView.layer.borderColor = UIColor.red.cgColor
                }
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        let status: Bool? = self.phoneUtil?.isValidNumber(self.phoneNumber)
        if status! && self.TXTName.text!.count >= 0 && AppUtillity.shared.validateEmail(enteredEmail: self.TXTEmail.text!) {
            self.GetRegisterBTN.isEnabled = true
            self.GetRegisterBTN.alpha = 1.0
        }
        else {
            self.GetRegisterBTN.isEnabled = false
            self.GetRegisterBTN.alpha = 0.5
        }
        return true
    }
    
}

