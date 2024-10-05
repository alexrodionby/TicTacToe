//
//  AudioManager.swift
//  TicTacToe
//
//  Created by Никита Мартьянов on 4.10.24.
//

import AVFoundation

class AudioManager {
    private var audioPlayer: AVAudioPlayer?
    private var currentTrack: String?
    
    // Метод для воспроизведения музыки
    func playMusic(named trackName: String) {
        // Проверяем, если трек уже играет, не перезапускаем его
        if currentTrack == trackName && audioPlayer?.isPlaying == true {
            return
        }
        
        // Сохраняем текущий трек
        currentTrack = trackName
        
        // Находим путь к аудиофайлу
        guard let path = Bundle.main.path(forResource: trackName, ofType: "mp3") else {
            print("Error: Music file not found.")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            // Инициализируем плеер с новым треком
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            print("Playing \(trackName)")
        } catch {
            print("Error: Could not play music: \(error.localizedDescription)")
        }
    }
    
    // Метод для остановки музыки
    func stopMusic() {
        if audioPlayer?.isPlaying == true {
            audioPlayer?.stop()
            print("Music stopped")
        }
    }
}
