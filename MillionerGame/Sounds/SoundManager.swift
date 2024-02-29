//
//  SoundManager.swift
//  MillionerGame
//
//  Created by Иван Семенов on 29.02.2024.
//

import AVFoundation
///звук через синглтон
class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?
    
    private init() {}
    
    func playSound(soundFileName: String) {
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    func stopSound() {
        player?.stop()
    }
}

