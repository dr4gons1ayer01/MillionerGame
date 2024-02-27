//
//  GameViewController.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

import UIKit

class GameViewController: UIViewController {
    let mainView = GameView()
    let quiz = Quiz()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        
        
    }
    func updateUI() {
        
        
    }
}
