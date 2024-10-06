//
//  OnboardingView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 28.09.24.
//

import SwiftUI

struct OnboardingView: View {
    
    /// Получаем роутер из окружения для управления навигацией
    @Environment(AppRouter.self) private var appRouter
    
    /// Названия изображений и текстов, которые можно изменить для кастомизации
    var logoImageName: String = "xo"
    var logoName: String = "TIC-TAC-TOE"
    var buttonName: LocalizedStringKey = LocalizedStringKey("Let's play")
    var rulesImageName: String = "questionMark"
    var settingsImageName: String = "settingIcon"
    
    var body: some View {
        /// Привязываем объект роутера из окружения с помощью @Bindable для синхронизации данных
        @Bindable var appRouter = appRouter
        
        /// Используем NavigationStack для управления навигацией по экранам
        NavigationStack(path: $appRouter.appRoute) {
            ZStack(alignment: .center) {
                Color.customBackground
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    
                    Image(logoImageName)
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 60)
                    
                    Text(logoName)
                        .font(.system(size: 32, weight: .bold, design: .default))
                        .padding(.top, 31)
                    
                    Spacer()
                    
                    MainButton(buttonText: buttonName) {
                        /// Переход на экран выбора игры
                        appRouter.appRoute.append(.selectgame)
                    }
                    .padding(.horizontal, 21)
                    .padding(.bottom, 80)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            /// Переход на экран правил игры
                            appRouter.appRoute.append(.rules)
                        } label: {
                            Image(rulesImageName)
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(height: 36)
                        }
                        .buttonStyle(.plain)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            /// Переход на экран настроек игры
                            appRouter.appRoute.append(.settings)
                        } label: {
                            Image(settingsImageName)
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(height: 36)
                                .foregroundStyle(.customBlack)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .navigationBarBackButtonHidden(true) /// Отключаем кнопку возврата по умолчанию
                
                /// Настройка маршрутов навигации по экранам
                .navigationDestination(for: MainViewPath.self) { place in
                    switch place {
                    case .rules:
                        RulesView() /// Экран правил
                    case .onboarding:
                        OnboardingView() /// Экран приветствия
                    case .settings:
                        SettingsView() /// Экран настроек
                    case .result:
                        ResultView() /// Экран результатов
                    case .game:
                        GameView() /// Экран игры
                    case .selectgame:
                        SelectView() /// Экран выбора игры
                    case .selectlevel:
                        SelectLevelView() /// Экран выбора уровня
                    case .leaderboard:
                        LeaderboardView() /// Экран сохраненных результатов
                    }
                }
            }
        }
    }
}

#Preview("LightEN") {
    OnboardingView()
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
        .environment(AppRouter())
        .environment(GameViewModel())
}
#Preview("LightEN") {
    OnboardingView()
        .environment(\.locale, .init(identifier: "RU"))
        .preferredColorScheme(.light)
        .environment(AppRouter())
        .environment(GameViewModel())
}
