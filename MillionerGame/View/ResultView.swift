//
//  ResultView.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class ResultView: UIView, UITableViewDataSource {
    
    ///Переход на другой экран по закрытию экрана с результатами в зависимости от правильности ответа
    var nextVC: ((_ milestone: String?) -> Void)?
    private let quiz = Quiz()
    private let questionIndex: Int
    private let isCorrectAnswer: Bool
    
    
    ///Хранит последнюю несгораемую сумму, если она была достигнута
    private static var lastMilestone: String?
    
    private let background = UIImageView()
    private let logo = UIImageView()
    private let tableView = UITableView(frame: CGRect(), style: .plain)
    
    init(questionIndex: Int, isCorrectAnswer: Bool) {
        self.questionIndex = questionIndex
        self.isCorrectAnswer = isCorrectAnswer
        super.init(frame: .zero)
        //Сохраняем несгораемую сумму, если она была достигнута
        if quiz.milestoneSums.contains(quiz.sums.map { $0.value }[questionIndex]) && isCorrectAnswer {
            ResultView.lastMilestone = quiz.sums[questionIndex]
        }
        setupUI()
        
        //Тут пока временно сделала автоматическое закрытие экрана результатов и перехода на следующий экран через 5 секунд (время проигрывания звука верного/неверного ответа)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            //Передаем в замыкание выхода с экрана результатов последнюю достигнутую несгораемую сумму, если она была достигнута. Для ее дальнейшей передачи и отображения на экране 'Game Over'
            self?.nextVC?(ResultView.lastMilestone)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.rowHeight = tableView.bounds.height / CGFloat(tableView.numberOfRows(inSection: 0))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        background.image = UIImage(imageLiteralResourceName: "bg")
        background.contentMode = .scaleAspectFill
        
        logo.image = UIImage(imageLiteralResourceName: "logo")
        logo.contentMode = .scaleAspectFit
        
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        addSubview(background)
        addSubview(logo)
        addSubview(tableView)
        subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            logo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 80),
            logo.heightAnchor.constraint(equalTo: logo.widthAnchor),
            tableView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 34),
            tableView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -34),
            tableView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -34)
        ])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quiz.sums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultTableViewCell
        let sortedSums = quiz.sums.sorted { $0.key < $1.key }
        let isMilestone: Bool = {
            quiz.milestoneSums.contains(sortedSums.map { $0.value }.reversed()[indexPath.row])
        }()
        cell.setupUI(cellTotal: quiz.sums.count, questionIndex: questionIndex, rowNumber: indexPath.row, isCorrect: isCorrectAnswer, isMilestoneSum: isMilestone, sum: sortedSums.map { $0.value }.reversed()[indexPath.row])
        
        return cell
    }
    
    ///Сбрасывает хранимую несгораемую сумму для начала новой игры
    func restartResults() {
        ResultView.lastMilestone = nil
    }
    
}

