//
//  LoginVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 22/07/21.
//

import UIKit
import Foundation
import libPhoneNumber
import SwiftUI

class LoginVC: BaseClassVC {
    
    //    MARK:- IBOutlets
    //    MARK:-

    @IBOutlet weak var BG: UIImageView!
    @IBOutlet weak var mainStack: UIStackView!
    
    @IBOutlet weak var BackBTN: UIButton!
    
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var LogoIMG: UIImageView!
    
    @IBOutlet weak var OptionStack: UIStackView!
    
    @IBOutlet weak var LoginStack: UIView!
    @IBOutlet weak var LoginTitle: UILabel!
    @IBOutlet weak var LoginSepratorLBL: UILabel!
    @IBOutlet weak var LoginOption: UIButton!
    
    @IBOutlet weak var RegisterStack: UIView!
    @IBOutlet weak var RegisterTitle: UILabel!
    @IBOutlet weak var RegisterSepratorLBL: UILabel!
    @IBOutlet weak var RegisterOption: UIButton!
    
    @IBOutlet weak var OptionsView: UIView!
    
    @IBOutlet weak var OptionsSubView: UIView!
    @IBOutlet weak var RegisterView: UIView!
    @IBOutlet weak var NameView: UIView!
    @IBOutlet weak var TXTName: UITextField!
    
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var TXTEmail: UITextField!
    
    @IBOutlet weak var LoginView: UIView!
    @IBOutlet weak var CountryView: UIView!
    @IBOutlet weak var CountryLBL: UILabel!
    @IBOutlet weak var CountryBTN: UIButton!
    
    @IBOutlet weak var ContactNoView: UIView!
    @IBOutlet weak var TXTMobileno: UITextField!
    
    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var NoteLBL: UILabel!
    @IBOutlet weak var GetLoginBTN: UIButton!
    
    //    MARK:- Variables
    //    MARK:-
    
    var countryList = CountryList()
    var SelectedCountry: Country!
    var phoneUtil = NBPhoneNumberUtil.sharedInstance()
    var phoneNumber: NBPhoneNumber!
    var LoginSelected: Int = 100
    
    
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
        
        self.TopView.clipsToBounds = true
        self.TopView.layer.cornerRadius = 25
        
