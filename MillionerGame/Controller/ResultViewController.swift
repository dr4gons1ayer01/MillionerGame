//
//  ResultViewController.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class ResultViewController: UIViewController {
    
    private let questionIndex: Int
    private let isCorrectAnswer: Bool?
    private let resultView: ResultView
    var dismissProgress: (() -> Void)?

    init(questionNumber: Int, isCorrectAnswer: Bool? = nil) {

//     init(questionNumber: Int, isCorrectAnswer: Bool) {

        self.questionIndex = questionNumber - 2
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
        setup()
        
    }
    
    private func quitResults() {
        guard let isCorrectAnswer else { return }
        if isCorrectAnswer {
            if questionIndex == 14 {
                //Если последний вопрос на миллион и ответ верный
                print("переход на экран 'Game Over', выиграл 1млн")
                let vc = GameOverViewController(questionIndex: questionIndex)
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
            let vc = GameOverViewController(questionIndex: questionIndex)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func closeProgress() {
        //Просто закрываем экран прогресса и возвращаемся на game vc
        print("возврат на экран вопросов из таблицы с просмотром прогресса")
        dismissProgress?()
    }
    
    private func setup() {
        view = resultView
        resultView.closeProgress = closeProgress
        guard let isCorrectAnswer else { return }
        ////Назначаем для вью логику перехода на другой экран по закрытию экрана с результатами в зависимости от правильности ответа
        resultView.nextVC = quitResults
        //убираю чтобы музыка играла из гейм и добавил смену бегрануда кнопки с неправ ответом
//        if isCorrectAnswer {
//            SoundManager.shared.playSound(soundFileName: "otvetVernyiy")
//        } else {
//            SoundManager.shared.playSound(soundFileName: "zvukNepravilnogo")
//        }
    }
    
}

