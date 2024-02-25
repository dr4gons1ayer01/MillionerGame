//
//  GameView.swift
//  MillionerGame
//
//  Created by Иван Семенов on 25.02.2024.
//

class GameView: UIView {
    let label = UILabel()
    
    init() {
        super.init(frame: CGRect())
        setupUI()
        
    }
    func setupUI() {
        backgroundColor = .white
        label.text = "Экран с 4мя вопросами"
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
import SwiftUI

struct GameViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = GameView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
