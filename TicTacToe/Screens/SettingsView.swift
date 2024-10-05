//
//  SettingsView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct SettingsView: View {
    
    /// Получаем доступ к модели игры через окружение
    @Environment(GameViewModel.self) private var gameVM
    /// Получаем доступ к роутеру приложения через окружение
    @Environment(AppRouter.self) private var appRouter
    /// Переменная для управления закрытием экрана
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectedIconSet: Int = 0
    @State var isOnTime: Bool = false
    @State var isOnMusic: Bool = false {
            didSet {
                gameVM.isMusicOn = isOnMusic // Обновляем статус музыки
            }
        }
    
    let musicOptions = ["Classical", "Instrumentals", "Nature"]
    let time = ["30 min", "60 min", "120 min","30 min", "60 min", "120 min"]
    
    var body: some View {
        ScrollView {
            Text("Settings")
                .font(.system(size: 24, weight: .bold, design: .default))
                .padding()
            
            VStack {
                VStack(spacing: 25) {
                    Toggle("Game Time", isOn: $isOnTime)
                        .modifier(MainModifier())
                    
                    if isOnTime {
                        CustomPicker(options: time, selected: GameViewModel().selectTimer)
                    }
                    
                    Toggle("Music", isOn: $isOnMusic)
                        .modifier(MainModifier())
                    
                    
                    if isOnMusic {
                        CustomPicker(title: "Select Music", selected: GameViewModel().selectMusic)
                    }
                }
            }
            .padding()
            .ignoresSafeArea()
            .background(RoundedRectangle(cornerRadius: 30)
                .fill(.customWhite))
           
            SelectIcons()
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
        }
        .navigationBarBackButtonHidden(true)
        .background(.customBackground)
    }
}

#Preview("LightEN") {
    NavigationStack {
        SettingsView()
            .environment(\.locale, .init(identifier: "EN"))
            .preferredColorScheme(.light)
            .environment(GameViewModel())
            .environment(AppRouter())
    }
}
