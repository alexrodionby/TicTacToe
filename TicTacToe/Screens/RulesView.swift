//
//  RulesView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct RulesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    /// Переменные, которые можно изменить для кастомизации
    var numberIconHeight: CGFloat = 45
    var textBackgroundCornerRadius: CGFloat = 30
    var navigationTitleText: String = "How to play"
    var scrollViewPadding: CGFloat = 21
    
    /// Правила игры, с ключами для сортировки
    private let rules: [Int: String] = [
        1 : "Draw a grid with three rows and three columns, creating nine squares in total.",
        2 : "Players take turns placing their marker (X or O) in an empty square. To make a move, a player selects a number corresponding to the square where they want to place their marker.",
        3 : "Player X starts by choosing a square (e.g., square 5). Player O follows by choosing an empty square (e.g., square 1). Continue alternating turns until the game ends.",
        4 : "The first player to align three of their markers horizontally, vertically, or diagonally wins. Examples of Winning Combinations: Horizontal: Squares 1, 2, 3 or 4, 5, 6 or 7, 8, 9 Vertical: Squares 1, 4, 7 or 2, 5, 8 or 3, 6, 9 Diagonal: Squares 1, 5, 9 or 3, 5, 7"
    ]
    
    var body: some View {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()
            
            ScrollView {
                /// Перебираем и отображаем каждое правило с номером
                ForEach(rules.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                    HStack(alignment: .top, spacing: 20) {
                        ZStack(alignment: .center) {
                            Circle()
                                .fill(.customPurple)
                                .frame(height: numberIconHeight, alignment: .center)
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundStyle(.customBlack)
                            
                            Text("\(key)")
                                .font(.system(size: 20, weight: .regular, design: .default))
                                .foregroundStyle(.customBlack)
                        }
                        
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: textBackgroundCornerRadius, style: .continuous)
                                .fill(.customLightBlue)
                            
                            Text(value)
                                .font(.system(size: 18, weight: .regular, design: .default))
                                .foregroundStyle(.customBlack)
                                .padding()
                        }
                    }
                }
            }
            .padding(scrollViewPadding)
            .navigationTitle(navigationTitleText)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        NavigationBackButton()
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview("LightEN") {
    NavigationStack {
        RulesView()
            .environment(\.locale, .init(identifier: "EN"))
            .preferredColorScheme(.light)
            .environment(AppRouter())
    }
}
