//
//  AudioManager.swift
//  TicTacToe
//
//  Created by Никита Мартьянов on 4.10.24.
//

import AVFoundation

class AudioManager {
    private var musicPlayer: AVAudioPlayer?
    private var sfxPlayer: AVAudioPlayer?
    private var currentTrack: String?
    
    // MARK: - Music Methods
    
    // Метод для воспроизведения фоновой музыки
    func playMusic(named trackName: String) {
        // Проверяем, если трек уже играет, не перезапускаем его
        if currentTrack == trackName && musicPlayer?.isPlaying == true {
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
            // Инициализируем плеер музыки с новым треком
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer?.numberOfLoops = -1  // Зацикливаем бесконечно
            musicPlayer?.play()
            //print("Playing \(trackName)")
        } catch {
            print("Error: Could not play music: \(error.localizedDescription)")
        }
    }
    
    // Метод для остановки музыки
    func stopMusic() {
        if musicPlayer?.isPlaying == true {
            musicPlayer?.stop()
            //print("Music stopped")
        }
    }
    
    // MARK: - Sound Effects Methods
    
    // Метод для воспроизведения звуковых эффектов
    func playSoundEffect(name: String) {
        // Находим путь к файлу звукового эффекта
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("Error: Sound effect file not found.")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            // Инициализируем плеер звуковых эффектов
            sfxPlayer = try AVAudioPlayer(contentsOf: url)
            sfxPlayer?.play()
            //print("Playing sound effect \(sfxName)")
        } catch {
            print("Error: Could not play sound effect: \(error.localizedDescription)")
        }
    }
}
