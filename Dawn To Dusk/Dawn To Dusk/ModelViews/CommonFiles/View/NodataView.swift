//
//  NodataView.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 29/07/21.
//

import Foundation
@IBDesignable class NodataView: UIView {
    
    // MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBInspectable @IBOutlet weak var TitleLBL: UILabel!
    @IBInspectable @IBOutlet weak var messageLBL: UILabel!
    @IBOutlet weak var ActionBTN: UIButton!
    
    var didActionBlock: (()->())?
    
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
        view.backgroundColor = ModeBG_Color
        addSubview(view)
        
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(TappedButton(_:)))
        self.addGestureRecognizer(gesture)
        self.addGestureRecognizer(gesture)
        
        self.TitleLBL.text = "No data available!"
        self.messageLBL.text = "There are no Data available yet!"
        
        self.ActionBTN.setTitle("Refresh Now", for: .normal)
        self.ActionBTN.backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)
        self.ActionBTN.setTitleColor(UIColor.white, for: .normal)
        self.ActionBTN.clipsToBounds = true
        self.ActionBTN.layer.cornerRadius = 10.0
        
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.backgroundColor = ModeBG_Color
        return view
    }
    
    func fillinfo(title: String, Notes: String, image: String, enable refresh: Bool) {
        self.TitleLBL.text = title
        self.messageLBL.text = Notes
        if image.count == 0 {
            self.imageView.image = UIImage.init(named: "NodataIMG")
        }
        else{
            self.imageView.image = UIImage.init(named: image)
        }
        self.ActionBTN.isHidden = refresh
    }
    
    // MARK: - Actions
    
    @IBAction func TappedButton(_ sender: UIButton) {
        if self.didActionBlock != nil {
            self.didActionBlock!()
        }
    }
}
