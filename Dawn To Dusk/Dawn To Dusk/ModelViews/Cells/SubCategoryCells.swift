//
//  SubCategoryCells.swift
//  Dawn To Dusk
//
//  Created by Hiren on 16/09/21.
//

import UIKit

class SubCategoryCells: UICollectionViewCell {

    @IBOutlet weak var View: UIView!
    @IBOutlet weak var TitleLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = ModeBG_Color
        self.contentView.backgroundColor = ModeBG_Color
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 20
        
        self.View.backgroundColor = .yellow
        self.View.clipsToBounds = true
        self.View.layer.cornerRadius = 20
        
    }

}
