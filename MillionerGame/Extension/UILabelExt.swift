//
//  UILabelExt.swift
//  MillionerGame
//
//  Created by Иван Семенов on 01.03.2024.
//

import UIKit
///расширение для лейбла
extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
        self.font = UIFont(name: "Gilroy-Regular", size: 25)
        self.textColor = .white
        self.numberOfLines = 0
    }
}
