//
//  OTPVerifyVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 23/07/21.
//

import UIKit

enum ModeType {
    case Login, Update, Register
}

class OTPVerifyVC: BaseClassVC {
    
    //    MARK:- IBOutlets
    //    MARK:-
    
    @IBOutlet weak var BGimg: UIImageView!
    
    @IBOutlet weak var LogoIMG: UIImageView!
    @IBOutlet weak var TitleLBL: UILabel!
    
    @IBOutlet weak var MessageLBL: UILabel!
    
    @IBOutlet weak var otpTextFieldView: OTPFieldView!
    
    @IBOutlet weak var BackBTN: UIButton!
    @IBOutlet weak var ResendBTN: UIButton!
    @IBOutlet weak var VerifyBTN: UIButton!
    
    //    MARK:- Variables
    //    MARK:-
    
    var OTP_Type: ModeType!
    var Message: String = ""
    var countdown = 60
    var OTPtimer: Timer!
    var EnteredOTP: String = ""
    
    var countrycode: String = ""
    var full_name: String = ""
    var email: String = ""
    var mobile: String = ""
    let OTP_count: Int = 6
    
    //    MARK:- View Classes
    //    MARK:-
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //    MARK:- User's Custome Methods
    //    MARK:-
    
    func setupOtpView(){
        self.otpTextFieldView.fieldsCount = self.OTP_count
        self.otpTextFieldView.fieldBorderWidth = 2
        self.otpTextFieldView.defaultBorderColor = UIColor.black
        self.otpTextFieldView.filledBorderColor = UIColor.colorWithHexString(hexStr: OrangeTheme)
        self.otpTextFieldView.cursorColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.otpTextFieldView.displayType = .roundedCorner
        self.otpTextFieldView.fieldSize = 40
        self.otpTextFieldView.separatorSpace = 15
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
    }
    
    override func setupUI() {
        
        self.view.backgroundColor = ModeBG_Color
        
        self.BackBTN.clipsToBounds = true
        self.BackBTN.layer.cornerRadius = 10
        self.BackBTN.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.40)
        
        self.TitleLBL.text = "OTP Verify"
        self.TitleLBL.textColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        
        self.MessageLBL.text = self.Message
        
        self.VerifyBTN.setTitleColor(.white, for: .normal)
        self.VerifyBTN.clipsToBounds = true
        self.VerifyBTN.layer.cornerRadius = 10
        self.VerifyBTN.layer.borderColor = WhiteBorderColor?.cgColor
        self.VerifyBTN.layer.borderWidth = 1
        self.VerifyBTN.isEnabled = false
        self.VerifyBTN.alpha = 0.5
        self.VerifyBTN.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        
        self.ResendBTN.setTitleColor(.white, for: .normal)
        self.ResendBTN.setTitle(timeFormatted(self.countdown), for: .normal)
        self.ResendBTN.isEnabled = false
        self.ResendBTN.alpha = 0.5
        
        self.BGimg.isHidden = (self.OTP_Type == .Login || self.OTP_Type == .Register) ? false : true
        self.setupOtpView()
        
        self.OTPtimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatetimers), userInfo: nil, repeats: true)
    }
    
    @objc func updatetimers() {
        if self.countdown != 0 {
            self.ResendBTN.setTitle(timeFormatted(self.countdown), for: .normal)
            self.ResendBTN.isEnabled = false
            self.ResendBTN.alpha = 0.5
            self.countdown -= 1
        } else {
            self.OTPtimer = nil
            self.ResendBTN.setTitle("Resend OTP", for: .normal)
            self.ResendBTN.isEnabled = true
            self.ResendBTN.alpha = 1.0
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "Resend OTP %02d:%02d", minutes, seconds)
    }
    
    //    MARK:- IBAction Methods
    //    MARK:-
    
    @IBAction func TappedResendBTN(_ sender: UIButton) {
        self.countdown = 60
        self.OTPtimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatetimers), userInfo: nil, repeats: true)
    }
    
    @IBAction func TappedVerifyBTN(_ sender: UIButton) {
        if self.EnteredOTP.count == self.OTP_count {
            self.showLoaderActivity()
            let param = OTPcodeParamDict.init(code: self.EnteredOTP, mobile: self.mobile, countryCode: self.countrycode)
            NetworkingRequests.shared.Request_UserVerifyOTP(param: param) { (responseObject, status) in
                if status && ((responseObject.data?.accessToken?.IsStrEmpty()) != nil) {
                    SharedUserInfo.shared.SaveUserInfodata(info: responseObject.data!)
                    let vc = HomeDashboardVC()
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
        if OTP_Type == .Login {
            
        }
        else {
            
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

//    MARK:- OTP Delegate Methods
//    MARK:-

extension OTPVerifyVC: OTPFieldViewDelegate {
    
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        if self.EnteredOTP.count == self.OTP_count {
            self.VerifyBTN.isEnabled = true
            self.VerifyBTN.alpha = 1.0
        }
        else {
            self.VerifyBTN.isEnabled = false
            self.VerifyBTN.alpha = 0.5
        }
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        if index == self.OTP_count - 1 {
            self.VerifyBTN.isEnabled = true
            self.VerifyBTN.alpha = 1.0
        }
        else {
            self.VerifyBTN.isEnabled = false
            self.VerifyBTN.alpha = 0.5
        }
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
        self.EnteredOTP = otpString
        
        if self.EnteredOTP.count == self.OTP_count {
            self.VerifyBTN.isEnabled = true
            self.VerifyBTN.alpha = 1.0
        }
        else {
            self.VerifyBTN.isEnabled = false
            self.VerifyBTN.alpha = 0.5
        }
    }
    
}
