//
//  StartViewController.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class StartViewController: UIViewController {
    let mainView = StartView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        
        rules()
        start()
        
    }
    func rules() {
        let tap = UIAction { _ in
            print("переход в правила")
            
            let vc = RulesViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        mainView.rulesButton.addAction(tap, for: .touchUpInside)
    }
    
    func start() {
        let tap = UIAction { _ in
            print("переход на экран вопросов")
            
            let vc = GameViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        mainView.startButton.addAction(tap, for: .touchUpInside)
    }
}

