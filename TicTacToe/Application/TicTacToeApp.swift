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
    
    var body: some Scene {
        WindowGroup {
            Group {
                OnboardingView()
            }
            .preferredColorScheme(.light)
            .environment(appRouter)
            .dynamicTypeSize(.large)
        }
    }
}
