//
//  MainButton.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct MainButton: View {
    
    var buttonText: LocalizedStringKey = LocalizedStringKey("Button")
    var buttonFontSize: CGFloat = 20
    var buttonFontWeight: Font.Weight = .semibold
    var buttonColor: Color = .customWhite
    var buttonCornerRadius: CGFloat = 30
    var buttonBackColor: Color = .customBlue
    var buttonHeight: CGFloat = 70
    var borderIsOn: Bool = false
    var borderWidth: CGFloat = 2
    var buttonBorderColor: Color = .customBlue
    var showIconImage: Bool = false
    var iconImageName: String = "singlePlayer"
    
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack(alignment: .center, spacing: 10) {
                if showIconImage {
                    Image(iconImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                }
                
                Text(buttonText)
                    .font(.system(size: buttonFontSize, weight: buttonFontWeight, design: .default))
                    .foregroundStyle(buttonColor)
                    .lineLimit(1)
            }
            .padding()
            .frame(maxWidth: .infinity)
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
        
        MainButton(showIconImage: true)
            .padding()
            .environment(\.locale, .init(identifier: "EN"))
            .preferredColorScheme(.light)
    }
}
