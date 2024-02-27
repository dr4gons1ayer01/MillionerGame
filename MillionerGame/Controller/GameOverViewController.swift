//
//  GameOverViewController.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class GameOverViewController: UIViewController {
    
    private let gameOverView: GameOverView
    
    init(questionNumber: Int, milestone: String? = nil) {
        gameOverView = GameOverView(questionNumber: questionNumber, milestone: milestone)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        //Назначаем действие для вью по нажатию кнопки рестарт
        gameOverView.onTap = restart
        view = gameOverView
    }
    
    private func restart() {
        navigationController?.popToRootViewController(animated: true)
    }
}
