//
//  BackButton.swift
//  TicTacToe
//
//  Created by Emir Byashimov on 30.09.2024.
//

import SwiftUI

struct BackButton: View {
    
    var buttonText: String = "Back"
    var buttonFontSize: CGFloat = 20
    var buttonFontWeight: Font.Weight = .semibold
    var buttonColor: Color = .customBlue
    var buttonCornerRadius: CGFloat = 30
    var buttonBackColor: Color = .customWhite
    var buttonHeight: CGFloat = 70
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
                    RoundedRectangle(cornerRadius: buttonCornerRadius, style: .continuous)
                        .stroke(buttonBorderColor, lineWidth: 2)
                        .fill(buttonBackColor)
                        .frame(height: buttonHeight)
                }
        }
    }
}

#Preview("LightEN") {
    BackButton()
        .padding()
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
}
