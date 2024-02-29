//
//  GameViewController.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class GameViewController: UIViewController {
    let mainView = GameView()
    var quiz = Quiz()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        //вот это перенесла из viewDidLoad сюда, чтобы вопросы обновлялись после возврата с экрана с таблицей со всеми вопросами
        updateQuestionAndSum()
        SoundManager.shared.playSound(soundFileName: "zvukChasov")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        quiz.restartGame()
        
        answerButtonsTapped()
        exitButtonTapped()
        showProgressButtonTapped()
        takeMoneyButtonTapped()
    }
    
    ///обновление вопросов и сумм
    func updateQuestionAndSum() {
        mainView.questionTextLabel.text = quiz.getQuestion()
        mainView.buttonAnswerA.setTitle(quiz.getAnswers()[0], for: .normal)
        mainView.buttonAnswerB.setTitle(quiz.getAnswers()[1], for: .normal)
        mainView.buttonAnswerC.setTitle(quiz.getAnswers()[2], for: .normal)
        mainView.buttonAnswerD.setTitle(quiz.getAnswers()[3], for: .normal)
        mainView.questionNumberLabel.text = "Вопрос \(quiz.currentQuestionNumber)/\(Quiz.sums.count)"
        mainView.sumTotalLabel.text = Quiz.sums[quiz.currentQuestionNumber]!
    }
    //TODO: - дописать
    func answerButtonsTapped() {
        let tap = UIAction { action in
            guard let button = action.sender as? UIButton else { return }
            
            let answerIndex: Int
            switch button {
            case self.mainView.buttonAnswerA:
                answerIndex = 0
            case self.mainView.buttonAnswerB:
                answerIndex = 1
            case self.mainView.buttonAnswerC:
                answerIndex = 2
            case self.mainView.buttonAnswerD:
                answerIndex = 3
            default:
                return
            }
            
            let isCorrectAnswer = self.quiz.checkAnswer(answerIndex)
            if isCorrectAnswer {
                print("Верный ответ!")
                ///
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.updateQuestionAndSum()
                    SoundManager.shared.stopSound()
                    let vc = ResultViewController(questionNumber: self.quiz.currentQuestionNumber, isCorrectAnswer: true)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                SoundManager.shared.playSound(soundFileName: "otvetPrinyat")
                
            } else {
                print("Неверный ответ!")
                ///
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    SoundManager.shared.stopSound()
                    let vc = ResultViewController(questionNumber: self.quiz.currentQuestionNumber, isCorrectAnswer: false)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                SoundManager.shared.playSound(soundFileName: "otvetPrinyat")
            }
        }
        mainView.buttonAnswerA.addAction(tap, for: .touchUpInside)
        mainView.buttonAnswerB.addAction(tap, for: .touchUpInside)
        mainView.buttonAnswerC.addAction(tap, for: .touchUpInside)
        mainView.buttonAnswerD.addAction(tap, for: .touchUpInside)
    }
    
    
    func exitButtonTapped() {
        let tap = UIAction { _ in
            //TODO: -  По желанию можно алерт сделать
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        mainView.exitButton.addAction(tap, for: .touchUpInside)
    }
    
    func showProgressButtonTapped() {
        let tap = UIAction { _ in
            print("show progress")
            let vc = ResultViewController(questionNumber: self.quiz.currentQuestionNumber)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        mainView.showProgressButton.addAction(tap, for: .touchUpInside)
    }
    
    func takeMoneyButtonTapped() {
        let tap = UIAction { _ in
            print("take money")
            let vc = GameOverViewController(questionIndex: self.quiz.currentQuestionNumber - 1)
            self.navigationController?.pushViewController(vc, animated: true)
            SoundManager.shared.stopSound()
        }
        
        mainView.takeMoneyButton.addAction(tap, for: .touchUpInside)
    }
    
    
    
    //TODO: таймер доделать
    
    
}


