//
//  GameView.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class GameView: UIView {
    
    // MARK: - UI Elements
    
    let backgroundImage = UIImageView(image: UIImage(named: "bgHumans"))
    let takeMoneyButton = UIButton(type: .system)
    let exitButton = UIButton(type: .system)
    let questionNumberLabel = UILabel(text: "Вопрос 3/15")
    let questionTextLabel = UILabel(text: "Which team of the first challenge is the best in this stream?")
    let sumTotalLabel = UILabel(text: "100 RUB")
    
    let help5050Button = UIButton(type: .system)
    let helpPhoneButton = UIButton(type: .system)
    let helpHumansButton = UIButton(type: .system)
    
    let buttonAnswerA = UIButton(text: "A: Answer One")
    let buttonAnswerB = UIButton(text: "B: Answer Two")
    let buttonAnswerC = UIButton(text: "C: Answer Three")
    let buttonAnswerD = UIButton(text: "D: Answer Fourth")
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: CGRect())
        setupUI()
    }

    // MARK: - Setup UI
    
    func setupUI() {
        
        takeMoneyButton.setImage(UIImage(systemName: "sos"), for: .normal)
        exitButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        
        help5050Button.setImage(UIImage(named: "help5050"), for: .normal)
        helpPhoneButton.setImage(UIImage(named: "helpPhone"), for: .normal)
        helpHumansButton.setImage(UIImage(named: "helpHumans"), for: .normal)
        
        let topStack = UIStackView(views: [exitButton,
                                           questionNumberLabel,
                                           takeMoneyButton],
                                   axis: .horizontal,
                                   spacing: 50)
        
        let helpButtonsStackView = UIStackView(views: [help5050Button,
                                                       helpPhoneButton,
                                                       helpHumansButton], 
                                               axis: .horizontal,
                                               spacing: 20)

        let answersButtonsStack = UIStackView(views: [buttonAnswerA,
                                                          buttonAnswerB,
                                                          buttonAnswerC,
                                                          buttonAnswerD],
                                                  axis: .vertical,
                                                spacing: 20)
        
        let mainStack = UIStackView(views: [topStack,
                                                sumTotalLabel,
                                                questionTextLabel,
                                                helpButtonsStackView,
                                                answersButtonsStack],
                                        axis: .vertical,
                                        spacing: 10)
        addSubview(backgroundImage)
        addSubview(mainStack)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        // MARK: - Constraints
        
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            mainStack.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 10),
            mainStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            mainStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            questionTextLabel.heightAnchor.constraint(equalToConstant: 300),
        ])
        

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Extension UIElement

extension UIStackView {
    convenience init(views: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: Alignment = .center) {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
    }
}

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
        self.font = UIFont(name: "Gilroy-Regular", size: 25)
        self.textColor = .white
        self.numberOfLines = 0
    }
}

extension UIButton {
    convenience init(text: String) {
        self.init()
        self.setTitle(text, for: .normal)
        self.contentHorizontalAlignment = .leading
        self.tintColor = .white
        self.titleLabel?.font = .boldSystemFont(ofSize: 25)
        self.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
        self.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        //self.addTarget(self, action: #selector(buttonsTapped), for: .touchUpInside)
        let inset: CGFloat = 15
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0)
    }
}

//extension UIImageView {
//    convenience init(name: String) {
//        self.init()
//        self.image = UIImage(named: name)
//        self.contentMode = .scaleAspectFit
//        self.isUserInteractionEnabled = true
//        self.translatesAutoresizingMaskIntoConstraints = false
//    }
//}

// MARK: - UI Build

import SwiftUI
struct GameViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = GameView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}


