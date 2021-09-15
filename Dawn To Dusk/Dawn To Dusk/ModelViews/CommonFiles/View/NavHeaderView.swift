//
//  NavHeaderView.swift
//  CustomUIViewFromXib
//
//  Created by Fernando Fernandes on 7/21/16.
//  Copyright © 2016 backslash-f. All rights reserved.
//

import UIKit

enum ActionType {
    case Cart, Logout
}

@IBDesignable class NavHeaderView: UIView {
    
    // MARK: - Properties
    var hub: BadgeHub?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var CartBTN: UIButton!
    @IBOutlet weak var LogoutBTN: UIButton!
    
    var callbackAction: ((ActionType?)->())?
    
    @IBInspectable var image: UIImage? {
        get {
            return imageView.image
        }
        set(image) {
            imageView.image = image
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    fileprivate func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.hub = BadgeHub(view: self.CartBTN)
        self.hub?.moveCircleBy(x: -15, y: 15)
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func fillinfo(title: String, isUserProfile: Bool = false) {
        if isUserProfile {
            self.CartBTN.isHidden = true
            self.LogoutBTN.isHidden = false
        }
        else {
            self.CartBTN.isHidden = false
            self.LogoutBTN.isHidden = true
        }
        self.TitleLBL.text = title
        self.CartBTN.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.LogoutBTN.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.imageView.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
    }
    
    // MARK: - Actions
    
    @IBAction func TappedButton(_ sender: UIButton) {
        if sender == self.CartBTN {
            self.callbackAction!(.Cart)
        }
        else {
            self.callbackAction!(.Logout)
        }
    }
}
