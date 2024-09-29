//
//  OnboardingView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 28.09.24.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(AppRouter.self) private var appRouter
    
    var body: some View {
        @Bindable var appRouter = appRouter
        
        NavigationStack(path: $appRouter.appRoute) {
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                Image("xo")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 60)
                
                Text("TIC-TAC-TOE")
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .padding(.top, 31)
                
                Spacer()
                
                MainButton(buttonText: "Let's play") {
                    print("Нажали кнопку летс плэй")
                }
                .padding(.horizontal)
                .padding(.bottom, 80)
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("Нажали переход на экрна правил")
                        appRouter.appRoute.append(.rules)
                    } label: {
                        Image("questionMark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 36)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Нажали переход на экрна настроек")
                        appRouter.appRoute.append(.settings)
                    } label: {
                        Image("settingIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 36)
                            .foregroundStyle(.customBlack)
                    }
                }
            }
            .navigationDestination(for: MainViewPath.self) { place in
                switch place {
                case .rules:
                    RulesView()
                case .onboarding:
                    OnboardingView()
                case .settings:
                    SettingsView()
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
