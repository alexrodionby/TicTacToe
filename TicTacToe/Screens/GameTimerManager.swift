//
//  GameTimerManager.swift
//  TicTacToe
//
//  Created by Адам Табиев on 30.09.2024.
//

import Foundation

/// Менеджер таймера для игры, отвечающий за контроль времени игроков и отслеживание текущего активного игрока.
@Observable
final class GameTimerManager {
    var playerOneTimeRemaining: Int // Оставшееся время для игрока 1 (в секундах)
    var playerTwoTimeRemaining: Int // Оставшееся время для игрока 2 (в секундах)
    var activePlayer: Player = .none // Текущий активный игрок

    // Таймер, управляющий обратным отсчетом
    private var timer: Timer?

    enum Player {
        case one
        case two
        case none
    }

    // Инициализатор, устанавливающий начальное время для каждого игрока
    init(initialTime: Int) {
        self.playerOneTimeRemaining = initialTime
        self.playerTwoTimeRemaining = initialTime
    }

    /// Запускает таймер для указанного игрока
    func startTimer(for player: Player) {
        activePlayer = player
        timer?.invalidate() // Останавливаем предыдущий таймер, если он есть

        // Запускаем новый таймер, который срабатывает каждую секунду
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.updateTimer(for: player) // Обновляем время для текущего игрока каждую секунду
        }
    }

    /// Ставит таймер на паузу
    func pauseTimer() {
        timer?.invalidate() // Останавливаем текущий таймер
    }

    /// Обновляет оставшееся время для текущего игрока
    // player: Игрок, время которого нужно обновить
    private func updateTimer(for player: Player) {
        switch player {
        case .one:
            if playerOneTimeRemaining > 0 {
                playerOneTimeRemaining -= 1 // Уменьшаем оставшееся время игрока 1
            } else {
                timer?.invalidate() // Останавливаем таймер, если время истекло
            }
        case .two:
            if playerTwoTimeRemaining > 0 {
                playerTwoTimeRemaining -= 1 // Уменьшаем оставшееся время игрока 2
            } else {
                timer?.invalidate() // Останавливаем таймер, если время истекло
            }
        case .none:
            break
        }
    }

    /// Сбрасывает таймеры для обоих игроков к начальному значению
    func resetTimers(initialTime: Int) {
        timer?.invalidate() // Останавливаем текущий таймер
        playerOneTimeRemaining = initialTime // Сбрасываем время для игрока 1
        playerTwoTimeRemaining = initialTime // Сбрасываем время для игрока 2
        activePlayer = .none // Сбрасываем активного игрока
    }
}


