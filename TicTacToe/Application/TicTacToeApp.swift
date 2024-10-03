//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 28.09.24.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    
    /// Инициализируем класс роутера по экранам AppRouter
    @State private var appRouter = AppRouter()
    /// Инициализируем игровой движок в виде класса GameViewModel
    @State private var gameVM = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                /// Стартовый экран
                OnboardingView()
            }
            /// Передаем роутер и модель игры через окружение (Environment)
            .environment(appRouter) /// Роутинг по экранам приложения
            .environment(gameVM) /// Управление состоянием игры, игровой движок
            .preferredColorScheme(.light) /// Приложение всегда работает в светлой теме
            .dynamicTypeSize(.large) /// Устанавливаем динамический размер текста принудительно
        }
    }
}
