//
//  MainButton.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct MainButton: View {
    
    var buttonText: String = "Button"
    var buttonFontSize: CGFloat = 20
    var buttonFontWeight: Font.Weight = .semibold
    var buttonColor: Color = .customWhite
    var buttonCornerRadius: CGFloat = 30
    var buttonBackColor: Color = .customBlue
    var buttonHeight: CGFloat = 70
    
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(buttonText)
                .frame(maxWidth: .infinity)
                .font(.system(size: buttonFontSize, weight: buttonFontWeight, design: .default))
                .foregroundStyle(buttonColor)
                .lineLimit(1)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: buttonCornerRadius, style: .continuous)
                        .fill(buttonBackColor)
                        .frame(height: buttonHeight)
                }
        }
    }
}

#Preview("LightEN") {
    MainButton()
        .padding()
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
}
