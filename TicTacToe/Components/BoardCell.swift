//
//  BoardCell.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 30.09.24.
//

import SwiftUI

struct BoardCell: View {
    
    var cellImage: String = "xSkin4"
    var cellCornerRadius: CGFloat = 50
    var imagePadding: CGFloat = 20
    
    var tapAction: (() -> Void)?
    
    var body: some View {
        Image(cellImage)
            .resizable()
            .scaledToFit()
            .padding(imagePadding)
            .background {
                RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                    .fill(.customLightBlue)
            }
            .onTapGesture {
                tapAction?()
            }
    }
}

#Preview("LightEN") {
    BoardCell()
        .padding()
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
}
