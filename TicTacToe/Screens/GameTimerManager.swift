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

    private var playerOneTimeSpent: Int = 0 // Потраченное время игроком 1 (в секундах)
    private var playerTwoTimeSpent: Int = 0 // Потраченное время игроком 2 (в секундах)

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
            self.updateTimeSpent(for: player) // Обновляем потраченное время для текущего игрока
            self.updateTimer(for: player) // Обновляем оставшееся время для текущего игрока
        }
    }

    /// Ставит таймер на паузу
    func pauseTimer() {
        timer?.invalidate() // Останавливаем текущий таймер
    }

    /// Обновляет оставшееся время для текущего игрока
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

    /// Обновляет потраченное время для текущего игрока
    private func updateTimeSpent(for player: Player) {
        switch player {
        case .one:
            playerOneTimeSpent += 1 // Увеличиваем потраченное время игрока 1 на одну секунду
        case .two:
            playerTwoTimeSpent += 1 // Увеличиваем потраченное время игрока 2 на одну секунду
        case .none:
            break
        }
    }

    /// Сбрасывает таймеры и потраченное время для обоих игроков к начальному значению
    func resetTimers(initialTime: Int) {
        timer?.invalidate() // Останавливаем текущий таймер
        playerOneTimeRemaining = initialTime // Сбрасываем время для игрока 1
        playerTwoTimeRemaining = initialTime // Сбрасываем время для игрока 2
        playerOneTimeSpent = 0 // Сбрасываем потраченное время игрока 1
        playerTwoTimeSpent = 0 // Сбрасываем потраченное время игрока 2
        activePlayer = .none // Сбрасываем активного игрока
    }

    /// Сохраняет наименьшее количество секунд, потраченное игроком, если время не истекло
    func saveBestTime() {
        // Проверяем, что время не истекло для обоих игроков
        if playerOneTimeRemaining > 0 || playerTwoTimeRemaining > 0 {
            // Определяем наименьшее время, потраченное одним из игроков
            let minimumTimeSpent = min(playerOneTimeSpent, playerTwoTimeSpent)

            // Отладка: выводим потраченное время каждым игроком
            print("Player One Time Spent: \(playerOneTimeSpent) сек")
            print("Player Two Time Spent: \(playerTwoTimeSpent) сек")
            print("Minimum Time Spent: \(minimumTimeSpent) сек")

            // Загружаем текущий массив лучших времен из UserDefaults
            var bestTimes = UserDefaults.standard.array(forKey: "timeStorage") as? [Int] ?? []

            // Добавляем новое значение
            bestTimes.append(minimumTimeSpent)

            // Сохраняем обновленный массив в UserDefaults
            UserDefaults.standard.set(bestTimes, forKey: "timeStorage")
            print("Лучшее время сохранено: \(minimumTimeSpent) сек")
        } else {
            print("Время истекло для обоих игроков, ничего не сохраняем")
        }
    }
}









