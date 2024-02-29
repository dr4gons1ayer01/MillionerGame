//
//  ResultViewController.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class ResultViewController: UIViewController {
    
    private let questionIndex: Int
    private let isCorrectAnswer: Bool
    private let resultView: ResultView
    private var wonMillion = false
    
    init(questionNumber: Int, isCorrectAnswer: Bool) {
        self.questionIndex = questionNumber - 1
        self.isCorrectAnswer = isCorrectAnswer
        resultView = ResultView(questionIndex: questionIndex, isCorrectAnswer: isCorrectAnswer)
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
        if isCorrectAnswer {
            SoundManager.shared.playSound(soundFileName: "otvetVernyiy")
        } else {
            SoundManager.shared.playSound(soundFileName: "zvukNepravilnogo")
        }
    }
    ///остановка звука по закрытии вью
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SoundManager.shared.stopSound()
    }

    private func quitResults(milestone: String?) {
        if isCorrectAnswer {
            //Если последний вопрос на миллион и ответ верный
            print("переход на экран 'Game Over', выиграл 1млн")
            if questionIndex == 14 {
                wonMillion = true
                ///
                let vc = GameOverViewController(questionIndex: questionIndex, milestone: milestone, wonMillion: wonMillion)
                navigationController?.pushViewController(vc, animated: true)
                
            } else {
                //Если ответ верный, игра продолжается, возвращаемся на GameVC
                print("возврат на экран вопросов, следующий вопрос")
                navigationController?.popViewController(animated: true)
            }
        } else {
            //Если ответ неверный, пушим GameOverVC
            print("переход на экран 'Game Over")
            ///
            let vc = GameOverViewController(questionIndex: questionIndex, milestone: milestone, wonMillion: wonMillion)
            navigationController?.pushViewController(vc, animated: true)
            resultView.restartResults()
        }
    }
    
}

