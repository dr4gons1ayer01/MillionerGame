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
    ///поменять на картинки из ассетов
    let showProgressButton = UIButton()
    let exitButton = UIButton()
    
    let questionNumberLabel = UILabel(text: "Вопрос 3/15")
    let questionTextLabel = UILabel(text: "Which team of the first challenge is the best in this stream?")
    let sumTotalLabel = UILabel(text: "100 RUB")
    
    let timerProgress = UIProgressView()
    
    let help5050Button = UIButton(imageNamed: "5050", width: 90, height: 70)
    let helpPhoneButton = UIButton(imageNamed: "call", width: 90, height: 70)
    let helpHumansButton = UIButton(imageNamed: "people", width: 90, height: 70)
    
    let buttonAnswerA = UIButton(text: "A: Answer One", alignment: .leading)
    let buttonAnswerB = UIButton(text: "B: Answer Two", alignment: .leading)
    let buttonAnswerC = UIButton(text: "C: Answer Three", alignment: .leading)
    let buttonAnswerD = UIButton(text: "D: Answer Fourth", alignment: .leading)
    
    let takeMoneyButton = UIButton(text: "Забрать деньги", alignment: .center)
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: CGRect())
        setupUI()
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        showProgressButton.setImage(.progress, for: .normal)
        exitButton.setImage(.exit, for: .normal)
        
        questionNumberLabel.textAlignment = .center
        
        sumTotalLabel.textAlignment = .center
//        sumTotalLabel.layer.borderWidth = 2
//        sumTotalLabel.layer.borderColor = UIColor.white.cgColor
//        sumTotalLabel.layer.cornerRadius = 12
        sumTotalLabel.font = UIFont(name: "Gilroy-Bold", size: 25)
        
        ///решим делать ли бекграунд лейблу
//        sumTotalLabel.backgroundColor
        sumTotalLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        timerProgress.layer.cornerRadius = 5
        timerProgress.layer.borderWidth = 2
        timerProgress.layer.borderColor = UIColor.white.cgColor
        timerProgress.trackTintColor = .systemGray
        ///тут  тоже цвет поменять
        timerProgress.progressTintColor = UIColor(resource: .gameBlue)
        timerProgress.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        takeMoneyButton.setBackgroundImage(UIImage(named: "Rectangle 6"), for: .normal)
        takeMoneyButton.contentHorizontalAlignment = .center
        
        let topStack = UIStackView(views: [exitButton,
                                           questionNumberLabel,
                                           showProgressButton],
                                   axis: .horizontal,
                                   spacing: 44)
        
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
                                              spacing: 15)
        
        let mainStack = UIStackView(views: [topStack,
                                            sumTotalLabel,
                                            timerProgress,
                                            questionTextLabel,
                                            helpButtonsStackView,
                                            answersButtonsStack,
                                            takeMoneyButton,
                                           ],
                                    axis: .vertical,
                                    spacing: 15)
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
            
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            
            timerProgress.topAnchor.constraint(equalTo: sumTotalLabel.bottomAnchor, constant: 20),
            timerProgress.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            timerProgress.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            
            questionTextLabel.heightAnchor.constraint(equalToConstant: 170),
            showProgressButton.heightAnchor.constraint(equalToConstant: 36),
            showProgressButton.widthAnchor.constraint(equalTo: showProgressButton.heightAnchor),
            exitButton.heightAnchor.constraint(equalToConstant: 40),
            exitButton.widthAnchor.constraint(equalTo: exitButton.heightAnchor)
        ])

        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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


