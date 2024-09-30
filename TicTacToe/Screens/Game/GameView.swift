//
//  GameView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct GameView: View {
    
    @Environment(GameViewModel.self) private var gameVM
    
    var columns: [GridItem] = [GridItem(.flexible(), spacing: 10), GridItem(.flexible()), GridItem(.flexible())]

    var gridSpacing: CGFloat = 20
    var cellCornerRadius: CGFloat = 20
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                LazyVGrid(columns: columns, alignment: .center, spacing: gridSpacing) {
                    ForEach(0..<9) { i in
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                                .fill(.customLightBlue)
                                .frame(width: geometry.size.width / 3 - gridSpacing + 2, height: geometry.size.width / 3 - gridSpacing, alignment: .center)
                              
                            
                            if let move = gameVM.moves[i] {
                                if move.player == .playerOne {
                                    Image("xSkin5")
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .center)
                                } else {
                                    Image("oSkin5")
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .center)
                                }
                            }
                        }
                        .onTapGesture {
                            gameVM.processingPlayerMove(move: Move(player: gameVM.currentPlayer, boarderIndex: i))
                        }
                    }
                }
                Button {
                    gameVM.resetGame()
                } label: {
                    Text("Reset")
                        .padding()
                }

            }
        }
    }
}

#Preview("LightEN") {
    GameView()
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
        .environment(GameViewModel())
}
