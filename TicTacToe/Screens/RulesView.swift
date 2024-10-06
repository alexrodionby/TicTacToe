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
    var navigationTitleText: LocalizedStringKey = LocalizedStringKey("How to play")
    var scrollViewPadding: CGFloat = 21
    
    /// Правила игры, с ключами для сортировки
    var rules: [Int: String] = {
        if UserDefaults.standard.string(forKey: "selectedLanguage") == "en" {
            [
                1 : "Draw a grid with three rows and three columns, creating nine squares in total.",
                2 : "Players take turns placing their marker (X or O) in an empty square. To make a move, a player selects a number corresponding to the square where they want to place their marker.",
                3 : "Player X starts by choosing a square (e.g., square 5). Player O follows by choosing an empty square (e.g., square 1). Continue alternating turns until the game ends.",
                4 : "The first player to align three of their markers horizontally, vertically, or diagonally wins. Examples of Winning Combinations: Horizontal: Squares 1, 2, 3 or 4, 5, 6 or 7, 8, 9 Vertical: Squares 1, 4, 7 or 2, 5, 8 or 3, 6, 9 Diagonal: Squares 1, 5, 9 or 3, 5, 7"
            ]
        } else {
            [
                1 : "Нарисуйте сетку из трех рядов и трех столбцов, создавая в общей сложности девять квадратов.",
                2 : "Игроки по очереди размещают свой маркер (X или O) в пустой клетке. Чтобы сделать ход, игрок выбирает число, соответствующее квадрату, в который он хочет поставить свой маркер.",
                3 : "Игрок X начинает, выбирая квадрат (например, квадрат 5). Затем игрок O выбирает пустой квадрат (например, квадрат 1). Продолжайте чередовать ходы до конца игры.",
                4 : "Первый игрок, который выстроит три своих маркера горизонтально, вертикально или по диагонали, выигрывает. Примеры выигрышных комбинаций: Горизонтально: квадраты 1, 2, 3 или 4, 5, 6 или 7, 8, 9. Вертикально: квадраты 1, 4, 7 или 2, 5, 8 или 3, 6, 9. По диагонали: квадраты 1, 5, 9 или 3, 5, 7."
            ]
        }
    }()
    
    var body: some View {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
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
