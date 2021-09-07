//
//  RunningOrderCell.swift
//  Dawn To Dusk
//
//  Created by Hiren on 07/09/21.
//

import UIKit

class RunningOrderCell: UITableViewCell {

    @IBOutlet weak var TrackView: UIView!
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var DetailLBL: UILabel!
    
    @IBOutlet weak var TrackBTN: UIButton!
    
    //    MARK:- Variable Defines
    //    MARK:-
    
    var didTappedActionBlock: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ModeBG_Color
        self.contentView.backgroundColor = ModeBG_Color
        
        self.TrackView.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!).withAlphaComponent(0.4)
        self.TrackView.clipsToBounds = true
        self.TrackView.layer.cornerRadius = 20
    
        self.TrackBTN.GetThemeButtonwithBorder()
        self.TrackBTN.setTitle("Track Order", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //    MARK:- Custom Defines
    //    MARK:-
    
    func setuptrackdata() {
        self.TitleLBL.text = "Track your order here with status"
        self.DetailLBL.text = "Order #123543534"
    }
    
    //    MARK:- IBAction Methods Defines
    //    MARK:-
    
    @IBAction func TappedButton(_ sender: UIButton) {
        if sender == self.TrackBTN {
            if self.didTappedActionBlock != nil {
                self.didTappedActionBlock!()
            }
        }
    }
    
}
