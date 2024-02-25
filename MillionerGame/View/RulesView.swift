//
//  RulesView.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class RulesView: UIView {
    let label = UILabel()
    
    init() {
        super.init(frame: CGRect())
        setupUI()
        
    }
    func setupUI() {
        backgroundColor = .white
        label.text = "Правила"
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
import SwiftUI

struct RulesViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = RulesView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
