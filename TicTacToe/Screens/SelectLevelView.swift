//
//  SelectLevelView.swift
//  TicTacToe
//
//  Created by Emir Byashimov on 02.10.2024.
//

import SwiftUI

struct SelectLevelView: View {
    
    /// Получаем доступ к модели игры через окружение
    @Environment(GameViewModel.self) private var gameVM
    /// Получаем доступ к роутеру приложения через окружение
    @Environment(AppRouter.self) private var appRouter
    /// Переменная для управления закрытием экрана
    @Environment(\.presentationMode) var presentationMode
    
    /// Настраиваемые параметры для текста, изображений и стиля
    var settingIconName: String = "settingIcon"
    var selectDifficultyTitle: String = "Select Difficulty"
    var easyLevelText: LocalizedStringKey = LocalizedStringKey("Easy")
    var mediumLevelText: LocalizedStringKey = LocalizedStringKey("Medium")
    var hardLevelText: LocalizedStringKey = LocalizedStringKey("Hard")
    var randomGodLevelText: LocalizedStringKey = LocalizedStringKey("Random God")
    var backgroundRectangleCornerRadius: CGFloat = 30
    var rectangleHeight: CGFloat = 410
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
                            Text(selectDifficultyTitle)
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundStyle(.customBlack)
                                .padding(.top, 20)
                            
                            Spacer()
                            
                            MainButton(buttonText: easyLevelText, buttonColor: .customBlack, buttonBackColor: .customLightBlue) {
                                /// Выбираем уровень сложности и переходим на экран игры
                                gameVM.resetGame()
                                gameVM.gameLevel = .easy
                                appRouter.appRoute.append(.game)
                            }
                            .padding(.bottom, 20)
                            
                            MainButton(buttonText: mediumLevelText, buttonColor: .customBlack, buttonBackColor: .customLightBlue) {
                                /// Выбираем уровень сложности и переходим на экран игры
                                gameVM.resetGame()
                                gameVM.gameLevel = .medium
                                appRouter.appRoute.append(.game)
                            }
                            .padding(.bottom, 20)
                            
                            MainButton(buttonText: hardLevelText, buttonColor: .customBlack, buttonBackColor: .customLightBlue) {
                                /// Выбираем уровень сложности и переходим на экран игры
                                gameVM.resetGame()
                                gameVM.gameLevel = .hard
                                appRouter.appRoute.append(.game)
                            }
                            .padding(.bottom, 20)
                            
                            MainButton(buttonText: randomGodLevelText, buttonColor: .customBlack, buttonBackColor: .customLightBlue) {
                                /// Выбираем уровень сложности и переходим на экран игры
                                gameVM.resetGame()
                                gameVM.gameLevel = .randomGod
                                gameVM.gameState = .inProgress
                                appRouter.appRoute.append(.game)
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

#Preview {
    NavigationStack {
        SelectLevelView()
            .environment(\.locale, .init(identifier: "EN"))
            .preferredColorScheme(.light)
            .environment(GameViewModel())
            .environment(AppRouter())
    }
}
