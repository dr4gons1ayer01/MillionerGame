//
//  ResultViewController.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit
import AVFoundation

class ResultViewController: UIViewController {
    
    private let questionIndex: Int
    private let isCorrectAnswer: Bool
    private let resultView: ResultView
    private var wonMillion = false
    private var player: AVAudioPlayer!
    
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
            playSound(soundFileName: "otvetVernyiy")
        } else {
            playSound(soundFileName: "zvukNepravilnogo")
        }
        
    }
    
    private func quitResults(milestone: String?) {
        if isCorrectAnswer {
            //Если последний вопрос на миллион и ответ верный
            print("переход на экран 'Game Over', выиграл 1млн")
            if questionIndex == 14 {
                wonMillion = true
                navigationController?.pushViewController(GameOverViewController(questionIndex: questionIndex, milestone: milestone, wonMillion: wonMillion), animated: true)
            } else {
                //Если ответ верный, игра продолжается, возвращаемся на GameVC
                print("возврат на экран вопросов, следующий вопрос")
                navigationController?.popViewController(animated: true)
            }
        } else {
            //Если ответ неверный, пушим GameOverVC
            print("переход на экран 'Game Over'")
            navigationController?.pushViewController(GameOverViewController(questionIndex: questionIndex, milestone: milestone, wonMillion: wonMillion), animated: true)
            resultView.restartResults()
        }
    }
    
    private func playSound(soundFileName: String) {
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else { return }
        player = try? AVAudioPlayer(contentsOf: url)
        player.play()

    }
    
}
