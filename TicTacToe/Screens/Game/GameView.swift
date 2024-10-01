//
//  GameView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct GameView: View {
    
    @Environment(GameViewModel.self) private var gameVM
    @Environment(\.presentationMode) var presentationMode
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var gridSpacing: CGFloat = 20
    var cellCornerRadius: CGFloat = 20
    var gridBackgroundCornerRadius: CGFloat = 30
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.customBackground
                .ignoresSafeArea()
            
            ZStack(alignment: .center) {
                LazyVGrid(columns: columns, alignment: .center, spacing: gridSpacing) {
                    ForEach(0..<9) { i in
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                                .fill(.customLightBlue)
                                .aspectRatio(1, contentMode: .fit)
                            
                            if let move = gameVM.moves[i] {
                                if move.player == gameVM.firstTurnPlayer {
                                    Image("xSkin5")
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .padding(20)
                                } else {
                                    Image("oSkin5")
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .padding(20)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 5)
                        .onTapGesture {
                            gameVM.processingPlayerMove(move: Move(player: gameVM.currentPlayer, boarderIndex: i))
                        }
                    }
                    
                }
                .padding(20)
            }
            .background {
                RoundedRectangle(cornerRadius: gridBackgroundCornerRadius, style: .continuous)
                    .fill(.customWhite)
            }
            .padding(40)
            
            VStack {
                Spacer()
                Button {
                    gameVM.resetGame()
                } label: {
                    Text("Reset")
                        .padding()
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    NavigationBackButton()
                }
                .buttonStyle(PlainButtonStyle())
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
