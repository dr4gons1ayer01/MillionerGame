//
//  Quiz.swift
//  MillionerGame
//
//  Created by Иван Семенов on 27.02.2024.
//

import Foundation

struct Quiz {
    var numQuestions = 0
    let questions: [Question]
    
    init() {
        let question1 = Question(questionText: "Как называется столица Франции?", 
                                 answers: [Answer(text: "Мадрид"), Answer(text: "Париж"), Answer(text: "Лондон"), Answer(text: "Берлин")], correctAnswerIndex: 1)
        let question2 = Question(questionText: "Сколько планет в Солнечной системе?", 
                                 answers: [Answer(text: "7"), Answer(text: "8"), Answer(text: "9"), Answer(text: "10")], correctAnswerIndex: 1)
        let question3 = Question(questionText: "Кто написал произведение 'Преступление и наказание'?", 
                                 answers: [Answer(text: "Лев Толстой"), Answer(text: "Иван Тургенев"), Answer(text: "Федор Достоевский"), Answer(text: "Александр Пушкин")], correctAnswerIndex: 2)
        let question4 = Question(questionText: "Как называется самая высокая гора в мире?", 
                                 answers: [Answer(text: "Эверест"), Answer(text: "Аконкагуа"), Answer(text: "Килиманджаро"), Answer(text: "Макинли")], correctAnswerIndex: 0)
        let question5 = Question(questionText: "Что из перечисленного является столицей России?", 
                                 answers: [Answer(text: "Киев"), Answer(text: "Минск"), Answer(text: "Москва"), Answer(text: "Казань")], correctAnswerIndex: 2)
        let question6 = Question(questionText: "Какое животное является символом США?", 
                                 answers: [Answer(text: "Орел"), Answer(text: "Медведь"), Answer(text: "Буйвол"), Answer(text: "Волк")], correctAnswerIndex: 0)
        let question7 = Question(questionText: "Какой газ является самым распространенным в атмосфере Земли?", 
                                 answers: [Answer(text: "Азот"), Answer(text: "Кислород"), Answer(text: "Углекислый газ"), Answer(text: "Аргон")], correctAnswerIndex: 0)
        let question8 = Question(questionText: "Что из перечисленного является сухопутным хищным млекопитающим?", 
                                 answers: [Answer(text: "Дельфин"), Answer(text: "Крокодил"), Answer(text: "Тигр"), Answer(text: "Акула")], correctAnswerIndex: 2)
        let question9 = Question(questionText: "Какая из перечисленных планет Солнечной системы самая большая?", 
                                 answers: [Answer(text: "Марс"), Answer(text: "Венера"), Answer(text: "Юпитер"), Answer(text: "Сатурн")], correctAnswerIndex: 2)
        let question10 = Question(questionText: "Как называется процесс воспроизводства клетки?", 
                                  answers: [Answer(text: "Митоз"), Answer(text: "Мейоз"), Answer(text: "Биосинтез"), Answer(text: "Деградация")], correctAnswerIndex: 0)
        
        self.questions = [question1, question2, question3, question4, question5, question6, question7, question8, question9, question10]
    }
    
    
    func getQuestion() -> String {
        questions[numQuestions].questionText
    }
    
    func getAnswers() -> [String] {
        questions[numQuestions].answers.map { $0.text }
    }
    
//    func getCorrectAnswer() -> Int {
//        questions[numQuestions].correctAnswerIndex
//    }
    
    func checkAnswer(_ answer: Int) -> Bool {
        answer == questions[numQuestions].correctAnswerIndex
    }
    
}



