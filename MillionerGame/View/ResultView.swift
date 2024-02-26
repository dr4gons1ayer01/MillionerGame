//
//  ResultView.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class ResultView: UIView, UITableViewDataSource {

    private let questionNumber: Int
    private let isCorrectAnswer: Bool
    
    private let sums = ["100 RUB", "200 RUB", "300 RUB", "500 RUB", "1000 RUB", "2000 RUB", "4000 RUB", "8000 RUB", "16000 RUB", "32000 RUB", "64000 RUB", "125000 RUB", "250000 RUB", "500000 RUB", "1 миллион"]
    private let milestoneSums = ["1000 RUB", "32000 RUB", "1 миллион"]
    
    private let background = UIImageView()
    private let logo = UIImageView()
    private let tableView = UITableView(frame: CGRect(), style: .plain)
    
    init(questionNumber: Int, isCorrectAnswer: Bool) {
        self.questionNumber = questionNumber
        self.isCorrectAnswer = isCorrectAnswer
        super.init(frame: .zero)
        setupUI()
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
        tableView.rowHeight = 42
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 42
        
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
        sums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultTableViewCell
        let isMilestone: Bool = {
            milestoneSums.contains(sums[indexPath.row])
        }()
        cell.setupUI(cellTotal: sums.count, questionNumber: questionNumber, rowNumber: indexPath.row, isCorrect: isCorrectAnswer, isMilestoneSum: isMilestone, sum: sums[sums.count - (indexPath.row + 1)])
        
        return cell
    }
    
}
