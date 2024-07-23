//
//  AddItemSound.swift
//  ElderCalculator
//
//  Created by James Cellars on 16/07/24.
//

import AVFoundation
import UIKit

class AddItemSound {
    static let shared = AddItemSound()
    private var player: AVAudioPlayer?
    
    private init() {}
    
    func playSound( named soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Failed to find sound file")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound: \(error)")
        }
    }
    
    func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
//        print("Light haptic feedback occurred")
    }
}
