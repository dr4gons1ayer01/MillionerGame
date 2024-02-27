//
//  ResultViewController.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class ResultViewController: UIViewController {
    
    private let questionNumber: Int
    private let isCorrectAnswer: Bool
    private let resultView: ResultView
    
    init(questionNumber: Int, isCorrectAnswer: Bool) {
        self.questionNumber = questionNumber
        self.isCorrectAnswer = isCorrectAnswer
        resultView = ResultView(questionNumber: questionNumber, isCorrectAnswer: isCorrectAnswer)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        ////Назначаем для вью логику перехода на другой экран по закрытию экрана с результатами в зависимости от правильности ответа
        resultView.nextVC = quitResults(milestone:)
        view = resultView
    }
    
    private func quitResults(milestone: String?) {
        if isCorrectAnswer {
            print("переход на экран следующего вопроса")
            navigationController?.pushViewController(GameViewController(), animated: true)
        } else {
            print("возврат на начальный экран, рестарт игры")
            navigationController?.pushViewController(GameOverViewController(questionNumber: questionNumber, milestone: milestone), animated: true)
            resultView.restartResults()
        }
    }
    
}
