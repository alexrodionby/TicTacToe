//
//  OnboardingView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 28.09.24.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject private var appRouter: AppRouter
    
    var body: some View {
        NavigationStack(path: $appRouter.mainAppRoute) {
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
                        appRouter.mainAppRoute.append(.rules)
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
                        appRouter.mainAppRoute.append(.settings)
                    } label: {
                        Image("settingIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 36)
                            .foregroundStyle(.customBlack)
                    }
                }
            }
            .navigationDestination(for: MainRoute.self) { place in
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
        .environmentObject(AppRouter())
}
