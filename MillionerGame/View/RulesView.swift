//
//  RulesView.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class RulesView: UIView {
    let backgroundImage = UIImageView(image: UIImage(named: "bg")!)
    let logoLabel = UILabel()
    //rulesLabel вроде лейбл а не текстВью
    let rulesLabel = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    //если создаешь кнопку пропиши ей логику в контроллере
    let homeButton = UIButton(title: "Назад", bg: .systemGreen)
    
    init() {
        super.init(frame: CGRect())
        setupUI()
        
    }
    func setupUI() {
        backgroundImage.contentMode = .scaleAspectFill
        
        logoLabel.text = "Правила игры"
        logoLabel.font = UIFont(name: "Gilroy-Bold", size: 35)
        logoLabel.textColor = .white
        logoLabel.textAlignment = .center
        
        rulesLabel.isScrollEnabled = true
        rulesLabel.text = rules
        rulesLabel.font = UIFont(name: "Gilroy-Bold", size: 15)
        rulesLabel.backgroundColor = .clear
        rulesLabel.textColor = .white
        rulesLabel.textAlignment = .natural
        rulesLabel.isEditable = false
        
        let stack = UIStackView(arrangedSubviews: [logoLabel, rulesLabel, homeButton])
        stack.axis = .vertical
        stack.spacing = 3
        
        
        addSubview(backgroundImage)
        addSubview(stack)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            //нулевые константы удали
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            stack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
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
