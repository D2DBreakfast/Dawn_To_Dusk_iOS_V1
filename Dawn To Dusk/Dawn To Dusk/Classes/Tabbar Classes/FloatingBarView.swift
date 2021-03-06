//
//  FloatingBarView.swift
//  Dawn To Dusk
//
//  Created by Hiren on 20/07/21.

import UIKit

protocol FloatingBarViewDelegate: AnyObject {
    func did(selectindex: Int)
}

class FloatingBarView: UIView {

    weak var delegate: FloatingBarViewDelegate?
    var hub: BadgeHub?
    
    var buttons: [UIButton] = []

    init(_ items: [String]) {
        super.init(frame: .zero)
        backgroundColor = UIColor.colorWithHexString(hexStr: GetDefaultTheme()!)

        setupStackView(items)
        updateUI(selectedIndex: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.shadowRadius = bounds.height / 2
    }

    func setupStackView(_ items: [String]) {
        for (index, item) in items.enumerated() {
//            let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .medium)
//            let normalImage = UIImage(systemName: item, withConfiguration: symbolConfig)
//            let selectedImage = UIImage(systemName: "\(item).fill", withConfiguration: symbolConfig)
            let normalImage = UIImage.init(named: item)
            let selectedImage = UIImage.init(named: item)
            let button = createButton(normalImage: normalImage!, selectedImage: selectedImage!, index: index)
            self.buttons.append(button)
        }

        let stackView = UIStackView(arrangedSubviews: self.buttons)

        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }

    func createButton(normalImage: UIImage, selectedImage: UIImage, index: Int) -> UIButton {
        let button = UIButton()
        button.constrainWidth(constant: 80)
        button.constrainHeight(constant: 70)
        button.setImage(normalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        button.tag = index
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(changeTab(_:)), for: .touchUpInside)
        return button
    }

    func setupBadgeHub(indexBD: Int, Counts: Int) {
        for (index, button) in buttons.enumerated() {
            if index == indexBD {
                self.hub = BadgeHub(view: button)
                self.hub?.moveCircleBy(x: 65, y: 20)
                self.hub?.blink()
                self.hub?.increment(by: Counts)
            }
        }
    }
    
    func removeBadgeHub(indexBD: Int, Counts: Int) {
        for (index, button) in self.buttons.enumerated() {
            if index == indexBD {
                print(button)
                self.hub?.hide()
            }
        }
    }
    
    @objc
    func changeTab(_ sender: UIButton) {
        sender.pulse()
        delegate?.did(selectindex: sender.tag)
        updateUI(selectedIndex: sender.tag)
    }

    func updateUI(selectedIndex: Int) {
        for (index, button) in self.buttons.enumerated() {
            if index == selectedIndex {
                button.isSelected = true
                button.tintColor = .white
            } else {
                button.isSelected = false
                button.tintColor = .lightGray
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func toggle(hide: Bool) {
        if !hide {
            isHidden = hide
        }

        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.alpha = hide ? 0 : 1
            self.transform = hide ? CGAffineTransform(translationX: 0, y: 10) : .identity
        }) { (_) in
            if hide {
                self.isHidden = hide
            }
        }
    }
}

extension UIButton {

    func pulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.15
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        layer.add(pulse, forKey: "pulse")
    }
}
