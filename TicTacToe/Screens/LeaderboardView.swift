//
//  LeaderboardView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct LeaderboardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var bestTimes: [Int] = {
        UserDefaults.standard.array(forKey: "timeStorage") as? [Int] ?? []
    }().sorted() // Сортируем значения по возрастанию
    
    private var leaderboardIsEpty: Bool {
        bestTimes.isEmpty
    }
    
    var body: some View {
        VStack {
            ZStack {
                Color.customBackground
                    .ignoresSafeArea()
                
                if leaderboardIsEpty {
                    VStack(alignment: .center, spacing: 40) {
                        VStack {
                            Text("No game history")
                            Text("with turn on time")
                        }
                        .font(.system(size: 20, weight: .medium, design: .default))
                        
                        Image(.leaderboard)
                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach(Array(bestTimes.enumerated()), id: \.offset) { index, time in
                            HStack(alignment: .top, spacing: 20) {
                                Circle()
                                    .fill(Color.customLightBlue)
                                    .frame(width: 69, height: 69)
                                    .overlay {
                                        Text("\(index + 1)") // Отображаем номер индекса, начиная с 1
                                            .font(.system(size: 20, weight: .regular, design: .default))
                                    }
                                
                                Text("Best time: \(time) сек")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 24)
                                    .padding(.horizontal, 24)
                                    .font(.system(size: 18, weight: .regular, design: .default))
                                    .background(Color.customLightBlue)
                                    .cornerRadius(30)
                            }
                        }
                        
                        // Кнопка для очистки `timeStorage`
                        Button(action: {
                            clearTimeStorage()
                        }) {
                            Text("Очистить историю")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 21)
                    .padding(.top, 40)
                }
            }
            .navigationTitle("Leaderboard")
            .font(.system(size: 24, weight: .bold, design: .default)) // !
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
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
    
    /// Функция для очистки массива `timeStorage`
    private func clearTimeStorage() {
        bestTimes.removeAll() // Очищаем локальную переменную
        UserDefaults.standard.set(bestTimes, forKey: "timeStorage") // Обновляем UserDefaults
    }
}

#Preview {
    LeaderboardView()
}

