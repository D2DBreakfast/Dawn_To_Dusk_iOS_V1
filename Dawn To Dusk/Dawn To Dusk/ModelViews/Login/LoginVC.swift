//
//  LoginVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 22/07/21.
//

import UIKit
import Foundation
import libPhoneNumber

class LoginVC: BaseClassVC {
    
    //    MARK:- IBOutlets
    //    MARK:-
    
    @IBOutlet weak var BackBTN: UIButton!
    
    @IBOutlet weak var LogoIMG: UIImageView!
    @IBOutlet weak var TitleLBL: UILabel!
    
    @IBOutlet weak var CountryView: UIView!
    @IBOutlet weak var CountryLBL: UILabel!
    @IBOutlet weak var CountryBTN: UIButton!
    
    @IBOutlet weak var ContactNoView: UIView!
    @IBOutlet weak var TXTMobileno: UITextField!
    
    @IBOutlet weak var RegisterBTN: UIButton!
    @IBOutlet weak var GetLoginBTN: UIButton!
    
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
        
        self.BackBTN.clipsToBounds = true
        self.BackBTN.layer.cornerRadius = 10
        self.BackBTN.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.40)
        
        self.LogoIMG.image = UIImage.init(named: "HomeLogo")
        
        self.TitleLBL.text = "Login"
        self.TitleLBL.textColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        
        self.CountryLBL.textColor = PrimaryText_Color
        self.CountryView.clipsToBounds = true
        self.CountryView.layer.cornerRadius = 10
        self.CountryView.layer.borderColor = ModeBorder_Color?.cgColor
        self.CountryView.layer.borderWidth = 1
        
        self.TXTMobileno.delegate = self
        
        self.ContactNoView.clipsToBounds = true
        self.ContactNoView.layer.cornerRadius = 10
        self.ContactNoView.layer.borderColor = ModeBorder_Color?.cgColor
        self.ContactNoView.layer.borderWidth = 1
        self.TXTMobileno.textColor = PrimaryText_Color
        
        self.GetLoginBTN.setTitleColor(.white, for: .normal)
        self.GetLoginBTN.clipsToBounds = true
        self.GetLoginBTN.layer.cornerRadius = 10
        self.GetLoginBTN.layer.borderColor = WhiteBorderColor?.cgColor
        self.GetLoginBTN.layer.borderWidth = 1
        self.GetLoginBTN.isEnabled = false
        self.GetLoginBTN.alpha = 0.5
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
            let param = SendotpParamDict.init(mobile: self.TXTMobileno.text, countryCode: self.SelectedCountry.phoneExtension)
            
            NetworkingRequests.shared.Request_SendOTP(param: param) { (responseObject, status) in
                if status {
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
    }
    
    @IBAction func TappedRegisterBTN(_ sender: UIButton) {
        let vc = RegisterVC(nibName: "RegisterVC", bundle: nil)
         self.navigationController!.pushViewController(vc, animated: true)
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
        self.CountryLBL.text = String.init(format: "%@ +%@", country.flag!, country.phoneExtension)
    }
    
}

//MARK:- Textfield Delegates
extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField)  {
        self.TXTMobileno.becomeFirstResponder()
        self.TXTMobileno.returnKeyType = .done
        if textField == self.TXTMobileno {
            self.TXTMobileno.keyboardType = .numberPad
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == TXTMobileno {
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            do {
                self.phoneNumber = try phoneUtil!.parse(newString as String, defaultRegion: self.SelectedCountry.countryCode)
                print(newString)
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
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
        return true
    }
    
}
