//
//  CompleteOrderVC.swift
//  Dawn To Dusk
//
//  Created by Hiren on 28/09/21.
//

import UIKit

class CompleteOrderVC: BaseClassVC {

    //    MARK:- Varaible Definces
    //    MARK:-
    
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
    
    //    MARK:- IBActions Methods
    //    MARK:-

}
