//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 28.09.24.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    
    @State private var appRouter = AppRouter()
    @State private var gameVM = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                OnboardingView()
            }
            .environment(appRouter)
            .environment(gameVM)
            .preferredColorScheme(.light)
            .dynamicTypeSize(.large)
        }
    }
}
