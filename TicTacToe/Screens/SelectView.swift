//
//  SelectView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct SelectView: View {
    
    /// Получаем доступ к модели игры через окружение
    @Environment(GameViewModel.self) private var gameVM
    /// Получаем доступ к роутеру приложения через окружение
    @Environment(AppRouter.self) private var appRouter
    /// Переменная для управления закрытием экрана
    @Environment(\.presentationMode) var presentationMode
    
    /// Настраиваемые параметры для текста, изображений и стиля
    var selectGameTitle: String = "Select Game"
    var singlePlayerImageName: String = "singlePlayer"
    var singlePlayerText: LocalizedStringKey = LocalizedStringKey("Single Player")
    var twoPlayerImageName: String = "twoPlayers1"
    var twoPlayerText: LocalizedStringKey = LocalizedStringKey("Two Players")
    var leaderboardImageName: String = "twoPlayers2"
    var leaderboardText: LocalizedStringKey = LocalizedStringKey("Leaderboard")
    var settingIconName: String = "settingIcon"
    var backgroundRectangleCornerRadius: CGFloat = 30
    var rectangleHeight: CGFloat = 340
    var rectanglePadding: CGFloat = 52
    
    var body: some View {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()
            
            VStack {
                RoundedRectangle(cornerRadius: backgroundRectangleCornerRadius, style: .continuous)
                    .fill(.customWhite)
                    .frame(height: rectangleHeight)
                    .overlay(
                        VStack {
                            Text(selectGameTitle)
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundStyle(.customBlack)
                                .padding(.top, 20)
                            
                            Spacer()
                            
                            MainButton(buttonText: singlePlayerText, buttonColor: .customBlack, buttonBackColor: .customLightBlue, showIconImage: true, iconImageName: singlePlayerImageName) {
                                gameVM.firstTurnPlayer = .playerOne
                                gameVM.secondTurnPlayer = .computer
                                gameVM.currentPlayer = .playerOne
                                /// Переход на экран выбора уровня
                                appRouter.appRoute.append(.selectlevel)
                            }
                            .padding(.bottom, 20)
                            
                            MainButton(buttonText: twoPlayerText, buttonColor: .customBlack, buttonBackColor: .customLightBlue, showIconImage: true, iconImageName: twoPlayerImageName) {
                                gameVM.firstTurnPlayer = .playerOne
                                gameVM.secondTurnPlayer = .playerTwo
                                gameVM.currentPlayer = .playerOne
                                /// Переход на экран игры
                                appRouter.appRoute.append(.game)
                            }
                            .padding(.bottom, 20)
                            
                            MainButton(buttonText: leaderboardText, buttonColor: .customBlack, buttonBackColor: .customLightBlue, showIconImage: true, iconImageName: leaderboardImageName) {
                                /// Переход на экран сохраненных результатов
                                appRouter.appRoute.append(.leaderboard)
                            }
                            .padding(.bottom, 20)
                        }
                            .padding(.horizontal, 20)
                    )
            }
            .padding(.horizontal, rectanglePadding)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    NavigationBackButton()
                }
                .buttonStyle(.plain)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    /// Переход на экран настроек игры
                    appRouter.appRoute.append(.settings)
                } label: {
                    Image(settingIconName)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(height: 36)
                        .foregroundStyle(.customBlack)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview("LightEN") {
    NavigationStack {
        SelectView()
            .environment(\.locale, .init(identifier: "EN"))
            .preferredColorScheme(.light)
            .environment(GameViewModel())
            .environment(AppRouter())
    }
}
