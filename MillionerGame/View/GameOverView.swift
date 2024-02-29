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
    private let milestone: String?
    private let wonMillion: Bool
    
    private let background = UIImageView()
    private let logo = UIImageView()
    private let gameOverLabel = UILabel()
    private let milestoneLabel = UILabel()
    private let emojiLabel = UILabel()
    private let loseLabel = UILabel()
    private let restartButton = UIButton(title: "Play again", bg: .systemGreen)
    
    init(questionIndex: Int) {
        self.questionIndex = questionIndex
        self.milestone = Quiz.lastMilestone
        self.wonMillion = {Quiz.lastMilestone == "1 миллион"}()
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        background.image = UIImage(imageLiteralResourceName: "bg")
        background.contentMode = .scaleAspectFill
        
        logo.image = UIImage(imageLiteralResourceName: "logo")
        logo.contentMode = .scaleAspectFit
        
        gameOverLabel.font = UIFont(name: "Gilroy-Bold", size: 38)
        gameOverLabel.textColor = .white
        gameOverLabel.textAlignment = .center
        gameOverLabel.text = "Game Over"
        
        milestoneLabel.font = UIFont(name: "Gilroy-Regular", size: 25)
        milestoneLabel.textColor = .white
        milestoneLabel.textAlignment = .center
        
        emojiLabel.font = .systemFont(ofSize: 300)
        emojiLabel.textColor = .white
        emojiLabel.textAlignment = .center
        
        restartButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
        
        //Проверяем, была ли достигнута несгораемая сумма, и в зависимости от этого показываем/не показываем текст с выигрышем и соответсвующим эмодзи
        if let milestone = milestone {
            milestoneLabel.text = "You won \(milestone)!"
            emojiLabel.text = "💰"
        } else {
            milestoneLabel.isHidden = true
            emojiLabel.text = "😓"
        }
        
        loseLabel.font = UIFont(name: "Gilroy-Regular", size: 20)
        loseLabel.textColor = .white
        loseLabel.textAlignment = .center
        loseLabel.text = "Losed on \(String(questionIndex + 1)) question"
        
        //UI если выиграл миллион
        if wonMillion {
            gameOverLabel.text = "Congratulations!"
            milestoneLabel.text = "You won 1 millon!"
            loseLabel.text = "Answered all the questions!"
        }
        
        addSubview(background)
        addSubview(logo)
        addSubview(gameOverLabel)
        addSubview(milestoneLabel)
        addSubview(emojiLabel)
        addSubview(loseLabel)
        addSubview(restartButton)
        subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            logo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 180),
            logo.heightAnchor.constraint(equalTo: logo.widthAnchor),
            gameOverLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            gameOverLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 34),
            gameOverLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -34),
            milestoneLabel.topAnchor.constraint(equalTo: gameOverLabel.bottomAnchor, constant: 10),
            milestoneLabel.leadingAnchor.constraint(equalTo: gameOverLabel.leadingAnchor),
            milestoneLabel.trailingAnchor.constraint(equalTo: gameOverLabel.trailingAnchor),
            emojiLabel.topAnchor.constraint(equalTo: milestoneLabel.bottomAnchor, constant: 10),
            emojiLabel.leadingAnchor.constraint(equalTo: milestoneLabel.leadingAnchor),
            emojiLabel.trailingAnchor.constraint(equalTo: milestoneLabel.trailingAnchor),
            restartButton.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20),
            restartButton.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20),
            restartButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            loseLabel.bottomAnchor.constraint(equalTo: restartButton.topAnchor, constant: -10),
            loseLabel.leadingAnchor.constraint(equalTo: emojiLabel.leadingAnchor),
            loseLabel.trailingAnchor.constraint(equalTo: emojiLabel.trailingAnchor)
        ])
    }
    
    ///Действие по тапу на кнопку рестарта игры
    @objc private func restartTapped(_ sender: UIButton) {
        onTap?()
    }
}
