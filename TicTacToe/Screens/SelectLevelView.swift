//
//  SelectLevelView.swift
//  TicTacToe
//
//  Created by Emir Byashimov on 02.10.2024.
//

import SwiftUI

struct SelectLevelView: View {
    
    @Environment(AppRouter.self) private var appRouter
    
    var settingIconName: String = "settingIcon"
    var selectDifficultyTitle: String = "Select Difficulty"
    var easyLevelText: String = "Easy"
    var mediumLevelText: String = "Medium"
    var hardLevelText: String = "Hard"
    var randomGodLevelText: String = "Random God"
    
    var body: some View {
        ZStack {
            Color.customBackground
            
            VStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.customWhite)
                    .frame(height: 400)
                    .overlay(
                        VStack {
                            Text(selectDifficultyTitle)
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .padding(.top, 20)
                            
                            Spacer()
                            
                            SelectButton(buttonText: easyLevelText) {
                                print("easy")
                            }
                            
                            Spacer()
                            
                            SelectButton(buttonText: mediumLevelText) {
                                print("medium")
                            }
                            
                            Spacer()
                            
                            SelectButton(buttonText: hardLevelText) {
                                print("hard")
                            }
                            
                            Spacer()
                            
                            SelectButton(buttonText: randomGodLevelText) {
                                appRouter.appRoute.append(.game)
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
    SelectLevelView()
        .environment(AppRouter())
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
}
