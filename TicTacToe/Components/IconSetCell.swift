//
//  IconSetCell.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 5.10.24.
//

import SwiftUI

struct IconSetCell: View {
    
    var xMark: String = "xSkin4"
    var oMark: String = "oSkin4"
    var markHeight: CGFloat = 50
    var markStackWidth: CGFloat = 110
    var titleTextHeight: CGFloat = 40
    var markTextRectangleCornerRadius: CGFloat = 30
    var defaultTitleText: LocalizedStringKey = LocalizedStringKey("Choose")
    var pickedTitleText: LocalizedStringKey = LocalizedStringKey("Picked")
    var isPicked: Bool = false
    var onTapAction: (() -> Void)?
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .center, spacing: 15) {
                HStack(alignment: .center, spacing: 3) {
                    Image(xMark)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(height: markHeight)
                    
                    Image(oMark)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(height: markHeight)
                }
                
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: markTextRectangleCornerRadius, style: .continuous)
                        .fill(isPicked ? .customBlue : .customLightBlue)
                        .frame(height: titleTextHeight)
                    Text(isPicked ? pickedTitleText : defaultTitleText)
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundStyle(isPicked ? .customWhite : .customBlack)
                }
            }
            .frame(width: markStackWidth)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: markTextRectangleCornerRadius, style: .continuous)
                    .fill(.customWhite)
            }
            .shadow(color: .customGray, radius: 30, x: 4, y: 4)
        }
        .onTapGesture {
            onTapAction?()
        }
    }
}

#Preview("LightEN") {
    ZStack {
        Color.customGray
            .ignoresSafeArea()
        
        VStack(spacing: 30) {
            IconSetCell(isPicked: true)
                .environment(\.locale, .init(identifier: "EN"))
                .preferredColorScheme(.light)
            
            IconSetCell(isPicked: false)
                .environment(\.locale, .init(identifier: "EN"))
                .preferredColorScheme(.light)
        }
    }
}
