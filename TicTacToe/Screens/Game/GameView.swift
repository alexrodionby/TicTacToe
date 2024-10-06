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
    var nameTitleViewCornerRadius: CGFloat = 30
    var nameTitleViewHeight: CGFloat = 105
    var nameTitleIconHeight: CGFloat = 54
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.customBackground
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 0) {
                
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .center, spacing: 0) {
                        Image(gameVM.xMark)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(height: nameTitleIconHeight, alignment: .center)
                        
                        Text(LocalizedStringKey(gameVM.getPlayerName(player: gameVM.firstTurnPlayer)))
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .foregroundStyle(.customBlack)
                            .padding(.top, 10)
                    }
                    .background {
                        RoundedRectangle(cornerRadius: nameTitleViewCornerRadius, style: .continuous)
                            .fill(.customLightBlue)
                            .frame(width: nameTitleViewHeight, height: nameTitleViewHeight, alignment: .center)
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    if gameVM.gameWithTimer {
                        Text(gameVM.currentPlayer == gameVM.firstTurnPlayer ? "\(gameVM.playerOneTimeLeft)" : "\(gameVM.playerTwoTimeLeft)")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundStyle(.customBlack)
                    } else {
                        Text(" ")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 0) {
                        Image(gameVM.oMark)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(height: nameTitleIconHeight, alignment: .center)
                        
                        Text(LocalizedStringKey(gameVM.getPlayerName(player: gameVM.secondTurnPlayer)))
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .foregroundStyle(.customBlack)
                            .padding(.top, 10)
                    }
                    .background {
                        RoundedRectangle(cornerRadius: nameTitleViewCornerRadius, style: .continuous)
                            .fill(.customLightBlue)
                            .frame(width: nameTitleViewHeight, height: nameTitleViewHeight, alignment: .center)
                    }
                    .padding(.horizontal, 40)
                }
                .padding(.top, 20)
                
                HStack() {
                    Image(gameVM.currentPlayer == gameVM.firstTurnPlayer ? gameVM.xMark : gameVM.oMark)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(height: nameTitleIconHeight, alignment: .center)
                    
                    Text(LocalizedStringKey("\(gameVM.getPlayerName(player: gameVM.currentPlayer)) turn"))
                        .font(.system(size: 20, weight: .bold, design: .default))
                }
                .padding(.top, 30)
                
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
                                if gameVM.currentPlayer == .computer {
                                    gameVM.boardIsDisable = true
                                }
                            }
                        }
                    }
                    .padding(20)
                    .padding(.vertical, 5)
                    
                    // Добавляем линию, если есть выигрышный паттерн
                    if let pattern = gameVM.winningPattern {
                        WinningLineView(winningPattern: pattern)
                    }
                    
                }
                .disabled(gameVM.boardIsDisable)
                .background {
                    RoundedRectangle(cornerRadius: gridBackgroundCornerRadius, style: .continuous)
                        .fill(.customWhite)
                }
                .padding(.horizontal, 40)
                .padding(.top, 30)
                
                VStack {
                    Spacer()
                    Text("Powered by DevRush")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundStyle(.customBlue)
                }
            }
        }
        .onChange(of: gameVM.gameState) { oldValue, newValue in
            switch newValue {
            case .finish:
                Task {
                    try? await Task.sleep(for: .seconds(1))
                    if gameVM.sfxOn {
                        gameVM.playSoundEffect(name: "Win")
                    }
                    gameVM.saveBestTime()
                    appRouter.appRoute.append(.result)
                }
            case .inProgress:
                return
            case .pause:
                return
            case .notStarted:
                return
            }
        }
        .onChange(of: gameVM.currentPlayer) { oldValue, newValue in
            if oldValue == Player.playerOne && newValue == Player.computer {
                Task {
                    if gameVM.moves.contains(where: {$0 == nil}) {
                        switch gameVM.gameLevel {
                        case .easy:
                            await gameVM.computerEasyMove()
                        case .medium:
                            await gameVM.computerMediumMove()
                        case .hard:
                            await gameVM.computerHardMove()
                        case .randomGod:
                            await gameVM.computerRandomMove()
                        }
                    }
                }
            }
        }
        .onAppear {
            gameVM.startMusicIfEnabled()
            gameVM.startGame()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                    gameVM.stopMusic()
                } label: {
                    NavigationBackButton()
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview("LightEN") {
    NavigationStack {
        GameView()
            .environment(\.locale, .init(identifier: "EN"))
            .preferredColorScheme(.light)
            .environment(GameViewModel())
            .environment(AppRouter())
    }
}
