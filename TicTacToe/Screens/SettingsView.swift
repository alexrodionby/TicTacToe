//
//  SettingsView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 5.10.24.
//

import SwiftUI

struct SettingsView: View {
    
    /// Получаем доступ к модели игры через окружение
    @Environment(GameViewModel.self) private var gameVM
    /// Получаем доступ к роутеру приложения через окружение
    @Environment(AppRouter.self) private var appRouter
    /// Переменная для управления закрытием экрана
    @Environment(\.presentationMode) var presentationMode
    /// Получаем доступ к менеджеру языков приложения
    @Environment(LanguageManager.self) var languageManager
    
    var backgroundCornerRadius: CGFloat = 30
    var toggleTimerText: LocalizedStringKey = LocalizedStringKey("Game Time")
    var toggleMusicText: LocalizedStringKey = LocalizedStringKey("Music")
    var toggleSFXText: LocalizedStringKey = LocalizedStringKey("Sound FX")
    var toogleVstackSpacing: CGFloat = 20
    var navigationTitleText: LocalizedStringKey = LocalizedStringKey("Settings")
    var languageToggleTextTitle: LocalizedStringKey = LocalizedStringKey("English / Russian")
    @State var languageToggleState: Bool = false
    
    let iconSets = [
        ["xSkin4", "oSkin4"],
        ["xSkin5", "oSkin5"],
        ["xSkin6", "oSkin6"],
        ["xSkin3", "oSkin3"],
        ["xSkin2", "oSkin2"],
        ["xSkin1", "oSkin1"]
    ]
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.customBackground
                .ignoresSafeArea()
            
            @Bindable var gameVM = gameVM
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 40) {
                    VStack(alignment: .center, spacing: toogleVstackSpacing) {
                        SettingsToggleView(toogleIsOn: $languageToggleState, toggleTextTitle: languageToggleTextTitle)
                        
                        SettingsToggleView(toogleIsOn: $gameVM.gameWithTimer, toggleTextTitle: toggleTimerText)
                        
                        if gameVM.gameWithTimer == true {
                            SettingsPickerView(pickerTitle: "Duration")
                        }
                        
                        SettingsToggleView(toogleIsOn: $gameVM.gameWithMusic, toggleTextTitle: toggleMusicText)
                        
                        if gameVM.gameWithMusic == true {
                            SettingsPickerView(pickerTitle: "Select Music")
                        }
                        
                        SettingsToggleView(toogleIsOn: $gameVM.sfxOn, toggleTextTitle: toggleSFXText)
                    }
                    .padding(toogleVstackSpacing)
                    .background {
                        RoundedRectangle(cornerRadius: backgroundCornerRadius, style: .continuous)
                            .fill(.customWhite)
                    }
                    
                    VStack(alignment: .center, spacing: 0) {
                        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 20) {
                            ForEach(0..<6) { item in
                                IconSetCell(
                                    xMark: iconSets[item][0],
                                    oMark: iconSets[item][1],
                                    isPicked: gameVM.xMark == iconSets[item][0] && gameVM.oMark == iconSets[item][1] /// Проверка выбранных иконок
                                ) {
                                    /// Обновляем иконки в модели игры при выборе ячейки
                                    gameVM.xMark = iconSets[item][0]
                                    gameVM.oMark = iconSets[item][1]
                                }
                            }
                        }
                    }
                }
                .padding(21)
            }
        }
        .onAppear {
            if UserDefaults.standard.string(forKey: "selectedLanguage") == "en" {
                languageToggleState = false
            } else {
                languageToggleState = true
            }
        }
        .onChange(of: languageToggleState) { old, new in
            if new {
                languageManager.currentLanguage = "ru"
            } else {
                languageManager.currentLanguage = "en"
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(navigationTitleText)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    NavigationBackButton()
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview("LightEN") {
    NavigationStack {
        SettingsView()
            .environment(\.locale, .init(identifier: "EN"))
            .preferredColorScheme(.light)
            .environment(GameViewModel())
            .environment(AppRouter())
            .environment(LanguageManager())
    }
}
