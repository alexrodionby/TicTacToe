//
//  ResultView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

enum GameResult {
    case win
    case lose
    case draw
}

struct ResultView: View {
    
    @Environment(AppRouter.self) private var appRouter
    var result: GameResult = .draw
    
    
    var body: some View {
        @Bindable var appRouter = appRouter
        
        NavigationStack(path: $appRouter.appRoute) {
            VStack {
                
                Spacer()
                
                switch result {
                case .win:
                    Text("Player One win!")
                        .font(.system(size: 20, weight: .bold))
                    Image("winIcon")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 60)
                    
                case .lose:
                    Text("You lose!")
                        .font(.system(size: 20, weight: .bold))
                    Image("loseIcon")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 60)
                    
                case .draw:
                    Text("Draw!")
                        .font(.system(size: 20, weight: .bold))
                    Image("drawIcon")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 60)
                }
                
                Spacer()
                
                MainButton(buttonText: "Play again") {
                    print("Нажали кнопку play again")
                    appRouter.appRoute.append(.onboarding)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                
                BackButton(buttonText: "Back") {
                    print("Нажали кнопку back")
                    appRouter.appRoute.append(.onboarding)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    ResultView()
        .environment(\.locale, .init(identifier: "EN"))
        .environment(AppRouter())
}
