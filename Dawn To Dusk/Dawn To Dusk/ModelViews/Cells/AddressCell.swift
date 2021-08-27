//
//  AddressCell.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 06/08/21.
//

import UIKit

class AddressCell: UITableViewCell {
    
    @IBOutlet weak var AddressView: UIView!
    @IBOutlet weak var LocationIMG: UIImageView!
    @IBOutlet weak var AddressLBL: UILabel!
    @IBOutlet weak var CheckBoxBTN: UIButton!
    
    var didSelectAddressActionBlock: ((Int?)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = TBLBackgroundCOlor
        self.contentView.backgroundColor = TBLBackgroundCOlor
        
        self.AddressView.clipsToBounds = true
        self.AddressView.layer.cornerRadius = 20
        self.AddressView.backgroundColor = ModeBG_Color
        self.CheckBoxBTN.isSelected = false
        
        self.LocationIMG.tintColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func SetupCell(indexPath: IndexPath, data: AddressListModelClass) {
        if data.isprimary! {
            self.CheckBoxBTN.isSelected = true
            self.CheckBoxBTN.setImage(UIImage.init(systemName: "checkmark.circle.fill"), for: .normal)
        }
        else {
            self.CheckBoxBTN.isSelected = false
            self.CheckBoxBTN.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
        }
        self.CheckBoxBTN.tag = indexPath.row
        self.AddressLBL.text = data.address
    }
    
    func setupPaymentCell(indexPath: IndexPath, isprimary: Bool = false) {
        if isprimary {
            self.CheckBoxBTN.isSelected = true
            self.CheckBoxBTN.setImage(UIImage.init(systemName: "checkmark.circle.fill"), for: .normal)
        }
        else {
            self.CheckBoxBTN.isSelected = false
            self.CheckBoxBTN.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
        }
        self.CheckBoxBTN.tag = indexPath.row
        self.AddressLBL.text = "fsadhfgkjshadgfkjhsagkfjhsagkj"
    }
    
    @IBAction func TappedCheckBox(_ sender: UIButton) {
        if sender.isSelected {
            self.CheckBoxBTN.isSelected = false
            self.CheckBoxBTN.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
        }
        else {
            self.CheckBoxBTN.isSelected = true
            self.CheckBoxBTN.setImage(UIImage.init(systemName: "checkmark.circle.fill"), for: .normal)
            if self.didSelectAddressActionBlock != nil {
                self.didSelectAddressActionBlock!(self.CheckBoxBTN.tag)
            }
        }
    }
    
}
