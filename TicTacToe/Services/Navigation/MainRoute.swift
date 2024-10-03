//
//  MainRoute.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import Foundation

/// Перечисление всех возможных экранов в приложении
enum MainViewPath {
    case onboarding      /// Экран приветствия
    case rules           /// Экран правил
    case settings        /// Экран настроек
    case result          /// Экран с результатами
    case game            /// Экран игры
    case selectgame      /// Экран выбора игры
    case selectlevel     /// Экран выбора уровня сложности
    case leaderboard     /// Экран сохраненных результатов
}
