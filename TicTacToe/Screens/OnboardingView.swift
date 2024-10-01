//
//  OnboardingView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 28.09.24.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(AppRouter.self) private var appRouter
    
    var logoImageName: String = "xo"
    var logoName: String = "TIC-TAC-TOE"
    var buttonName: String = "Let's play"
    var rulesImageName: String = "questionMark"
    var settingsImageName: String = "settingIcon"
    
    var body: some View {
        @Bindable var appRouter = appRouter
        
        NavigationStack(path: $appRouter.appRoute) {
            ZStack(alignment: .center) {
                Color.customBackground
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    
                    Image(logoImageName)
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 60)
                    
                    Text(logoName)
                        .font(.system(size: 32, weight: .bold, design: .default))
                        .padding(.top, 31)
                    
                    Spacer()
                    
                    MainButton(buttonText: buttonName) {
                        // Переход на следующий экран экран
                        appRouter.appRoute.append(.game)
                    }
                    .padding(.horizontal, 21)
                    .padding(.bottom, 80)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            // Переход на экран правил игры
                            appRouter.appRoute.append(.rules)
                        } label: {
                            Image(rulesImageName)
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(height: 36)
                        }
                        .buttonStyle(.plain)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            // Переход на экран настроек игры
                            appRouter.appRoute.append(.settings)
                        } label: {
                            Image(settingsImageName)
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(height: 36)
                                .foregroundStyle(.customBlack)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationDestination(for: MainViewPath.self) { place in
                    switch place {
                    case .rules:
                        RulesView()
                    case .onboarding:
                        OnboardingView()
                    case .settings:
                        SettingsView()
                    case .result:
                        ResultView()
                    case .game:
                        GameView()
                    }
                }
            }
        }
    }
}

#Preview("LightEN") {
    OnboardingView()
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
        .environment(AppRouter())
}
