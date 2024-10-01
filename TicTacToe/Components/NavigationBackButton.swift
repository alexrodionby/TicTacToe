//
//  NavigationBackButton.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 1.10.24.
//

import SwiftUI

struct NavigationBackButton: View {
    
    let imageName: String = "backIcon"
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 30)
            .foregroundStyle(.customBlack)
    }
}

#Preview("LightEN") {
    NavigationBackButton()
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
        .scaleEffect(3)
}
