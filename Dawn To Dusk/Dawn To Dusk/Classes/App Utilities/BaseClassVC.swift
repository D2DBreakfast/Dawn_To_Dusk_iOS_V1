//
//  BaseClassVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 22/07/21.
//

import UIKit

class BaseClassVC: UIViewController {
    
    //    MARK:- IBOutlets
    //    MARK:-
    
    //    MARK:- Variables
    //    MARK:-
    
    //    MARK:- View Classes
    //    MARK:-
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.Listsubviews()
        self.view.backgroundColor = ModeBG_Color
        self.setupUI()
//        UIView.appearance().semanticContentAttribute = .forceRightToLeft
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: Notification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //    MARK:- User's Custome Methods
    //    MARK:-
    
    @objc func networkStatusChanged(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let status = userInfo["Status"] as! String
            print(status)
            self.checkNetworkStatus()
        }
    }
    
    func checkNetworkStatus() {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            break;
            
        case .online(.wwan):
            print("Connected via WWAN")
            break;
            
        case .online(.wiFi):
            print("Connected via WiFi")
            break;
        }
    }
    
    func Listsubviews() {
        
    }
    
    func setupUI() {
        self.view.backgroundColor = ModeBG_Color
        for item in self.view.subviews {
            if item.isKind(of: UIView.self) {
                item.backgroundColor = ModeBG_Color
            }
            if item.isKind(of: UILabel.self) {
                (item as? UILabel)?.textColor = PrimaryText_Color
                (item as? UILabel)?.font = UIFont.systemFont(ofSize: 17)
            }
            if item.isKind(of: UIButton.self) {
                (item as? UIButton)?.setTitleColor(SecondaryText_Color, for: .normal)
                (item as? UIButton)?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            }
            if item.isKind(of: UITextField.self) {
                (item as? UITextField)?.font = UIFont.systemFont(ofSize: 15)
                (item as? UITextField)?.textColor = PrimaryText_Color
                (item as? UITextField)?.attributedPlaceholder =
                    NSAttributedString(string: ((item as? UITextField)?.placeholder)!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
            }
            if item.isKind(of: UIScrollView.self) {
                (item as? UIScrollView)?.backgroundColor = ModeBG_Color
            }
            if item.isKind(of: UIImageView.self) {
                (item as? UIImageView)?.backgroundColor = .clear
                (item as? UIImageView)?.tintColor = .clear
            }
        }
    }
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func toogleTabbar(hide: Bool) {
        guard let tabBar = tabBarController as? HomeDashboardVC else { return }
        tabBar.toggle(hide: hide)
    }
    
    func showLoaderActivity() {
        self.navigationController?.view.makeToastActivity(.center)
        self.view.isUserInteractionEnabled = false
    }
    
    func hideLoaderActivity() {
        self.navigationController?.view.hideToastActivity()
        self.view.isUserInteractionEnabled = true
    }
    
    func Stuptoast_styles() {
        
        // Make Toast
        self.navigationController?.view.makeToast("This is a piece of toast")
        
        // Make toast with a duration and position
        self.navigationController?.view.makeToast("This is a piece of toast on top for 3 seconds", duration: 3.0, position: .top)
        
        // Make toast with a title
        self.navigationController?.view.makeToast("This is a piece of toast with a title", duration: 2.0, position: .top, title: "Toast Title", image: nil)
        
        // Make toast with an image
        self.navigationController?.view.makeToast("This is a piece of toast with an image", duration: 2.0, position: .center, title: nil, image: UIImage(named: "toast.png"))
        
        // Make toast with an image, title, and completion closure
        self.navigationController?.view.makeToast("This is a piece of toast with a title, image, and completion closure", duration: 2.0, position: .bottom, title: "Toast Title", image: UIImage(named: "toast.png")) { didTap in
            if didTap {
                print("completion from tap")
            } else {
                print("completion without tap")
            }
        }
        
        // Make toast with a custom style
        var style = ToastStyle()
        style.messageFont = UIFont(name: "Zapfino", size: 14.0)!
        style.messageColor = UIColor.red
        style.messageAlignment = .center
        style.backgroundColor = UIColor.yellow
        self.navigationController?.view.makeToast("This is a piece of toast with a custom style", duration: 3.0, position: .bottom, style: style)
        
        // Show a custom view as toast
        let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 80.0, height: 400.0))
        customView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        customView.backgroundColor = .blue
        self.navigationController?.view.showToast(customView, duration: 2.0, position: .center)
        
        // Show an image view as toast, on center at point (110,110)
        let toastView = UIImageView(image: UIImage(named: "toast.png"))
        self.navigationController?.view.showToast(toastView, duration: 2.0, point: CGPoint(x: 110.0, y: 110.0))
        
        
        // Hide toast
        self.navigationController?.view.hideToast()
        
        // Hide all toasts
        self.navigationController?.view.hideAllToasts()
    }
    
}


