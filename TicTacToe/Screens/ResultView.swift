//
//  ResultView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct ResultView: View {
    /// Получаем доступ к модели игры через окружение
    @Environment(GameViewModel.self) private var gameVM
    /// Получаем доступ к роутеру приложения через окружение
    @Environment(AppRouter.self) private var appRouter
    /// Переменная для управления закрытием экрана
    @Environment(\.presentationMode) var presentationMode
    
    /// Переменные для кастомизации текста и изображений в зависимости от результата игры
    var playerLoseText: LocalizedStringKey = LocalizedStringKey("You Lose!")
    var playerLoseImage: String = "loseIcon"
    var playerOneWinText: LocalizedStringKey = LocalizedStringKey("Player One Win!")
    var playerOneWinImage: String = "winIcon"
    var playerTwoWinText: LocalizedStringKey = LocalizedStringKey("Player Two Win!")
    var playerTwoWinImage: String = "winIcon"
    var drawText: LocalizedStringKey = LocalizedStringKey("Draw!")
    var drawImage: String = "drawIcon"
    
    /// Настройки внешнего вида
    var imagePadding: CGFloat = 81
    var centralSpacing: CGFloat = 20
    var playAgainButtonText: LocalizedStringKey = LocalizedStringKey("Play again")
    var backButtonText: LocalizedStringKey = LocalizedStringKey("Back")
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.customBackground
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                /// Определяем, кто выиграл, и выводим соответствующий экран
                switch gameVM.whoWin {
                case .computer:
                    VStack(alignment: .center, spacing: centralSpacing) {
                        Text(playerLoseText)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundStyle(.customBlack)
                        Image(playerLoseImage)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .padding(.horizontal, imagePadding)
                    }
                case .draw:
                    VStack(alignment: .center, spacing: centralSpacing) {
                        Text(drawText)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundStyle(.customBlack)
                        Image(drawImage)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .padding(.horizontal, imagePadding)
                    }
                case .playerOne:
                    VStack(alignment: .center, spacing: centralSpacing) {
                        Text(playerOneWinText)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundStyle(.customBlack)
                        Image(playerOneWinImage)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .padding(.horizontal, imagePadding)
                    }
                case .playerTwo:
                    VStack(alignment: .center, spacing: centralSpacing) {
                        Text(playerTwoWinText)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundStyle(.customBlack)
                        Image(playerTwoWinImage)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .padding(.horizontal, imagePadding)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .center, spacing: 25) {
                    MainButton(buttonText: playAgainButtonText) {
                        gameVM.resetGame() /// Сбрасываем состояние игры
                        appRouter.appRoute.removeLast() /// Переходим на предыдущий экран
                    }
                    
                    MainButton(buttonText: backButtonText, buttonColor: .customBlue, buttonBackColor: .customBackground, borderIsOn: true, buttonBorderColor: .customBlue) {
                        gameVM.resetGame()
                        gameVM.stopMusic()
                        /// Ищем первое появление экрана выбора игры и переходим на него
                        if let firstIndex = appRouter.appRoute.firstIndex(where: { $0 == .selectgame }) {
                            /// Обрезаем массив до первого появления экрана SelectGame
                            appRouter.appRoute = Array(appRouter.appRoute.prefix(through: firstIndex))
                        }
                    }
                }
            }
            .padding(21)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ResultView()
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
        .environment(GameViewModel())
        .environment(AppRouter())
}

#Preview {
    ResultView()
        .environment(\.locale, .init(identifier: "RU"))
        .preferredColorScheme(.light)
        .environment(GameViewModel())
        .environment(AppRouter())
}
