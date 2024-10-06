//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 30.09.24.
//

import Foundation
import Observation

// MARK: - Player
enum Player {       /// Список воззможных игроков
    case playerOne
    case playerTwo
    case computer
    case draw
}

// MARK: - GameStatus
enum GameStatus {       /// Статус игрового процесса
    case finish
    case inProgress
    case pause
    case notStarted
}

// MARK: - GameLevel
enum GameLevel {        /// Уровень сложности игры
    case easy
    case medium
    case hard
    case randomGod
}

// MARK: - Move
struct Move {       /// Структура, которая описывает ход любого игрока
    var player: Player
    var boarderIndex: Int
}

// MARK: - GameViewModel
@MainActor
@Observable
class GameViewModel {
    
    private let audioManager = AudioManager() // Наш менеджер аудио
    private let timeManager = TimeManager() // Наш менеджер таймеров
    
    /// Паттерны победы. Каждый набор представляет индексы ячеек, которые составляют выигрышную комбинацию.
    private let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    let timeVariants: [Int] = [10, 20, 30, 40, 50, 60]
    let musicVariants: [String] = ["Classical", "Instrumentals", "Nature"]
    
    /// Переменные, отвечающие за текущих игроков и статус игры
    var playerOneTimeLeft: Int = 60
    var playerTwoTimeLeft: Int = 60
    var firstTurnPlayer: Player = .playerOne
    var secondTurnPlayer: Player = .computer
    var currentPlayer: Player = .playerOne
    var gameLevel: GameLevel = .randomGod
    var selectedMusic: String = "Classical"
    var selectedTime: Int = 60
    var gameWithTimer: Bool = false
    var gameWithMusic: Bool = false
    var xMark: String = "xSkin4"
    var oMark: String = "oSkin4"
    var whoWin: Player = .draw              /// Определяет победителя
    var gameState: GameStatus = .notStarted /// Текущий статус игры
    var boardIsDisable: Bool = false        /// Блокирует доску
    var moves: [Move?] = .init(repeating: nil, count: 9)    /// Массив, который хранит все ходы игры
    var winningPattern: Set<Int>?           /// Хранит индексы выигрышного паттерна
    var sfxOn: Bool = false
 
// MARK: - Сохранение результатов в UserDefaults
    
    /// Сохраняет наименьшее количество секунд, потраченное игроком, если время не истекло и оно больше нуля
    func saveBestTime() {
        // Проверяем, что время не истекло для обоих игроков
        if playerOneTimeLeft > 0 || playerTwoTimeLeft > 0 {
            // Определяем наименьшее время, потраченное одним из игроков
            let minimumTimeSpent = min(playerOneTimeLeft, playerTwoTimeLeft)
            
            // Проверяем, что минимальное время больше нуля
            if minimumTimeSpent > 0 {
                // Загружаем текущий массив лучших времен из UserDefaults
                var bestTimes = UserDefaults.standard.array(forKey: "timeStorage") as? [Int] ?? []
                
                // Проверяем, есть ли уже такое время в массиве
                if !bestTimes.contains(minimumTimeSpent) {
                    // Добавляем новое значение
                    bestTimes.append(minimumTimeSpent)
                    
                    // Сохраняем обновленный массив в UserDefaults
                    UserDefaults.standard.set(bestTimes, forKey: "timeStorage")
                    print("Лучшее время сохранено: \(minimumTimeSpent) сек")
                } else {
                    print("Время \(minimumTimeSpent) сек уже сохранено, дубликат не добавлен")
                }
            } else {
                print("Минимальное время равно нулю, сохранение не выполнено")
            }
        } else {
            print("Время истекло для обоих игроков, ничего не сохраняем")
        }
    }
    
    
    
// MARK: - Timer Methods (Методы для работы с таймерами)
    
