//
//  SettingsTogleView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 5.10.24.
//

import SwiftUI

struct SettingsToggleView: View {
    
    @Binding var toogleIsOn: Bool
    
    var backgroundCornerRadius: CGFloat = 30
    var toggleTextTitle: LocalizedStringKey = LocalizedStringKey("Game Time")
    var toggleViewHeight: CGFloat = 70
    
    var body: some View { 
        HStack(alignment: .center, spacing: 0) {
            Toggle(isOn: $toogleIsOn) {
                Text(toggleTextTitle)
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .foregroundStyle(.customBlack)
            }
            .tint(.customBlue)
            .padding(.horizontal, 20)
        }
        .frame(height: toggleViewHeight)
        .background {
            RoundedRectangle(cornerRadius: backgroundCornerRadius, style: .continuous)
                .fill(.customLightBlue)
        }
    }
}

#Preview("LightEN") {
    SettingsToggleView(toogleIsOn: .constant(false))
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
        .padding()
}
