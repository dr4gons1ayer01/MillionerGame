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
    var secondTotal = 10
    var secondPassed = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        updateQuestionAndSum()
        SoundManager.shared.playSound(soundFileName: "zvukChasov")
        startTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        quiz.restartGame()
        
        answerButtonsTapped()
        exitButtonTapped()
        showProgressButtonTapped()
        takeMoneyButtonTapped()
        
        help5050Button()
        helpPhoneButton()
        helpHumansButton()
        
    }
    ///обновление вопросов и сумм
    func updateQuestionAndSum() {
        mainView.questionTextLabel.text = quiz.getQuestion()
        mainView.buttonAnswerA.setTitle(quiz.getAnswers()[0], for: .normal)
        mainView.buttonAnswerB.setTitle(quiz.getAnswers()[1], for: .normal)
        mainView.buttonAnswerC.setTitle(quiz.getAnswers()[2], for: .normal)
        mainView.buttonAnswerD.setTitle(quiz.getAnswers()[3], for: .normal)
        normalColor()
        mainView.questionNumberLabel.text = "Вопрос \(quiz.currentQuestionNumber)/\(Quiz.sums.count)"
        mainView.sumTotalLabel.text = Quiz.sums[quiz.currentQuestionNumber]!
    }
    //TODO: - дописать
    func answerButtonsTapped() {
        let tap = UIAction { action in
            
            guard let button = action.sender as? UIButton else { return }
            ///смена цвета при выборе ответа
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
                /// подстветка зеленым при правильно ответе
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    SoundManager.shared.playSound(soundFileName: "otvetVernyiy")
                    button.setBackgroundImage(UIImage(named: "Rectangle 3"), for: .normal)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    self.updateQuestionAndSum()
                    //SoundManager.shared.stopSound()
                    let vc = ResultViewController(questionNumber: self.quiz.currentQuestionNumber, isCorrectAnswer: true)
                    self.navigationController?.pushViewController(vc, animated: true)
                    button.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
                }
                SoundManager.shared.playSound(soundFileName: "otvetPrinyat")
                
            } else {
                
                print("Неверный ответ!")
                ///
                ///
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                SoundManager.shared.playSound(soundFileName: "zvukNepravilnogo")
                button.setBackgroundImage(UIImage(named: "Rectangle 5"), for: .normal)
            }
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    //SoundManager.shared.stopSound()
                    let vc = ResultViewController(questionNumber: self.quiz.currentQuestionNumber, isCorrectAnswer: false)
                    self.navigationController?.pushViewController(vc, animated: true)
                    button.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
                }
                SoundManager.shared.playSound(soundFileName: "otvetPrinyat")
                
            }
            ///сбрасываем таймер
//            self.secondPassed = 0
//            self.timer.invalidate()
            self.stopTimer(stopSound: false)
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
            SoundManager.shared.stopSound()
        }
        mainView.exitButton.addAction(tap, for: .touchUpInside)
    }
    
    func showProgressButtonTapped() {
        let tap = UIAction { _ in
            print("show progress")
            let vc = ResultViewController(questionNumber: self.quiz.currentQuestionNumber)
            vc.dismissProgress = {self.dismiss(animated: true)}
            self.present(vc, animated: true)
        }
        mainView.showProgressButton.addAction(tap, for: .touchUpInside)
    }
    //TODO: - доделать
    func takeMoneyButtonTapped() {
        let tap = UIAction { _ in
            print("take money")
            self.straightToGameOver()
            self.stopTimer(stopSound: true)
        }
        
        mainView.takeMoneyButton.addAction(tap, for: .touchUpInside)
    }
    ///
    func help5050Button() {
        let tap = UIAction { action in
            guard let button = action.sender as? UIButton else { return }
            
            var arrayOfButtons = [self.mainView.buttonAnswerA,
                                  self.mainView.buttonAnswerB,
                                  self.mainView.buttonAnswerC,
                                  self.mainView.buttonAnswerD]
            
            let indexOfRight = self.quiz.getRightAnswerIndex()
            arrayOfButtons.remove(at: indexOfRight)
            arrayOfButtons[0].setTitle(nil, for: .normal)
            arrayOfButtons[1].setTitle(nil, for: .normal)
            
            button.setImage(UIImage(named: "5050_off"), for: .normal)
            button.isEnabled = false
        }
        mainView.help5050Button.addAction(tap, for: .touchUpInside)
        
    }
    ///
    func helpPhoneButton() {
        let tap = UIAction { action in
            guard let button = action.sender as? UIButton else { return }
            
            var arrayOfButtons = [self.mainView.buttonAnswerA,
                                  self.mainView.buttonAnswerB,
                                  self.mainView.buttonAnswerC,
                                  self.mainView.buttonAnswerD]
            
            let indexOfRight = self.quiz.getRightAnswerIndex()
            let probability = Int.random(in: 1...100)
            
            switch probability {
            case 1...70:
                arrayOfButtons[indexOfRight].setBackgroundImage(UIImage(named: "Rectangle 2"), for: .normal)
            default:
                arrayOfButtons.remove(at: indexOfRight)
                arrayOfButtons[Int.random(in: 0...2)].setBackgroundImage(UIImage(named: "Rectangle 2"), for: .normal)
            }
            button.setImage(UIImage(named: "call_off"), for: .normal)
            button.isEnabled = false
            
        }
        mainView.helpPhoneButton.addAction(tap, for: .touchUpInside)
    }
    ///
    func helpHumansButton() {
        let tap = UIAction { action in
            guard let button = action.sender as? UIButton else { return }
            
            var arrayOfButtons = [self.mainView.buttonAnswerA, self.mainView.buttonAnswerB, self.mainView.buttonAnswerC, self.mainView.buttonAnswerD]
            let indexOfRight = self.quiz.getRightAnswerIndex()
            let probability = Int.random(in: 1...100)
            switch probability {
            case 1...80:
                arrayOfButtons[indexOfRight].setBackgroundImage(UIImage(named: "Rectangle 2"), for: .normal)
            default:
                arrayOfButtons.remove(at: indexOfRight)
                arrayOfButtons[Int.random(in: 0...2)].setBackgroundImage(UIImage(named: "Rectangle 2"), for: .normal)
            }
            button.setImage(UIImage(named: "people_off"), for: .normal)
            button.isEnabled = false
            
        }
        mainView.helpHumansButton.addAction(tap, for: .touchUpInside)
    }
    ///
    func normalColor() {
        self.mainView.buttonAnswerA.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
        self.mainView.buttonAnswerB.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
        self.mainView.buttonAnswerC.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
        self.mainView.buttonAnswerD.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
    }
    ///старт таймера
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    ///обновляем таймер
    @objc func updateTimer() {
        if secondPassed < secondTotal {
            secondPassed += 1
            let percentageProgress = Float(secondPassed) / Float(secondTotal)
            mainView.timerProgress.setProgress(percentageProgress, animated: true)
        } else {
            SoundManager.shared.stopSound()
            SoundManager.shared.playSound(soundFileName: "budilnik")
            timer.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.straightToGameOver()
                self?.secondPassed = 0
            }
        }
    }
    
    func straightToGameOver() {
        let vc = GameOverViewController(questionIndex: self.quiz.currentQuestionNumber - 1)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func stopTimer(stopSound: Bool) {
        timer.invalidate()
        secondPassed = 0
        if stopSound == true {
            SoundManager.shared.stopSound()
        }
    }
    
}




