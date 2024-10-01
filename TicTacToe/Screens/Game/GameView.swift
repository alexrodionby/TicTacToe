//
//  GameView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct GameView: View {
    
    @Environment(GameViewModel.self) private var gameVM
    @Environment(AppRouter.self) private var appRouter
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
                                    Image(gameVM.xMark)
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .padding(15)
                                } else {
                                    Image(gameVM.oMark)
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .padding(15)
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
                .padding(.vertical, 5)
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
        .onChange(of: gameVM.gameState) { oldValue, newValue in
            switch newValue {
            case .finish:
                print("Игра закончена")
                appRouter.appRoute.append(.result)
            case .inProgress:
                return
            case .pause:
                return
            case .notStarted:
                return
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
