//
//  SettingsView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct SettingsView: View {
    @State var selectedIconSet: Int = 0
    @State var isOnTime: Bool = false
    @State var isOnMusic: Bool = false
    
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
                        CustomPicker(options:time,selected: GameModel().selectTimer)
                    }
                    
                    Toggle("Music", isOn: $isOnMusic)
                        .modifier(MainModifier())
                    
                    if isOnMusic {
                        CustomPicker(title:"Select Music",selected:GameModel().selectMusic)
                    }
                }
            }
            .padding()
            .ignoresSafeArea()
            .background(RoundedRectangle(cornerRadius: 30)
                .fill(.customWhite))
           
            SelectIcons()
        }
        .background(.customBackground)
    }
}

#Preview {
    SettingsView()
}
