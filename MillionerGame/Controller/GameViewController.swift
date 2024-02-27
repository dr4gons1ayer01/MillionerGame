//
//  GameViewController.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    let mainView = GameView()
    let quiz = Quiz()
    var player: AVAudioPlayer!
    var countdownTimer: Timer?      //время обратного отсчета
    var reminingTime: Int = 0       //оставшееся время
    var selectedTime: Int?          //выбранное время для прогрессВью
    var correctAnswerIndex: Int = 0 //правильный ответ
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        
        updateUI()
        playSound(soundFileName: "zvukChasov")
        exitButtonTapped()
        takeMoneyButtonTapped()
    }
    func updateUI() {
        let currentQuestion = quiz.questions[quiz.numQuestions]
        mainView.questionTextLabel.text = currentQuestion.questionText
        mainView.buttonAnswerA.setTitle("A: \(currentQuestion.answers[0].text)", for: .normal)
        mainView.buttonAnswerB.setTitle("B: \(currentQuestion.answers[1].text)", for: .normal)
        mainView.buttonAnswerC.setTitle("C: \(currentQuestion.answers[2].text)", for: .normal)
        mainView.buttonAnswerD.setTitle("D: \(currentQuestion.answers[3].text)", for: .normal)
        
    }
    //TODO: - прописать обработчики кнопок
    func checkAnswer(_ selectedAnswerIndex: Int) {
        let currentQuestion = quiz.questions[quiz.numQuestions]
        if selectedAnswerIndex == currentQuestion.correctAnswerIndex {
            print("Верный ответ!")
            
        } else {
            print("Неверный ответ!")
            
        }
    }
    //TODO: - прописать обработчики кнопок
    
    
    
    
    
    func exitButtonTapped() {
        let tap = UIAction { _ in
            
            
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        mainView.exitButton.addAction(tap, for: .touchUpInside)
    }
    
    func takeMoneyButtonTapped() {
        let tap = UIAction { _ in
            print("take money")
            
            let vc = ResultViewController(questionNumber: 3, isCorrectAnswer: true)
            self.present(vc, animated: true, completion: nil)
        }
        mainView.takeMoneyButton.addAction(tap, for: .touchUpInside)
    }

    func playSound(soundFileName: String) {
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else { return }
        player = try? AVAudioPlayer(contentsOf: url)
        player.play()

    }
    
    //TODO: таймер доделать
    func startTimer(for time: Int) {
        countdownTimer?.invalidate()
        reminingTime = time
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        
    }
}
