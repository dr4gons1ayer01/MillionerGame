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
    var timer = Timer()
    var secondTotal = 5
    var secondPassed = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        //вот это перенесла из viewDidLoad сюда, чтобы вопросы обновлялись после возврата с экрана с таблицей со всеми вопросами
        //но он не обновляет сейчас ))) метод отрабатывает, но в этом методе setupUI после первой его отработки дальше другие данные в mainView не сетятся
        
        updateQuestionAndSum()
        SoundManager.shared.playSound(soundFileName: "zvukChasov")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        
        
        answerButtonsTapped()
        exitButtonTapped()
        takeMoneyButtonTapped()
    }
    
    ///обновление вопросов и сумм
    func updateQuestionAndSum() {
        mainView.questionTextLabel.text = quiz.getQuestion()
        mainView.buttonAnswerA.setTitle(quiz.getAnswers()[0], for: .normal)
        mainView.buttonAnswerB.setTitle(quiz.getAnswers()[1], for: .normal)
        mainView.buttonAnswerC.setTitle(quiz.getAnswers()[2], for: .normal)
        mainView.buttonAnswerD.setTitle(quiz.getAnswers()[3], for: .normal)
        mainView.questionNumberLabel.text = "Вопрос \(quiz.currentQuestionNumber)/15"
        mainView.sumTotalLabel.text = quiz.sums[quiz.currentQuestionNumber]!
        
    }
    //TODO: - дописать
    func answerButtonsTapped() {
        
        let tap = UIAction { action in
           
            guard let button = action.sender as? UIButton else { return }
            //смена цвета при выборе ответа
            button.setBackgroundImage(UIImage(named: "Rectangle 4"), for: .normal)
            self.updateTimer()
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
                    button.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
                }
                SoundManager.shared.playSound(soundFileName: "otvetPrinyat")
                
            } else {
             
                print("Неверный ответ!")
                ///
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    SoundManager.shared.stopSound()
                    let vc = ResultViewController(questionNumber: self.quiz.currentQuestionNumber, isCorrectAnswer: false)
                    self.navigationController?.pushViewController(vc, animated: true)
                    button.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
                }
                SoundManager.shared.playSound(soundFileName: "otvetPrinyat")
                
            }
            //сбрасываем таймер
            self.secondPassed = 0
            self.timer.invalidate()
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
    
    func takeMoneyButtonTapped() {
        let tap = UIAction { _ in
            print("take money")
            //тут получается после выбора ответа и интригующей музыки на 5 секунд должен быть пуш на vc результатов, он оттуда сделает поп обратно через 5 секунд, если ответ верный, или запушит уже гейм овер vc
            //нужно correctAnswer прокинуть сюда
            
            //TODO: я как понимаю здесь можно посмотреть текущий прогресс, показ ResultView без музыки
            let vc = ResultViewController(questionNumber: self.quiz.currentQuestionNumber, isCorrectAnswer: true)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        mainView.takeMoneyButton.addAction(tap, for: .touchUpInside)
    }
    
    @objc func updateTimer() {
        if secondPassed < secondTotal {
            secondPassed += 1
            let percentageProgress = Float(secondPassed) / Float(secondTotal)
            mainView.timerProgress.setProgress(percentageProgress, animated: true)
        } else {
            SoundManager.shared.playSound(soundFileName: "zvukNepravilnogo")
            timer.invalidate()
            secondPassed = 0
            let vc = GameOverViewController(questionIndex: 0, milestone: "0" , wonMillion: false)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}


