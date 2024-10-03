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
            if currentPlayer == firstTurnPlayer {
                currentPlayer = secondTurnPlayer
            } else {
                currentPlayer = firstTurnPlayer
            }
        }
        
        if checkWinner(move: move) {
            print("Player \( move.player) win")
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
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        whoWin = .draw
        gameState = .notStarted
        currentPlayer = firstTurnPlayer
        boardIsDisable = false
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
}
