//
//  GameTimerManager.swift
//  TicTacToe
//
//  Created by Адам Табиев on 30.09.2024.
//


//
//  GameTimerManager.swift
//  TicTacToe
//
//  Created by Адам Табиев on 30.09.2024.
//

import Foundation
import Combine

/// Менеджер таймера для игры, отвечающий за контроль времени игроков и отслеживание текущего активного игрока.
class GameTimerManager: ObservableObject {

    /// Оставшееся время для игрока 1 (в секундах)
    @Published var playerOneTimeRemaining: Int
    /// Оставшееся время для игрока 2 (в секундах)
    @Published var playerTwoTimeRemaining: Int
    /// Текущий активный игрок
    @Published var activePlayer: Player = .none

    /// Таймер, управляющий обратным отсчетом
    private var timer: AnyCancellable?

    /// Перечисление, представляющее игроков
    enum Player {
        case one
        case two
        case none
    }

    /// Инициализатор, устанавливающий начальное время для каждого игрока
    /// - Parameter initialTime: Начальное время в секундах
    init(initialTime: Int) {
        self.playerOneTimeRemaining = initialTime
        self.playerTwoTimeRemaining = initialTime
    }

    /// Запускает таймер для указанного игрока
    /// - Parameter player: Игрок, для которого нужно запустить таймер
    func startTimer(for player: Player) {
        activePlayer = player
        timer?.cancel() // Останавливаем предыдущий таймер, если он есть

        // Запускаем таймер с интервалом в 1 секунду
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.updateTimer(for: player) // Обновляем время для текущего игрока каждую секунду
            }
    }

    /// Ставит таймер на паузу
    func pauseTimer() {
        timer?.cancel() // Останавливаем текущий таймер
    }

    /// Обновляет оставшееся время для текущего игрока
    /// - Parameter player: Игрок, время которого нужно обновить
    private func updateTimer(for player: Player) {
        switch player {
        case .one:
            if playerOneTimeRemaining > 0 {
                playerOneTimeRemaining -= 1 // Уменьшаем оставшееся время игрока 1
            } else {
                timer?.cancel() // Останавливаем таймер, если время истекло
            }
        case .two:
            if playerTwoTimeRemaining > 0 {
                playerTwoTimeRemaining -= 1 // Уменьшаем оставшееся время игрока 2
            } else {
                timer?.cancel() // Останавливаем таймер, если время истекло
            }
        case .none:
            break
        }
    }

    /// Сбрасывает таймеры для обоих игроков к начальному значению
    /// - Parameter initialTime: Начальное время в секундах
    func resetTimers(initialTime: Int) {
        timer?.cancel() // Останавливаем текущий таймер
        playerOneTimeRemaining = initialTime // Сбрасываем время для игрока 1
        playerTwoTimeRemaining = initialTime // Сбрасываем время для игрока 2
        activePlayer = .none // Сбрасываем активного игрока
    }
}


