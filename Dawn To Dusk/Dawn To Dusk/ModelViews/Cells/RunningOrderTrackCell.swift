//
//  RunningOrderTrackCell.swift
//  Dawn To Dusk
//
//  Created by Hiren on 19/08/21.
//

import UIKit

class RunningOrderTrackCell: UITableViewCell {
    
    //    MARK:- IBOutlet Defines
    //    MARK:-
    
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var MainStack: UIStackView!
    
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet var Orderid: [UILabel]!
    
    @IBOutlet var UpLineIMG: [UIImageView]!
    @IBOutlet var CenterIMG: [UIImageView]!
    @IBOutlet var BottomLineIMG: [UIImageView]!
    
    //    MARK:- Variable Defines
    //    MARK:-
    
    //    MARK:- Custome methods Defines
    //    MARK:-
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = TBLBackgroundCOlor
        self.contentView.backgroundColor = TBLBackgroundCOlor
        
        self.MainView.backgroundColor = ModeBG_Color
        self.MainView.clipsToBounds = true
        self.MainView.layer.cornerRadius = 10
        
        self.SelectedPoints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func SelectedPoints(selectedIndex: Int? = 0) {
        for (index, _) in self.UpLineIMG.enumerated() {
            let up = self.UpLineIMG[index]
            let center = self.CenterIMG[index]
            let bottom = self.BottomLineIMG[index]
            if up.tag <= selectedIndex! || center.tag <= selectedIndex! || bottom.tag <= selectedIndex! {
                up.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
                center.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
                bottom.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
            }
            else {
                up.tintColor = .secondaryLabel
                center.tintColor = .secondaryLabel
                bottom.tintColor = .secondaryLabel
            }
        }
    }
    
    //    MARK:- IBAction Defines
    //    MARK:-
    
}
