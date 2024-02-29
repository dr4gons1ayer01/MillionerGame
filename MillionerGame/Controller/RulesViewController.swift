//
//  RulesViewController.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class RulesViewController: UIViewController {
    let mainView = RulesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        back()
        view = mainView
    }
    
    func back() {
        let tap = UIAction { _ in
            print("переход на главный экран")
            
            self.dismiss(animated: true)
        }
        mainView.homeButton.addAction(tap, for: .touchUpInside)
        
    }
}
