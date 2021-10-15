//
//  EditFormVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 13/08/21.
//

import UIKit


enum ShowFormType {
    case None, EditProfile, ContactHelp
}

class EditFormVC: BaseClassVC {
    
    //    MARK:- Varaible Definces
    //    MARK:-
    
    @IBOutlet weak var MainStack: UIStackView!
    
    @IBOutlet weak var PriofileView: UIView!
    @IBOutlet weak var PriofileIMG: UIImageView!
    @IBOutlet weak var PriofileBTN: UIButton!
    
    @IBOutlet weak var TextFieldView1: UIView!
    @IBOutlet weak var TXTField1: UITextField!
    
    @IBOutlet weak var TextFieldView2: UIView!
    @IBOutlet weak var TXTField2: UITextField!
    
    @IBOutlet weak var TextView: UIView!
    @IBOutlet weak var Comment_height: NSLayoutConstraint!
    @IBOutlet weak var PlaceLBL: UILabel!
    @IBOutlet weak var TXTView: UITextView!
    
    @IBOutlet weak var OptionView: UIView!
    @IBOutlet weak var ActionBTN: UIButton!
    
    @IBOutlet weak var BottomNote: UIView!
    @IBOutlet weak var NoteLBL: UILabel!
    
    //    MARK:- Varaible Definces
    //    MARK:-
    
    var FormType: ShowFormType = .None
    var isUpdateMode: Bool = false
    
