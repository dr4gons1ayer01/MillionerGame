//
//  Question.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import Foundation

struct Question {
    let questionText: String
    let answers: [Answer]
    let correctAnswerIndex: Int
}

struct Answer {
    let text: String
}