        self.BackBTN.clipsToBounds = true
        self.BackBTN.layer.cornerRadius = 10
        self.BackBTN.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.40)
        
        self.LogoIMG.image = UIImage.init(named: "HomeLogo-1")
        
        self.RegisterView.isHidden = true
        self.LoginView.isHidden = false
        
        if self.LoginSelected == 100 {
            self.RegisterSepratorLBL.backgroundColor = .clear
            self.LoginSepratorLBL.backgroundColor = UIColor.colorWithHexString(hexStr: OrangeTheme)
            self.RegisterView.isHidden = true
            self.LoginView.isHidden = false
            self.LoginSelected = 100
        }
        else {
            self.LoginSepratorLBL.backgroundColor = .clear
            self.RegisterSepratorLBL.backgroundColor = UIColor.colorWithHexString(hexStr: OrangeTheme)
            self.RegisterView.isHidden = false
            self.LoginView.isHidden = false
            self.LoginSelected = 200
        }
        
        self.NameView.backgroundColor = ModeBG_Color
        self.NameView.clipsToBounds = true
        self.NameView.layer.cornerRadius = 10
        
        self.EmailView.backgroundColor = ModeBG_Color
        self.EmailView.clipsToBounds = true
        self.EmailView.layer.cornerRadius = 10
        
        self.CountryView.backgroundColor = ModeBG_Color
        self.CountryView.clipsToBounds = true
        self.CountryView.layer.cornerRadius = 10
        
        self.ContactNoView.backgroundColor = ModeBG_Color
        self.ContactNoView.clipsToBounds = true
        self.ContactNoView.layer.cornerRadius = 10
        
        self.TXTName.placeholder = "Full Name"
        self.TXTEmail.placeholder = "Email"
        self.TXTMobileno.placeholder = "Mobile No"
        
        self.TXTName.textColor = PrimaryText_Color
        self.TXTEmail.textColor = PrimaryText_Color
        self.TXTMobileno.textColor = PrimaryText_Color
        
        self.TXTName.delegate = self
        self.TXTEmail.delegate = self
        self.TXTMobileno.delegate = self
        
        self.CountryLBL.textColor = PrimaryText_Color
        
        self.NoteLBL.textColor = .black
        self.messge_title(phoneno: "")
        
        self.GetLoginBTN.setTitle("Send OTP", for: .normal)
        self.GetLoginBTN.setTitleColor(.white, for: .normal)
        self.GetLoginBTN.clipsToBounds = true
        self.GetLoginBTN.layer.cornerRadius = 10
        self.GetLoginBTN.layer.borderColor = WhiteBorderColor?.cgColor
        self.GetLoginBTN.layer.borderWidth = 1
        self.GetLoginBTN.isEnabled = false
        self.GetLoginBTN.alpha = 0.5
    }
    
    func messge_title(phoneno: String) {
        self.NoteLBL.text = String.init(format: "We will send you a OTP message on your registered mobile number for verification.")
    }
    
    //    MARK:- IBAction Methods
    //    MARK:-
    
    @IBAction func TappedcountryBTN(_ sender: UIButton) {
        self.countryList.delegate = self
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func TappedGetLoginBTN(_ sender: UIButton) {
        let status: Bool? = self.phoneUtil?.isValidNumber(self.phoneNumber)
        if self.SelectedCountry != nil && status! {
            self.showLoaderActivity()
            
            if self.LoginSelected == 100 && self.LoginSepratorLBL.backgroundColor == UIColor.colorWithHexString(hexStr: OrangeTheme) {
                let param = SendotpParamDict.init(mobile: self.TXTMobileno.text, countryCode: self.SelectedCountry.phoneExtension)
                NetworkingRequests.shared.Request_SendOTP(param: param) { (responseObject, status) in
                    if status {
//                        SharedUserInfo.shared.SaveUserInfodata(info: responseObject.loginData!)
                        let vc = OTPVerifyVC(nibName: "OTPVerifyVC", bundle: nil)
                        vc.OTP_Type = .Login
                        vc.mobile = self.TXTMobileno.text!
                        vc.countrycode = self.SelectedCountry.phoneExtension
                        vc.Message = String.init(format: "Please, enter the OTP which was we shared on +%@ %@?", self.SelectedCountry.phoneExtension, self.TXTMobileno.text!)
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
            else {
                self.showLoaderActivity()
                let param = RegisterParamDict.init(fullname: self.TXTName.text, email: self.TXTEmail.text, mobile: self.TXTMobileno.text, countryCode: self.SelectedCountry.phoneExtension)
                NetworkingRequests.shared.Request_RegisterUser(param: param) { (responseObject, status) in
                    if status && responseObject.status && responseObject.statusCode == 200 {
                        SharedUserInfo.shared.SaveUserInfodata(info: responseObject.loginData!)
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
    
    @IBAction func TappedOptionBTN(_ sender: UIButton) {
        if sender == self.LoginOption {
            self.LoginSepratorLBL.backgroundColor = UIColor.colorWithHexString(hexStr: OrangeTheme)
            self.RegisterSepratorLBL.backgroundColor = .clear
            self.RegisterView.isHidden = true
            self.LoginView.isHidden = false
            self.LoginSelected = 100
        }
        else {
            self.RegisterSepratorLBL.backgroundColor = UIColor.colorWithHexString(hexStr: OrangeTheme)
            self.LoginSepratorLBL.backgroundColor = .clear
            self.RegisterView.isHidden = false
            self.LoginView.isHidden = false
            self.LoginSelected = 200
        }
    }
    
    @IBAction override func TappedBackBTN(_ sender: UIButton) {
        if isModal {
            self.dismiss(animated: true, completion:nil)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

//MARK:- CountryListing Delegates
//MARK:-

extension LoginVC: CountryListDelegate {
 
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
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        self.CountryLBL.text = String.init(format: " %@  +%@", country.flag!, country.phoneExtension)
    }
    
}

//MARK:- Textfield Delegates
extension LoginVC: UITextFieldDelegate {
    
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
            if textField == self.TXTMobileno {
                self.TXTMobileno.keyboardType = .numberPad
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        if textField == TXTMobileno {
            do {
                self.phoneNumber = try phoneUtil!.parse(newString as String, defaultRegion: self.SelectedCountry.countryCode)
                print(newString)
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
            self.messge_title(phoneno: newString as String)

            let status: Bool? = self.phoneUtil?.isValidNumber(self.phoneNumber)
            if status! {
                self.GetLoginBTN.isEnabled = true
                self.GetLoginBTN.alpha = 1.0
                self.ContactNoView.layer.borderColor = ModeBorder_Color?.cgColor
            }
            else {
                self.GetLoginBTN.isEnabled = false
                self.GetLoginBTN.alpha = 0.5
                self.ContactNoView.layer.borderColor = UIColor.red.cgColor
            }
        }
        else if textField == TXTName {
            if self.TXTName.text!.count >= 1 {
                self.NameView.layer.borderColor = ModeBorder_Color?.cgColor
            }
            else {
                self.NameView.layer.borderColor = UIColor.red.cgColor
            }
        }
        else {
            if AppUtillity.shared.validateEmail(enteredEmail: self.TXTEmail.text!) {
                self.EmailView.layer.borderColor = ModeBorder_Color?.cgColor
            }
            else {
                self.EmailView.layer.borderColor = UIColor.red.cgColor
            }
        }
        
        let status: Bool? = self.phoneUtil?.isValidNumber(self.phoneNumber)
        if self.LoginSelected == 100 {
            if status! {
                self.GetLoginBTN.isEnabled = true
                self.GetLoginBTN.alpha = 1.0
            }
            else {
                self.GetLoginBTN.isEnabled = false
                self.GetLoginBTN.alpha = 0.5
            }
        }
        else {
            if status! && self.TXTName.text!.count >= 0 && AppUtillity.shared.validateEmail(enteredEmail: self.TXTEmail.text!) {
                self.GetLoginBTN.isEnabled = true
                self.GetLoginBTN.alpha = 1.0
            }
            else {
                self.GetLoginBTN.isEnabled = false
                self.GetLoginBTN.alpha = 0.5
            }
        }
        return true
    }
    
}
