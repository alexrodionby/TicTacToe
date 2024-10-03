//
//  SelectView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct SelectView: View {
    
    @Environment(GameViewModel.self) private var gameVM
    @Environment(AppRouter.self) private var appRouter
    @Environment(\.presentationMode) var presentationMode
    
    var selectGameTitle: String = "Select Game"
    var singlePlayerImageName: String = "singlePlayer"
    var singlePlayerText: String = "Single Player"
    var twoPlayerImageName: String = "twoPlayers1"
    var twoPlayerText: String = "Two Players"
    var leaderboardImageName: String = "twoPlayers2"
    var leaderboardText: String = "Leaderboard"
    var settingIconName: String = "settingIcon"
    var backgroundRectangleCornerRadius: CGFloat = 30
    var rectangleHeight: CGFloat = 340
    var rectanglePadding: CGFloat = 52
    
    var body: some View {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()
            
            VStack {
                RoundedRectangle(cornerRadius: backgroundRectangleCornerRadius, style: .continuous)
                    .fill(.customWhite)
                    .frame(height: rectangleHeight)
                    .overlay(
                        VStack {
                            Text(selectGameTitle)
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundStyle(.customBlack)
                                .padding(.top, 20)
                            
                            Spacer()
                            
                            MainButton(buttonText: singlePlayerText,   buttonColor: .customBlack,  buttonBackColor: .customLightBlue,    showIconImage: true, iconImageName: singlePlayerImageName) {
                                
                            }
                            .padding(.bottom, 20)
                            
                            MainButton(buttonText: twoPlayerText,   buttonColor: .customBlack,  buttonBackColor: .customLightBlue,    showIconImage: true, iconImageName: twoPlayerImageName) {
                                
                            }
                            .padding(.bottom, 20)
                            
                            MainButton(buttonText: leaderboardText,   buttonColor: .customBlack,  buttonBackColor: .customLightBlue,    showIconImage: true, iconImageName: leaderboardImageName) {
                                
                            }
                            .padding(.bottom, 20)
                        }
                            .padding(.horizontal, 20)
                    )
            }
            .padding(.horizontal, rectanglePadding)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    NavigationBackButton()
                }
                .buttonStyle(.plain)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    /// Переход на экран настроек игры
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
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SelectView()
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
        .environment(GameViewModel())
        .environment(AppRouter())
}
