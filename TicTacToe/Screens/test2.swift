////
////  test2.swift
////  TicTacToe
////
////  Created by Alexandr Rodionov on 30.09.24.
////
//
//import SwiftUI
//final class TicTacToeViewModel: ObservableObject {
//    
//    // Defines the layout of the game board as a grid with 3 columns.
//    let columns : [GridItem] = [GridItem(.flexible()),
//                                GridItem(.flexible()),
//                                GridItem(.flexible()),]
//    
//    // An array of optional values representing the moves made by both players. Nil indicates that the square is not yet occupied.
//    @Published var moves:[TicTacToeView.Move?] = Array(repeating: nil, count: 9)
//    
//    // A flag indicating if the game board should be disabled to prevent further user interaction.
//    @Published var isGameBoardDisabled:Bool = false
//    
//    // An optional alert to be displayed to the user in case of a win or draw.
////    @Published var alertItem: AlertItem?
//    
//    // A method to handle processing the user's move.
//    func processPlayerMove(for position:Int) {
//        
//        // For human player:
//        // If the square is already occupied, do nothing and return.
//        if isSquareOccupied(in: moves, forIndex: position) {
//            return
//        }
//        
//        // Update the moves array to reflect the human player's move.
//        moves[position] = TicTacToeView.Move(player: .human, boarderIndex: position)
//        
//        // Check if the human player has won the game.
//        if checkWinCondition(for: .human, in: moves) {
// //           alertItem = AlertContent.humanWins
//            return
//        }
//        
//        // Check if the game has ended in a draw.
//        if checkForDraw(in: moves) {
//  //          alertItem = AlertContent.draw
//            return
//        }
//        
//        // Disable the game board to prevent further user interaction.
//        isGameBoardDisabled = true
//        
//        // After a delay of 0.5 seconds, allow the computer to make a move.
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
//            let computerPosition = determineComputerMovePosition(in: moves)
//            moves[computerPosition] = TicTacToeView.Move(player:.computer, boarderIndex: computerPosition)
//            isGameBoardDisabled = false
//            
//            // Check if the computer has won the game.
//            if checkWinCondition(for: .computer, in: moves) {
//   //             alertItem = AlertContent.computerWins
//                return
//            }
//            
//            // Check if the game has ended in a draw.
//            if checkForDraw(in: moves) {
////                alertItem = AlertContent.draw
//                return
//            }
//        }
//    }
//    
//    // A method to check if a square on the board is already occupied.
//    func isSquareOccupied(in moves: [TicTacToeView.Move?], forIndex index: Int) -> Bool {
//        // Returns true if the move in the specified index is already occupied, otherwise false
//        return moves.contains(where: {$0?.boarderIndex == index})
//    }
//    
//    func determineComputerMovePosition(in moves:[TicTacToeView.Move?]) -> Int {
//        // Determines a random unoccupied index for the computer's move
//        let occupiedIndices = Set(moves.compactMap { $0?.boarderIndex })
//        let allIndices = Set(0..<9)
//        let unoccupiedIndices = allIndices.subtracting(occupiedIndices)
//        let randomIndex = unoccupiedIndices.randomElement()!
//        
//        return randomIndex
//    }
//    
//    func checkWinCondition(for player:TicTacToeView.Player, in moves:[TicTacToeView.Move?])->Bool{
//        // Checks whether the specified player has a winning move on the game board
//        let winPatterns:Set<Set<Int>> = [[0,1,2],
//                                         [3,4,5],
//                                         [6,7,8],
//                                         [0,3,6],
//                                         [1,4,7],
//                                         [2,5,8],
//                                         [0,4,8],
//                                         [2,4,6]]
//        let playerMoves = moves.compactMap{$0}.filter {$0.player == player}
//        let playerPositions = Set(playerMoves.map{$0.boarderIndex})
//        
//        for pattern in winPatterns where pattern.isSubset(of: playerPositions){return true}
//        
//        return false
//    }
//    
//    func checkForDraw(in moves:[TicTacToeView.Move?])->Bool{
//        // Checks if the game board is full and there is no winner
//        return moves.compactMap{$0}.count == 9
//    }
//    
//    func resetGame() {
//        // Resets the game board to its initial state
//        moves = Array(repeating: nil, count: 9)
//    }
//    
//}
