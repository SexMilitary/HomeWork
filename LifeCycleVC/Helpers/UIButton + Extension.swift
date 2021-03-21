//
//  UIButton + Extension.swift
//  LifeCycleVC
//
//  Created by Максим on 18.03.2021.
//

import UIKit

extension UIButton {
    convenience init(title: String,
                     titleColor: UIColor,
                     backgroundColor: UIColor,
                     font: UIFont? = .systemFont(ofSize: 28, weight: UIFont.Weight.regular),
                     isShadow: Bool = false,
                     cornerRadius: CGFloat = 4.0,
                     icon: UIImage?,
                     imageRightEdgeInsets: CGFloat?) {
        
        self.init(type: .system)
        
        self.setTitle(title.uppercased(), for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        if let icon = icon {
            self.setImage(icon, for: .normal)
            self.imageView?.contentMode = .scaleAspectFit
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: imageRightEdgeInsets!)
            self.tintColor = .white
        }
        
        self.layer.cornerRadius = cornerRadius
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
}
