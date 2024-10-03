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
    var borderIsOn: Bool = false
    var borderWidth: CGFloat = 2
    var buttonBorderColor: Color = .customBlue
    
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
                    if borderIsOn {
                        RoundedRectangle(cornerRadius: buttonCornerRadius, style: .continuous)
                            .stroke(buttonBorderColor, lineWidth: borderWidth)
                            .frame(height: buttonHeight - borderWidth)
                    } else {
                        RoundedRectangle(cornerRadius: buttonCornerRadius, style: .continuous)
                            .fill(buttonBackColor)
                            .frame(height: buttonHeight)
                    }
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview("LightEN") {
    VStack(spacing: 0) {
        MainButton()
            .padding()
            .environment(\.locale, .init(identifier: "EN"))
            .preferredColorScheme(.light)
        
        MainButton(buttonText: "Button", buttonColor: .customBlue, buttonBackColor: .customBackground, borderIsOn: true, buttonBorderColor: .customBlue)
            .padding()
            .environment(\.locale, .init(identifier: "EN"))
            .preferredColorScheme(.light)
    }
}
