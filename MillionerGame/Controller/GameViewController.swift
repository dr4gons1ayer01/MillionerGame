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
    
    //пока что кнопки будут красными, когда их нельзя выбрать, когда Маша все отрисует, сделаем иначе
    func help5050Button() {
        let tap = UIAction { action in
            guard let button = action.sender as? UIButton else { return }
            
            var arrayOfButtons = [self.mainView.buttonAnswerA, 
                                  self.mainView.buttonAnswerB,
                                  self.mainView.buttonAnswerC,
                                  self.mainView.buttonAnswerD]
            
            let indexOfRight = self.quiz.getRightAnswerIndex()
            arrayOfButtons.remove(at: indexOfRight)
            arrayOfButtons.remove(at: Int.random(in: 0...3))
            arrayOfButtons[0].setTitle(nil, for: .normal)
            arrayOfButtons[1].setTitle(nil, for: .normal)
            
            button.backgroundColor = .red
            button.isEnabled = false
        }
        mainView.help5050Button.addAction(tap, for: .touchUpInside)
        
    }
    
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
            
            button.backgroundColor = .red
            button.isEnabled = false
            
        }
        mainView.helpPhoneButton.addAction(tap, for: .touchUpInside)
    }
    
    
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
    
            button.backgroundColor = .red
            button.isEnabled = false
            
        }
        mainView.helpHumansButton.addAction(tap, for: .touchUpInside)
    }
    
    func normalColor() {
        self.mainView.buttonAnswerA.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
        self.mainView.buttonAnswerB.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
        self.mainView.buttonAnswerC.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
        self.mainView.buttonAnswerD.setBackgroundImage(UIImage(named: "Rectangle 1"), for: .normal)
    }
    
    
    //TODO: таймер доделать
    
    
}


