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
    /// Инициализируем менеджер смены языка приложения
    @State private var languageManager = LanguageManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                /// Стартовый экран
                OnboardingView()
            }
            /// Передаем роутер и модель игры через окружение (Environment)
            .environment(appRouter) /// Роутинг по экранам приложения
            .environment(gameVM) /// Управление состоянием игры, игровой движок
            .environment(languageManager) /// Управление языком приложения
            .environment(\.locale, .init(identifier: languageManager.currentLanguage))
            .preferredColorScheme(.light) /// Приложение всегда работает в светлой теме
            .dynamicTypeSize(.large) /// Устанавливаем динамический размер текста принудительно
        }
    }
}
