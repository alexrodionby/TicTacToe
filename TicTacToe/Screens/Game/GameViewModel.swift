//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 30.09.24.
//

import Foundation
import Observation

// MARK: - Player
enum Player {
    case playerOne
    case playerTwo
    case computer
    case draw
}

// MARK: - GameStatus
enum GameStatus {
    case finish
    case inProgress
    case pause
    case notStarted
}

// MARK: - Move
struct Move {
    var player: Player
    var boarderIndex: Int
}

// MARK: - GameViewModel
@Observable
class GameViewModel {
    
    private let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    var firstTurnPlayer: Player = .playerOne
    var secondTurnPlayer: Player = .computer
    var currentPlayer: Player = .playerOne
    var selectMusic: String = "Instrumentals"
    var selectTimer: String = "30 min"
    var xMark: String = "xSkin4"
    var oMark: String = "oSkin4"
    var whoWin: Player = .draw
    var gameState: GameStatus = .notStarted
    var boardIsDisable: Bool = false
    
    var moves: [Move?] = .init(repeating: nil, count: 9)
    
    // MARK: - External Methods
    func processingPlayerMove(move: Move) {
        if isCellOccupied(move: move) {
            return
        } else {
            moves[move.boarderIndex] = move
            
            // Проверка на победу или ничью после хода игрока
            if checkWinner(move: move) {
                print("Player \(move.player) win")
                whoWin = move.player
                gameState = .finish
                boardIsDisable = true
                return
            }
            
            if checkForDraw(move: move) {
                print("Ничья")
                whoWin = .draw
                gameState = .finish
                boardIsDisable = true
                return
            }

            // Переключение на следующего игрока
            currentPlayer = (currentPlayer == firstTurnPlayer) ? secondTurnPlayer : firstTurnPlayer

            // Проверка, если текущий игрок - компьютер
            if currentPlayer == .computer {
                // Делаем ход компьютера
                Task {
                    await computerSmartMove()
                }
            }
        }
    }

    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        whoWin = .draw
        gameState = .inProgress
        currentPlayer = firstTurnPlayer
        boardIsDisable = false
        
        // Если первый ход за компьютером, то сразу делаем его ход
        if currentPlayer == .computer {
            Task {
                await computerSmartMove()
            }
        }
    }

    
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
    
    
    // MARK: - Internal Methods
    
    private func checkForDraw(move: Move) -> Bool {
        return moves.compactMap{$0}.count == 9
    }
    
    private func checkWinner(move: Move) -> Bool {
        let playerMoves = moves.compactMap{$0}.filter {$0.player == move.player}
        let playerPositions = Set(playerMoves.map{$0.boarderIndex})
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        return false
    }
    
    private func isCellOccupied(move: Move) -> Bool {
        return moves.contains(where: { $0?.boarderIndex == move.boarderIndex })
    }
    
    // MARK: - AI Methods
    
    private func computerMovePosition(moves: [Move?]) -> Int {
        let occupiedIndices = Set(moves.compactMap { $0?.boarderIndex })
        let allIndices = Set(0..<9)
        let unoccupiedIndices = allIndices.subtracting(occupiedIndices)
        let randomIndex = unoccupiedIndices.randomElement()
        return randomIndex ?? 0
    }
    
    func computerRandomMove() async {
        try? await Task.sleep(for: .seconds(1))
        let computerPosition = computerMovePosition(moves: moves)
        let computerMove = Move(player: .computer, boarderIndex: computerPosition)
        moves[computerPosition] = computerMove
        
        if checkWinner(move: computerMove) {
            print("Computer win")
            whoWin = computerMove.player
            gameState = .finish
            boardIsDisable = true
            return
        }
        
        if checkForDraw(move: computerMove) {
            print("Ничья")
            whoWin = .draw
            gameState = .finish
            boardIsDisable = true
            return
        }
        
        currentPlayer = .playerOne
        boardIsDisable = false
    }
    // MARK: - AI Methods

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

    func computerSmartMove() async {
        try? await Task.sleep(for: .seconds(1))
        
        // Ход компьютера с минимаксом
        let bestPosition = bestMoveForComputer()
        let computerMove = Move(player: .computer, boarderIndex: bestPosition)
        moves[bestPosition] = computerMove
        
        if checkWinner(move: computerMove) {
            print("Computer win")
            whoWin = computerMove.player
            gameState = .finish
            boardIsDisable = true
            return
        }
        
        if checkForDraw(move: computerMove) {
            print("Ничья")
            whoWin = .draw
            gameState = .finish
            boardIsDisable = true
            return
        }
        
        currentPlayer = .playerOne
        boardIsDisable = false
    }
    
    func computerMediumMove() async {
        try? await Task.sleep(for: .seconds(1))
        
        // 1. Проверка на необходимость блокировки победного хода игрока
        if let blockPosition = findWinningMove(for: firstTurnPlayer) {
            let computerMove = Move(player: .computer, boarderIndex: blockPosition)
            moves[blockPosition] = computerMove
            completeTurn(for: computerMove)
            return
        }
        
        // 2. Если нет угрозы победы игрока, проверка на возможность победного хода компьютера
        if let winPosition = findWinningMove(for: .computer) {
            let computerMove = Move(player: .computer, boarderIndex: winPosition)
            moves[winPosition] = computerMove
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
            print("Computer win")
            whoWin = move.player
            gameState = .finish
            boardIsDisable = true
            return
        }
        
        if checkForDraw(move: move) {
            print("Ничья")
            whoWin = .draw
            gameState = .finish
            boardIsDisable = true
            return
        }
        
        currentPlayer = .playerOne
        boardIsDisable = false
    }

    // Метод для поиска выигрышного хода
    private func findWinningMove(for player: Player) -> Int? {
        for i in 0..<moves.count where moves[i] == nil {
            var newBoard = moves
            newBoard[i] = Move(player: player, boarderIndex: i)
            if checkWinner(move: newBoard[i]!) {
                return i
            }
        }
        return nil
    }

}
