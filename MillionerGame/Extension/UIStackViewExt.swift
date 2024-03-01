//
//  UIStackViewExt.swift
//  MillionerGame
//
//  Created by Иван Семенов on 01.03.2024.
//

import UIKit
///расширение для стека
extension UIStackView {
    convenience init(views: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: Alignment = .center) {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
    }
}
