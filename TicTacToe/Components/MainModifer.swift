//
//  MainModifer.swift
//  TicTacToe
//
//  Created by Никита Мартьянов on 30.09.24.
//

import SwiftUI

struct MainModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .semibold, design: .default))
            .lineLimit(1)
            .padding()
            .tint(.customBlue)
            .frame(maxWidth: 270, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(.customLightBlue)
                    .frame(height: 70)
            )
    }
}

#Preview {
    SettingsView()
}
