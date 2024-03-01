//
//  GameOverView.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class GameOverView: UIView {
    
    ///Действие по тапу на кнопку рестарта игры
    var onTap: (() -> Void)?
    
    private let questionIndex: Int
    ///Несгораемая сумма для экрана 'Game Over', если она была достигнута
    private var milestone: String?
    private let wonMillion: Bool

    private let background = UIImageView(image: UIImage(named: "bg")!)
    private let logo = UIImageView()
    private let gameOverLabel = UILabel(text: "ИГРА ЗАКОНЧЕНА")
    private let milestoneLabel = UILabel()
    private let emojiLabel = UILabel()
    
    private var loseLabel: UILabel {
        let label = UILabel()
        label.text = "Проигрыш на \(questionIndex + 1) вопросе"
        label.font = UIFont(name: "Gilroy-Bold", size: 20)
        label.textColor = .white
        return label
    }

    private let restartButton = UIButton(text: "Играть заново", alignment: .center)
    
    init(questionIndex: Int) {
        self.questionIndex = questionIndex
        self.milestone = Quiz.lastMilestone
        self.wonMillion = {Quiz.lastMilestone == "1 миллион"}()
        super.init(frame: .zero)
        setupUI()
    }
    
    private func setupUI() {

        background.contentMode = .scaleAspectFill
        
        logo.image = UIImage(imageLiteralResourceName: "logo")
        logo.contentMode = .scaleAspectFit
        
        gameOverLabel.font = UIFont(name: "Gilroy-Bold", size: 38)
        emojiLabel.font = .systemFont(ofSize: 250)
        
        loseLabel.font = UIFont(name: "Gilroy-Regular", size: 20)
        
        restartButton.setBackgroundImage(UIImage(named: "Rectangle 3"), for: .normal)
        ///нажатие я бы в контроллер убрал
        restartButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
        
        //Проверяем, была ли достигнута несгораемая сумма, и в зависимости от этого показываем/не показываем текст с выигрышем и соответсвующим эмодзи
        if let milestone = milestone {
            milestoneLabel.text = "Вы выиграли \(milestone)!"
            milestoneLabel.textColor = .white
            emojiLabel.text = "💰"
        } else {
            milestoneLabel.isHidden = true
            emojiLabel.text = "😓"
        }
        
        //UI если выиграл миллион
        if wonMillion {
            gameOverLabel.text = "Поздравляем!"
            milestoneLabel.text = "Вы выиграли миллион!"
            loseLabel.text = "Все вопросы отвечены верно"
        }
        
        let mainStack = UIStackView(views: [logo,
                                            gameOverLabel,
                                            milestoneLabel,
                                            emojiLabel,
                                            loseLabel,
                                            restartButton,
                                           ],
                                    axis: .vertical,
                                    spacing: 15)
        
        addSubview(background)
        addSubview(mainStack)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            
//            logo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
//            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
//            logo.widthAnchor.constraint(equalToConstant: 180),
//            logo.heightAnchor.constraint(equalTo: logo.widthAnchor),
//            gameOverLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
//            gameOverLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 34),
//            gameOverLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -34),
//            milestoneLabel.topAnchor.constraint(equalTo: gameOverLabel.bottomAnchor, constant: 10),
//            milestoneLabel.leadingAnchor.constraint(equalTo: gameOverLabel.leadingAnchor),
//            milestoneLabel.trailingAnchor.constraint(equalTo: gameOverLabel.trailingAnchor),
//            emojiLabel.topAnchor.constraint(equalTo: milestoneLabel.bottomAnchor, constant: 10),
//            emojiLabel.leadingAnchor.constraint(equalTo: milestoneLabel.leadingAnchor),
//            emojiLabel.trailingAnchor.constraint(equalTo: milestoneLabel.trailingAnchor),
//            restartButton.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20),
//            restartButton.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20),
//            restartButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            loseLabel.bottomAnchor.constraint(equalTo: restartButton.topAnchor, constant: -10),
//            loseLabel.leadingAnchor.constraint(equalTo: emojiLabel.leadingAnchor),
//            loseLabel.trailingAnchor.constraint(equalTo: emojiLabel.trailingAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Действие по тапу на кнопку рестарта игры
    @objc private func restartTapped(_ sender: UIButton) {
        onTap?()
    }
}
import SwiftUI
struct GameOverViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = GameOverView(questionIndex: 0)
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
