//
//  AppRouter.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import Foundation
import Observation

/// Класс для управления навигацией по экранам приложения
@Observable
class AppRouter {
    /// Массив маршрутов для управления переходами между экранами
    var appRoute: [MainViewPath] = []
}