    /// Запуск таймера для текущего игрока
    func startCurrentPlayerTimer() {
        if currentPlayer == firstTurnPlayer {
            timeManager.startPlayerTimer(playerTime: { self.playerOneTimeLeft }) { updatedTime in
                self.playerOneTimeLeft = updatedTime
                if self.playerOneTimeLeft == 0 {
                    self.gameState = .finish
                    self.whoWin = self.secondTurnPlayer
                }
            }
        }
        
        if currentPlayer == secondTurnPlayer {
            timeManager.startPlayerTimer(playerTime: { self.playerTwoTimeLeft }) { updatedTime in
                self.playerTwoTimeLeft = updatedTime
                if self.playerTwoTimeLeft == 0 {
                    self.gameState = .finish
                    self.whoWin = self.firstTurnPlayer
                }
            }
        }
    }
    
    /// Остановка всех таймеров
    func stopAllTimers() {
        timeManager.stopAnyTimer()
    }
    
    // MARK: - Music Methods (Методы для взаимодействия с Music)
    
    func playSoundEffect(name: String) {
        audioManager.playSoundEffect(name: name)
    }
    
    func startMusicIfEnabled() {
            if gameWithMusic {
                audioManager.playMusic(named: selectedMusic)
            } else {
                audioManager.stopMusic()
            }
        }
    
    func stopMusic() {
            audioManager.stopMusic()
        }
    
    // MARK: - External Methods (Публичные методы для взаимодействия с View)
    
    func startGame() {
        playerOneTimeLeft = selectedTime
        playerTwoTimeLeft = selectedTime
        startCurrentPlayerTimer()
    }
    
    /// Обрабатывает ход игрока, проверяет на занятость ячейки, обновляет текущего игрока и проверяет победу/ничью.
    func processingPlayerMove(move: Move) {
        
        /// Проверяет на занятость ячейки
        if isCellOccupied(move: move) {
            return
        } else {
            /// Если ячейка свободна, записываем ход игрока
            moves[move.boarderIndex] = move
            if sfxOn {
                if currentPlayer == .playerOne {
                    playSoundEffect(name: "One")
                } else {
                    playSoundEffect(name: "Two")
                }
            }
        }
        
        /// Проверка на победу после каждого хода
        if checkWinner(move: move) {
            whoWin = move.player
            gameState = .finish
            boardIsDisable = true
            return
        }
        
        /// Проверка на ничью
        if checkForDraw(move: move) {
            whoWin = .draw
            gameState = .finish
            boardIsDisable = true
            return
        }
        
        /// Переключение между игроками
        changePlayer()
    }
    
