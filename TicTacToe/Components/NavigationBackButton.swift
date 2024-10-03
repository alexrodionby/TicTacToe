//
//  NavigationBackButton.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 1.10.24.
//

import SwiftUI

/// Кнопка для возвращения назад в навигации, используемая в приложении
struct NavigationBackButton: View {
    
    /// Название изображения для кнопки "Назад"
    let imageName: String = "backIcon"
    
    var body: some View {
        Image(imageName)
            .resizable()                    /// Делаем изображение изменяемого размера
            .scaledToFit()                  /// Масштабируем изображение, сохраняя его пропорции
            .frame(width: 30)               /// Устанавливаем ширину изображения в 30 пикселей
            .foregroundStyle(.customBlack)  /// Устанавливаем цвет изображения
    }
}

#Preview("LightEN") {
    NavigationBackButton()
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
        .scaleEffect(3)
}
