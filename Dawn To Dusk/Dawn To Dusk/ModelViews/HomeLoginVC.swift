//
//  HomeLoginVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 20/07/21.
//

import UIKit

class HomeLoginVC: BaseClassVC {

//    MARK:- IBOutlets
//    MARK:-
    
    @IBOutlet weak var SkipBTN: UIButton!
    @IBOutlet weak var GetStartedBTN: UIButton!
    @IBOutlet weak var LogoIMG: UIImageView!
    
//    MARK:- Variables
//    MARK:-
    
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
    
    override func setupUI() {
        
        self.view.backgroundColor = ModeBG_Color
        
        self.LogoIMG.image = UIImage.init(named: "HomeLogo")
        
        self.GetStartedBTN.setTitleColor(.white, for: .normal)
        self.GetStartedBTN.clipsToBounds = true
        self.GetStartedBTN.layer.cornerRadius = 10
        self.GetStartedBTN.layer.borderColor = WhiteBorderColor?.cgColor
        self.GetStartedBTN.layer.borderWidth = 1
        
        self.SkipBTN.setTitleColor(.white, for: .normal)
        self.SkipBTN.clipsToBounds = true
        self.SkipBTN.layer.cornerRadius = 10
        self.SkipBTN.layer.borderColor = WhiteBorderColor?.cgColor
        self.SkipBTN.layer.borderWidth = 1
    }

//    MARK:- IBAction Methods
//    MARK:-
    
    @IBAction func TappedStarted(_ sender: UIButton) {
        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
        vc.LoginSelected = 100
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func TappedSkip(_ sender: Any) {
        SharedUserInfo.shared.isFirstLaunch = true
        let vc = HomeDashboardVC()
        self.navigationController!.pushViewController(vc, animated: true)
        AppScene?.SetDashboard()
    }
    
}