    /// Сбрасываем все значения текущей игры на дефолтные
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        whoWin = .draw
        gameState = .notStarted
        currentPlayer = firstTurnPlayer
        boardIsDisable = false
        winningPattern = nil  /// Сбрасываем выигрышный паттерн
        playerOneTimeLeft = selectedTime
        playerTwoTimeLeft = selectedTime
    }
    
    /// Возвращает имя игрока
    func getPlayerName(player: Player) -> String {
        switch player {
        case .playerOne:
            return "Player One"
        case .playerTwo:
            return "Player Two"
        case .computer:
            return "Computer"
        case .draw:
            return "Draw"
        }
    }
    
    // MARK: - Internal Methods (Внутренние методы для внутренней логики)
    
    /// Проверяет, не заполнены ли все ячейки на поле, чтобы определить ничью
    private func checkForDraw(move: Move) -> Bool {
        return moves.compactMap{$0}.count == 9  /// Возвращает true, если все ячейки заполнены
    }
    
    /// Проверяет, есть ли победитель на основе последнего хода
    private func checkWinner(move: Move) -> Bool {
        /// Фильтруем ходы, сделанные текущим игроком
        let playerMoves = moves.compactMap{$0}.filter {$0.player == move.player}
        /// Получаем индексы этих ходов
        let playerPositions = Set(playerMoves.map{$0.boarderIndex})
        /// Проверяем, есть ли у игрока одна из выигрышных комбинаций
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
            winningPattern = pattern /// Сохраняем выигрышный паттерн
            return true
        }
        return false
    }
    
    /// Проверяет, занята ли ячейка, чтобы не допустить перезапись
    private func isCellOccupied(move: Move) -> Bool {
        return moves.contains(where: { $0?.boarderIndex == move.boarderIndex })
    }
    
    /// Переключение между игроками
    private func changePlayer() {
        if gameState != .finish && moves.filter({ $0 == nil }).count != 0 {
            
            if secondTurnPlayer == .playerTwo {
                stopAllTimers()
                
                if currentPlayer == firstTurnPlayer {
                    currentPlayer = secondTurnPlayer
                } else {
                    currentPlayer = firstTurnPlayer
                }
                
                startCurrentPlayerTimer()
            }
            
            if secondTurnPlayer == .computer {
                
                if currentPlayer == firstTurnPlayer {
                    stopAllTimers()
                    currentPlayer = secondTurnPlayer
                } else {
                    currentPlayer = firstTurnPlayer
                    startCurrentPlayerTimer()
                }
            }

            if currentPlayer == .computer {
                boardIsDisable = true
            } else {
                boardIsDisable = false
            }
        }
    }
    
    // MARK: - AI Methods (Методы для искусственного интеллекта)
    
    /// Определяет случайную незанятую позицию на игровом поле для хода компьютера.
    /// - Parameter moves: Массив ходов (состояние игрового поля).
    /// - Returns: Возвращает индекс первой свободной ячейки или случайную незанятую ячейку.
    private func computerMovePosition(moves: [Move?]) -> Int {
        // Собираем все занятые ячейки (индексы) на поле.
        let occupiedIndices = Set(moves.compactMap { $0?.boarderIndex })
        
        // Создаем множество всех индексов (от 0 до 8).
        let allIndices = Set(0..<9)
        
        // Вычисляем незанятые индексы путем вычитания занятых индексов из всех индексов.
        let unoccupiedIndices = allIndices.subtracting(occupiedIndices)
        
        // Выбираем случайную незанятую ячейку.
        let randomIndex = unoccupiedIndices.randomElement()
        
        // Возвращаем выбранный индекс, если он есть, или 0, если нет доступных ячеек.
        return randomIndex ?? 0
    }
    
    /// Выполняет случайный ход за компьютер с задержкой, затем проверяет, завершилась ли игра (победа или ничья).
    /// Если игра продолжается, передает ход игроку.
    /// - Note: Функция асинхронная, добавлена задержка в 1 секунду для симуляции времени на обдумывание хода компьютером.
    func computerRandomMove() async {
        // Имитируем задержку хода компьютера на 1 секунду.
        try? await Task.sleep(for: .seconds(1))
        
        // Выбираем случайную незанятую позицию для хода компьютера.
        let computerPosition = computerMovePosition(moves: moves)
        
        // Создаем объект хода компьютера с выбранной позицией.
        let computerMove = Move(player: .computer, boarderIndex: computerPosition)
        
        // Записываем ход компьютера на доску.
        moves[computerPosition] = computerMove
        
        if sfxOn {
            playSoundEffect(name: "Two")
        }
        
        // Проверяем, выиграл ли компьютер после этого хода.
        if checkWinner(move: computerMove) {
            whoWin = computerMove.player // Устанавливаем компьютера победителем.
            gameState = .finish // Обновляем статус игры как завершённую.
            boardIsDisable = true // Блокируем доску.
            return
        }
        
        // Проверяем, не наступила ли ничья после хода компьютера.
        if checkForDraw(move: computerMove) {
            whoWin = .draw // Устанавливаем результат игры как ничья.
            gameState = .finish // Обновляем статус игры как завершённую.
            boardIsDisable = true // Блокируем доску.
            return
        }
        
        // Переключение между игроками
        changePlayer()
    }
    
    // MARK: - AI Methods (Реализация алгоритма minimax)
    
    private func minimax(board: [Move?], depth: Int, isMaximizing: Bool) -> Int {
        // Проверяем, выиграл ли кто-либо или ничья
        if let score = evaluate(board: board) {
            return score - depth // Глубина учитывается для выбора быстрейшей победы или долгой ничьей
        }
        
        // Если это ход компьютера (максимизирующий игрок)
        if isMaximizing {
            var bestScore = Int.min
            for i in 0..<board.count {
                if board[i] == nil { // Проверяем, доступна ли клетка
                    var newBoard = board
                    newBoard[i] = Move(player: .computer, boarderIndex: i)
                    let score = minimax(board: newBoard, depth: depth + 1, isMaximizing: false)
                    bestScore = max(score, bestScore)
                }
            }
            return bestScore
        } else {
            // Ход игрока (минимизирующий игрок)
            var bestScore = Int.max
            for i in 0..<board.count {
                if board[i] == nil {
                    var newBoard = board
                    newBoard[i] = Move(player: firstTurnPlayer, boarderIndex: i)
                    let score = minimax(board: newBoard, depth: depth + 1, isMaximizing: true)
                    bestScore = min(score, bestScore)
                }
            }
            return bestScore
        }
    }
    
    // Оценка текущего состояния доски
    private func evaluate(board: [Move?]) -> Int? {
        // Проверяем, выиграл ли кто-либо
        for pattern in winPatterns {
            let movesComputer = Set(board.compactMap { $0?.player == .computer ? $0?.boarderIndex : nil })
            let movesPlayer = Set(board.compactMap { $0?.player == firstTurnPlayer ? $0?.boarderIndex : nil })
            
            if pattern.isSubset(of: movesComputer) {
                return 10 // Победа компьютера
            }
            
            if pattern.isSubset(of: movesPlayer) {
                return -10 // Победа игрока
            }
        }
        
        // Ничья
        if board.compactMap({ $0 }).count == 9 {
            return 0
        }
        
        // Игра продолжается
        return nil
    }
    
    // Используется для нахождения лучшего хода для компьютера
    private func bestMoveForComputer() -> Int {
        var bestScore = Int.min
        var moveIndex = 0
        
        for i in 0..<moves.count {
            if moves[i] == nil {
                // Сделаем временный ход за компьютер
                var newBoard = moves
                newBoard[i] = Move(player: .computer, boarderIndex: i)
                
                // Вычисляем оценку с помощью минимакса
                let score = minimax(board: newBoard, depth: 0, isMaximizing: false)
                
                // Выбираем лучший ход
                if score > bestScore {
                    bestScore = score
                    moveIndex = i
                }
            }
        }
        
        return moveIndex
    }
    
    func computerHardMove() async {
        try? await Task.sleep(for: .seconds(1))
        
        // Проверка, является ли это первым ходом компьютера
       // let computerMovesCount = moves.compactMap { $0?.player == .computer ? $0 : nil }.count
        
//        if computerMovesCount == 0 {
//            // Если это первый ход компьютера, выбираем случайную позицию
//            let randomPosition = computerMovePosition(moves: moves)
//            let computerMove = Move(player: .computer, boarderIndex: randomPosition)
//            moves[randomPosition] = computerMove
//            completeTurn(for: computerMove)
//            return
//        }
        
        // Ход компьютера с минимаксом
        let bestPosition = bestMoveForComputer()
        let computerMove = Move(player: .computer, boarderIndex: bestPosition)
        moves[bestPosition] = computerMove
        
        if sfxOn {
            playSoundEffect(name: "Two")
        }
        
        if checkWinner(move: computerMove) {
            whoWin = computerMove.player
            gameState = .finish
            boardIsDisable = true
            return
        }
        
        if checkForDraw(move: computerMove) {
            whoWin = .draw
            gameState = .finish
            boardIsDisable = true
            return
        }
        
        changePlayer()
    }
    
    func computerMediumMove() async {
        try? await Task.sleep(for: .seconds(1))
        
        // Проверка, является ли это первым ходом компьютера
        let computerMovesCount = moves.compactMap { $0?.player == .computer ? $0 : nil }.count
        
        if sfxOn {
            playSoundEffect(name: "Two")
        }
        
        if computerMovesCount == 0 {
            // Если это первый ход компьютера, выбираем случайную позицию
            let randomPosition = computerMovePosition(moves: moves)
            let computerMove = Move(player: .computer, boarderIndex: randomPosition)
            moves[randomPosition] = computerMove
            completeTurn(for: computerMove)
            return
        }
        
        // 1. Если нет угрозы победы игрока, проверка на возможность победного хода компьютера
        if let winPosition = findWinningMove(for: .computer) {
            let computerMove = Move(player: .computer, boarderIndex: winPosition)
            moves[winPosition] = computerMove
            completeTurn(for: computerMove)
            return
        }
        
        // 2. Проверка на необходимость блокировки победного хода игрока
        if let blockPosition = findWinningMove(for: firstTurnPlayer) {
            let computerMove = Move(player: .computer, boarderIndex: blockPosition)
            moves[blockPosition] = computerMove
            completeTurn(for: computerMove)
            return
        }
        
        // 3. Выбор центральной или угловой клетки, если они свободны
        let preferredPositions = [4, 0, 2, 6, 8]
        if let preferredPosition = preferredPositions.first(where: { moves[$0] == nil }) {
            let computerMove = Move(player: .computer, boarderIndex: preferredPosition)
            moves[preferredPosition] = computerMove
            completeTurn(for: computerMove)
            return
        }
        
        // 4. Если ничего из вышеперечисленного не сработало, делаем случайный ход
        let randomPosition = computerMovePosition(moves: moves)
        let computerMove = Move(player: .computer, boarderIndex: randomPosition)
        moves[randomPosition] = computerMove
        completeTurn(for: computerMove)
    }
    
    // Завершение хода компьютера с проверкой на победу или ничью
    private func completeTurn(for move: Move) {
        if checkWinner(move: move) {
            whoWin = move.player
            gameState = .finish
            boardIsDisable = true
            return
        }
        
        if checkForDraw(move: move) {
            whoWin = .draw
            gameState = .finish
            boardIsDisable = true
            return
        }
        
        changePlayer()
    }
    
    // Метод для поиска выигрышного хода
    private func findWinningMove(for player: Player) -> Int? {
        for i in 0..<moves.count where moves[i] == nil {
            // Копируем текущее состояние доски
            var newBoard = moves
            // Делаем временный ход на текущей пустой клетке
            newBoard[i] = Move(player: player, boarderIndex: i)
            
            // Проверяем, если есть победная комбинация с этим ходом
            let playerMoves = newBoard.compactMap { $0 }.filter { $0.player == player }
            let playerPositions = Set(playerMoves.map { $0.boarderIndex })
            
            for pattern in winPatterns {
                if pattern.isSubset(of: playerPositions) {
                    return i // Возвращаем индекс, который приведет к победе
                }
            }
        }
        return nil // Если не найдено выигрышного хода, возвращаем nil
    }
    
    func computerEasyMove() async {
        try? await Task.sleep(for: .seconds(1))
        
        if sfxOn {
            playSoundEffect(name: "Two")
        }
        
        // Если нет угрозы победы игрока, проверка на возможность победного хода компьютера
        if let winPosition = findWinningMove(for: .computer) {
            let computerMove = Move(player: .computer, boarderIndex: winPosition)
            moves[winPosition] = computerMove
            completeTurn(for: computerMove)
            return
        }
        
        // Выбор центральной или угловой клетки, если они свободны
        let preferredPositions = [4, 0, 2, 6, 8]
        if let preferredPosition = preferredPositions.first(where: { moves[$0] == nil }) {
            let computerMove = Move(player: .computer, boarderIndex: preferredPosition)
            moves[preferredPosition] = computerMove
            completeTurn(for: computerMove)
            return
        }
        
        // Если ничего из вышеперечисленного не сработало, делаем случайный ход
        let randomPosition = computerMovePosition(moves: moves)
        let computerMove = Move(player: .computer, boarderIndex: randomPosition)
        moves[randomPosition] = computerMove
        completeTurn(for: computerMove)
    }
}
