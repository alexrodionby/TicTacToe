//
//  test.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 30.09.24.
//

import SwiftUI
struct TicTacToeView: View {
    // Create an instance of the GameViewModel as a state object
    @StateObject private var viewModel = TicTacToeViewModel()
    // Create image views for the X and O symbols
    let xImage = Image("XImage")
    let oImage = Image("OImage")
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Add space at the top
                Spacer()
                // Create a grid of squares for the game board
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        // Create a ZStack to overlay rectangles and images
                        ZStack {
                            // Create a blue rectangle as the background for the square
                            Rectangle()
                                .foregroundColor(.blue).opacity(0.9)
                                .frame(width: geometry.size.width/3 - 15,
                                       height: geometry.size.width/3 - 15)
                                .cornerRadius(15)
                            // Create a white rectangle as the foreground for the square
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width/3-30,
                                       height: geometry.size.width/3-30)
                                .cornerRadius(10)
                            
                            // Display an X or O image if the square has been filled
                            if let move = viewModel.moves[i] {
                                if move.player == .human {
                                    xImage
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.black)
                                } else {
                                    oImage
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        // When the square is tapped, call the function to process the move
                        .onTapGesture {
                            viewModel.processPlayerMove(for: i)
                        }
                    }
                    // Add space at the bottom
                    Spacer()
                }
                // Disable the game board if a win or draw has been detected
                .disabled(viewModel.isGameBoardDisabled)
                // Add padding to the game board
                .padding()
                // Show an alert if a win or draw has been detected
//                .alert(item: $viewModel.alertItem) { alertItem in
//                    Alert(title: alertItem.title,
//                          message: alertItem.message,
//                          dismissButton: .default(alertItem.buttonTitle, action: { viewModel.resetGame() }))
//                }
                // Add space at the bottom
                Spacer()
            }
        }
    }
    // Define an enumeration for the players (human or computer)
    enum Player {
        case human, computer
    }
    
    // Define a struct for a move, including the player and board index
    struct Move {
        let player: Player
        let boarderIndex: Int
        
        // Provide an indicator for the move (X or O)
        var indicator: String {
            return player == .human ? "xmark" : "circle"
        }
    }
    
    // Define a preview for the view
    struct TicTacToeView_Previews: PreviewProvider {
        static var previews: some View {
            TicTacToeView()
        }
    }
}
