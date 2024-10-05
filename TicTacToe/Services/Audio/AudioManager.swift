//
//  AudioManager.swift
//  TicTacToe
//
//  Created by Никита Мартьянов on 4.10.24.
//

//import SwiftUI
//import AVFoundation
//
//class AudioManager: ObservableObject {
//    @State private var gameModel = GameViewModel()
//    var audioPlayer: AVAudioPlayer?
//
//    // Метод для воспроизведения музыки
//    func playMusic() {
//        if let path = Bundle.main.path(forResource:gameModel.selectMusic, ofType: "mp3") {
//            do {
//                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
//                audioPlayer?.play()
//            } catch {
//                print("Error: Unable to play the music file.")
//            }
//        }
//    }
//
//    // Метод для остановки музыки
//    func stopMusic() {
//        audioPlayer?.stop()
//    }
//}

