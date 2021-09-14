//
//  BasicTableCell.swift
//  Dawn To Dusk
//
//  Created by Hiren on 04/08/21.
//

import UIKit

class BasicTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ModeBG_Color
        self.contentView.backgroundColor = ModeBG_Color
        self.textLabel!.font = UIFont.boldSystemFont(ofSize: 20)
        self.textLabel!.text = ""
        self.detailTextLabel!.text = ""
        self.imageView?.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //    MARK:- Custom Defines
    //    MARK:-
    
    func ShowSkeleton() {
        self.textLabel!.showAnimatedGradientSkeleton()
        self.detailTextLabel!.showAnimatedGradientSkeleton()
    }
    
    func HideSkeleton() {
        self.textLabel!.hideSkeleton()
        self.detailTextLabel!.hideSkeleton()
    }
    
    func setupcell(data: NotificationModels, indexPath: IndexPath) {
        self.textLabel!.text = data.title
        self.detailTextLabel!.text = data.shortdesc
//        if data.gallery!.count >= 1 {
//            self.imageView?.downloadedFrom(url: URL.init(string: (data.gallery?.first)!)!)
//            self.imageView!.contentMode = .scaleAspectFill
//        }
        self.HideSkeleton()
    }
    
}
