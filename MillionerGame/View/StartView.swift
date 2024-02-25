//
//  StartView.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class StartView: UIView {
    
    
    init() {
        super.init(frame: CGRect())
        setupUI()
        
    }
    func setupUI() {
        backgroundColor = .systemCyan
    }
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
