//
//  TimeManager.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 5.10.24.
//

import Foundation
import Observation

@Observable
class TimeManager {
    
    private var timer: Timer?
    
    // MARK: - External Methods
    
    /// Начинает таймер для игрока
    /// - Parameters:
    ///   - playerTime: Время игрока, передается через замыкание, чтобы оно синхронизировалось с ViewModel
    ///   - onTimeUpdate: Замыкание для обновления времени во ViewModel
    func startPlayerTimer(playerTime: @escaping () -> Int, onTimeUpdate: @escaping (Int) -> Void) {
        stopAnyTimer() // Останавливаем предыдущий таймер, если есть
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            var timeLeft = playerTime()
            if timeLeft > 0 {
                timeLeft -= 1
                onTimeUpdate(timeLeft) // Обновляем время во ViewModel
            } else {
                self.stopAnyTimer()
                onTimeUpdate(0) // Устанавливаем время на 0, когда таймер закончился
            }
        }
    }
    
    /// Останавливает любой активный таймер
    func stopAnyTimer() {
        timer?.invalidate()
        timer = nil
    }
}
