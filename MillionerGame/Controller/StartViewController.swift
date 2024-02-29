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
    //немного переделала функцию, чтобы правила появлялись не как отдельный экран. читала, что таким способом мы не перегружаем память, так после нажатия кнопки "назад" сцена удалется из памяти
    func rules() {
        let tap = UIAction { _ in
            print("переход в правила")
            
            let vc = RulesViewController()
            self.present(vc, animated: true)
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

