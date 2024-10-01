//
//  RulesView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct RulesView: View {
    
    private let rules: [Int: String] = [
        1 : "Draw a grid with three rows and three columns, creating nine squares in total.",
        2 : "Players take turns placing their marker (X or O) in an empty square. To make a move, a player selects a number corresponding to the square where they want to place their marker.",
        3 : "Player X starts by choosing a square (e.g., square 5). Player O follows by choosing an empty square (e.g., square 1). Continue alternating turns until the game ends.",
        4 : "The first player to align three of their markers horizontally, vertically, or diagonally wins. Examples of Winning Combinations: Horizontal: Squares 1, 2, 3 or 4, 5, 6 or 7, 8, 9 Vertical: Squares 1, 4, 7 or 2, 5, 8 or 3, 6, 9 Diagonal: Squares 1, 5, 9 or 3, 5, 7"
    ]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()
            ScrollView {
                ForEach(rules.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                    HStack(alignment: .top, spacing: 20) {
                        Circle()
                            .fill(Color.customPurple)
                            .frame(width: 45, height: 45)
                            .overlay {
                                Text("\(key)")
                                    .font(.system(size: 20, weight: .regular, design: .default))
                            }
                        
                        Text(value)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .font(.system(size: 18, weight: .regular, design: .default))
                            .background(Color.customLightBlue)
                            .cornerRadius(28)
                    }
                }
            }
            .navigationTitle("How to play")
            
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .navigationBarBackButtonHidden(true) // Скрываем стандартную кнопку "Назад"
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // Возврат к предыдущему экрану
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(.backIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 22)
                            .foregroundStyle(Color.customBlack)
                    }
                }
            }
        }
    }
}

#Preview {
    RulesView()
}
