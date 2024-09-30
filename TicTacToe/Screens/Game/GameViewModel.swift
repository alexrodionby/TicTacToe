//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 30.09.24.
//

import Foundation

enum Player {
    case playerOne
    case playerTwo
    case computer
}

struct Move {
    var player: Player
    var boarderIndex: Int
}

@Observable
class GameViewModel {
    
    let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    var firstTurnPlayer: Player = .playerOne
    var secondTurnPlayer: Player = .playerTwo
    var currentPlayer: Player = .playerOne
    
    var moves: [Move?] = .init(repeating: nil, count: 9)
    
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
            return
        }
        
        if checkForDraw(move: move) {
            print("Ничья")
            return
        }
        
        
        func checkWinner(move: Move) -> Bool {
            let playerMoves = moves.compactMap{$0}.filter {$0.player == move.player}
            let playerPositions = Set(playerMoves.map{$0.boarderIndex})
            for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
            return false
        }
        

        
        func isCellOccupied(move: Move) -> Bool {
            return moves.contains(where: { $0?.boarderIndex == move.boarderIndex })
        }
        
        func checkForDraw(move: Move) -> Bool {
            return moves.compactMap{$0}.count == 9
        }
        


    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}
