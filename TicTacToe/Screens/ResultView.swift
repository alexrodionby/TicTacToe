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
    @Environment(\.presentationMode) var presentationMode
    var result: GameResult = .draw
    
    
    var body: some View {
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
                    appRouter.appRoute.removeAll()
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                
                BackButton(buttonText: "Back") {
                    print("Нажали кнопку back")
                    appRouter.appRoute.removeLast()
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .background(.customBackground)
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ResultView()
        .environment(\.locale, .init(identifier: "EN"))
        .environment(AppRouter())
}
