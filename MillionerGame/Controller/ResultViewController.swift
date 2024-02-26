//
//  ResultViewController.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class ResultViewController: UIViewController {
    
    private let resultView: ResultView
    
    init(questionNumber: Int, isCorrectAnswer: Bool) {
        resultView = ResultView(questionNumber: questionNumber, isCorrectAnswer: isCorrectAnswer)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view = resultView
    }
    
}
