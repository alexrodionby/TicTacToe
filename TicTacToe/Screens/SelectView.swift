//
//  SelectView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct SelectView: View {
    
    @Environment(AppRouter.self) private var appRouter
    
    var selectGameTitle: String = "Select Game"
    var singlePlayerImageName: String = "singlePlayer"
    var singlePlayerText: String = "Single Player"
    var twoPlayerImageName: String = "twoPlayers1"
    var twoPlayerText: String = "Two Players"
    var leaderboardImageName: String = "twoPlayers2"
    var leaderboardText: String = "Leaderboard"
    var settingIconName: String = "settingIcon"
    
    var body: some View {
        ZStack {
            Color.customBackground
            
            VStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.customWhite)
                    .frame(height: 352)
                    .overlay(
                        VStack {
                            Text(selectGameTitle)
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .padding(.top, 20)
                            
                            Spacer()
                            
                            SelectButton(imageName: singlePlayerImageName, buttonText: singlePlayerText) {
                                appRouter.appRoute.append(.selectlevel)
                            }
                            
                            Spacer()
                            
                            SelectButton(imageName: twoPlayerImageName, buttonText: twoPlayerText) {
                                print("Two Players button tapped")
                            }
                            
                            Spacer()
                            
                            SelectButton(imageName: leaderboardImageName, buttonText: leaderboardText) {
                                print("Leaderboard button tapped")
                            }
                            
                            Spacer()
                            
                        }
                    )
                    .padding(.horizontal, 40)
            }
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
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
                
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    appRouter.appRoute.removeLast()
                } label: {
                    NavigationBackButton()
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SelectView()
        .environment(AppRouter())
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
}