    //    MARK:- View Cycle
    //    MARK:-
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toogleTabbar(hide: true)
        self.setupUI()
        self.SetupNavBarforback()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = TBLBackgroundCOlor
    }
    
    //    MARK:- User Define
    //    MARK:-
    
    override func setupUI() {
        
        self.view.backgroundColor = TBLBackgroundCOlor
        self.MainStack.backgroundColor = TBLBackgroundCOlor
        
        self.PriofileIMG.clipsToBounds = true
        self.PriofileIMG.layer.cornerRadius = self.PriofileIMG.frame.height / 2
        
        self.TextFieldView1.backgroundColor = ModeBG_Color
        self.TextFieldView1.clipsToBounds = true
        self.TextFieldView1.layer.cornerRadius = 10
        
        self.TextFieldView2.backgroundColor = ModeBG_Color
        self.TextFieldView2.clipsToBounds = true
        self.TextFieldView2.layer.cornerRadius = 10
        
        self.TextView.backgroundColor = ModeBG_Color
        self.TextView.clipsToBounds = true
        self.TextView.layer.cornerRadius = 10
        
        self.TXTField1.delegate = self
        self.TXTField2.delegate = self
        self.TXTView.delegate = self
        
        self.PlaceLBL.textColor = UIColor.secondaryLabel.withAlphaComponent(0.3)
        self.ActionBTN.GetThemeButtonwithBorder()
        self.NoteLBL.textColor = UIColor.label
        self.NoteLBL.text = "Help Line:  +91 9876543210"
        self.NoteLBL.font = UIFont.systemFont(ofSize: 24)
        
        self.TXTField1.placeholder = "Full name"
        
        
        switch self.FormType {
        case .None:
            break
            
        case .EditProfile:
            
            self.title = "User Profile"
            self.PriofileView.isHidden = true
            self.TXTField1.isHidden = false
            self.TXTField2.isHidden = false
            self.OptionView.isHidden = false
            self.TXTView.isHidden = true
            self.BottomNote.isHidden = true
            self.TXTField2.placeholder = "Email"
            self.ActionBTN.setTitle("Update Info", for: .normal)
            
            let userinfo = SharedUserInfo.shared.GetUserInfodata()
            self.PriofileIMG.image = UIImage.init(named: "HomeLogo")
            
            self.PriofileIMG.contentMode = .scaleAspectFill
            self.TXTField1.text = userinfo?.fullName
            self.TXTField2.text = userinfo?.email
            
            self.Comment_height.constant = 0
            
            let editBTN = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
            editBTN.clipsToBounds = true
            editBTN.layer.cornerRadius = 10
            editBTN.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.4)
            editBTN.tintColor = UIColor.white
            editBTN.setImage(UIImage.init(systemName: "pencil"), for: .normal)
            editBTN.addTarget(self, action: #selector(TappedEditBTN(_:)), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: editBTN)
            
            if self.isUpdateMode {
                self.TXTField1.isEnabled = true
                self.TXTField2.isEnabled = true
                self.ActionBTN.isEnabled = true
                self.ActionBTN.alpha = 1.0
            }
            else {
                self.TXTField1.isEnabled = false
                self.TXTField2.isEnabled = false
                self.ActionBTN.isEnabled = false
                self.ActionBTN.alpha = 0.5
            }
            break
            
        case .ContactHelp:
            self.title = "Contact help"
            self.PriofileView.isHidden = true
            self.TXTField1.isHidden = false
            self.TXTField2.isHidden = false
            self.OptionView.isHidden = false
            self.TXTView.isHidden = false
            self.Comment_height.constant = 200
            self.BottomNote.isHidden = false
            self.TXTField2.placeholder = "Subject"
            self.ActionBTN.setTitle("Place Query", for: .normal)
            break
        }
        
    }
    
    //    MARK:- IBActions Methods
    //    MARK:-
    
    
    @objc func TappedEditBTN(_ sender: UIButton) {
        if self.isUpdateMode {
            self.TXTField1.isEnabled = false
            self.TXTField2.isEnabled = false
            self.ActionBTN.isEnabled = false
            self.ActionBTN.alpha = 0.5
            self.isUpdateMode = false
        }
        else {
            self.TXTField1.isEnabled = true
            self.TXTField2.isEnabled = true
            self.ActionBTN.isEnabled = true
            self.ActionBTN.alpha = 1.0
            self.isUpdateMode = true
        }
    }
    
    @IBAction func TappedActions(_ sender: UIButton) {
        switch self.FormType {
        case .None:
            break
            
        case .EditProfile:
            if sender == self.PriofileBTN && self.isUpdateMode {
                AttachmentHandler.shared.ShowSelectedAttachOption(vc: self, constant: [.camera, .photoLibrary])
                AttachmentHandler.shared.imagePickedBlock = { (image) in
                    self.PriofileIMG.image = image
                }
            }
            else {
                if self.isUpdateMode {
                    self.showLoaderActivity()
                    let param = UpdateProfileParamDict.init(fullname: self.TXTField1.text, email: self.TXTField2.text, mobile: SharedUserInfo.shared.GetUserInfodata()?.mobileNo)
                    NetworkingRequests.shared.Request_UpdateProfile(param: param) { (responseObject, status) in
                        if status && ((responseObject.loginData?.token.IsStrEmpty()) != nil) {
                            SharedUserInfo.shared.SaveUserInfodata(info: responseObject.loginData!)
                            self.navigationController?.view.makeToast(responseObject.message!, duration: 3.0, position: .top)
                        }
                        else {
                            self.navigationController?.view.makeToast(responseObject.message!, duration: 3.0, position: .top)
                        }
                        self.hideLoaderActivity()
                        self.navigationController?.popViewController(animated: true)
                    } onFailure: { message in
                        if IsInternetIssue(message: message) {
                            
                        }
                        else {
                            self.navigationController?.view.makeToast(message, duration: 3.0, position: .top)
                            self.hideLoaderActivity()
                        }
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }
            }
            break
            
        case .ContactHelp:
            if sender == self.ActionBTN {
                
            }
            break
        }
    }

}


//MARK:- Textfield Delegates
extension EditFormVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        print(newString)
        if textField == self.TXTField1 {

        }
        else {
            
        }
        return true
    }
    
}

//MARK:- UITextView Delegate
extension EditFormVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentString: NSString = textView.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: text) as NSString
        if newString.length == 0 {
            self.ActionBTN.isEnabled = false
            self.ActionBTN.alpha = 0.5
            self.PlaceLBL.isHidden = false
        }
        else {
            self.ActionBTN.isEnabled = true
            self.ActionBTN.alpha = 1.0
            self.PlaceLBL.isHidden = true
        }
        return true
    }
    
}
