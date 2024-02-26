//
//  GameView.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class GameView: UIView {
    
    // MARK: - UI Element
    
    let backgroundImage = UIImageView(image: UIImage(named: "bgHumans"))
    
    let mainStack = UIStackView(axis: .vertical)
    
    let firstStack = UIStackView(axis: .horizontal)
    let logoImage = UIImageView(image: UIImage(named: "logo"))
    
    let questionLabel = UILabel(text: "Which team of the first challenge is the best in this stream?")
    
    let numberQuestion = UILabel(text: "Вопрос 1")
    let sumTotal = UILabel(text: "100 RUB")
    
    let thirdStack = UIStackView(axis: .horizontal)
    let helpFiftyFifty = UIImageView(name: "help5050")
    let helpHumans = UIImageView(name: "helpHumans")
    let helpPhone = UIImageView(name: "helpPhone")
    let buttonFiftyFifty = UIButton()
    let buttonHumans = UIButton()
    let buttonPhone = UIButton()
    
    let fourthStack = UIStackView(axis: .vertical)
    let buttonAnswerA = UIButton(text: "A: Answer One")
    let buttonAnswerB = UIButton(text: "B: Answer Two")
    let buttonAnswerC = UIButton(text: "C: Answer Three")
    let buttonAnswerD = UIButton(text: "D: Answer Fourth")
    
    init() {
        super.init(frame: CGRect())
        setupUI()
    
    }
    
    
    // MARK: - Setup UI
    
    func setupUI() {
        
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        // MARK: - Setup AddSubview
        addSubview(backgroundImage)
        addSubview(mainStack)
        helpFiftyFifty.addSubview(buttonFiftyFifty)
        helpHumans.addSubview(buttonHumans)
        helpPhone.addSubview(buttonPhone)
        
        mainStack.addArrangedSubview(firstStack)
        mainStack.addArrangedSubview(questionLabel)
        mainStack.addArrangedSubview(thirdStack)
        mainStack.addArrangedSubview(fourthStack)
     
        
        firstStack.addArrangedSubview(logoImage)
        firstStack.addArrangedSubview(numberQuestion)
        firstStack.addArrangedSubview(sumTotal)
        
        
        thirdStack.addArrangedSubview(helpFiftyFifty)
        thirdStack.addArrangedSubview(helpHumans)
        thirdStack.addArrangedSubview(helpPhone)
        
        fourthStack.addArrangedSubview(buttonAnswerA)
        fourthStack.addArrangedSubview(buttonAnswerB)
        fourthStack.addArrangedSubview(buttonAnswerC)
        fourthStack.addArrangedSubview(buttonAnswerD)
        
    
        // MARK: - Setup Constraints
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            mainStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            
            questionLabel.heightAnchor.constraint(equalToConstant: 200)
            
           
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension UIElement

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis) {
        self.init()
        self.axis = axis
        self.spacing = 10
        self.distribution = .fillProportionally
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
        self.font = .boldSystemFont(ofSize: 20)
        self.textColor = .white
        self.numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
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

extension UIImageView {
    convenience init(name: String) {
        self.init()
        self.image = UIImage(named: name)
        self.contentMode = .scaleAspectFit
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}



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


