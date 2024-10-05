//
//  LeaderboardView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct LeaderboardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var bestTimes: [Int] = []

    private var leaderboardIsEmpty: Bool {
        bestTimes.isEmpty
    }

    var body: some View {
        VStack {
            ZStack {
                Color.customBackground
                    .ignoresSafeArea()

                if leaderboardIsEmpty {
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
                            HStack(alignment: .top, spacing: 10) {
                                Circle()
                                    .fill(index == 0 ? Color.customPurple : Color.customLightBlue)
                                    .frame(width: 69, height: 69)
                                    .overlay {
                                        Text("\(index + 1)") // Отображаем номер индекса, начиная с 1
                                            .font(.system(size: 20, weight: .regular, design: .default))
                                    }

                                Text(index == 0 ? "Best time: \(formatTime(time))" : "Time: \(formatTime(time))")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 24)
                                    .padding(.horizontal, 24)
                                    .font(.system(size: 18, weight: .regular, design: .default))
                                    .background(index == 0 ? Color.customPurple : Color.customLightBlue)
                                    .cornerRadius(30)
                            }
                        }

                        // Кнопка для очистки `timeStorage`
//                        Button(action: {
//                            clearTimeStorage()
//                        }) {
//                            Text("Очистить историю")
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.red.opacity(0.7))
//                                .foregroundColor(.white)
//                                .cornerRadius(8)
//                        }
                    }
                    .padding(.horizontal, 21)
                    .padding(.top, 40)
                }
            }
            .navigationTitle("Leaderboard")
            .font(.system(size: 24, weight: .bold, design: .default))
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
            .onAppear {
                loadBestTimes()
            }
        }
    }

    /// Функция для загрузки массива `bestTimes`
    private func loadBestTimes() {
        bestTimes = UserDefaults.standard.array(forKey: "timeStorage") as? [Int] ?? []
        bestTimes.sort() // Сортируем значения по возрастанию
    }

    /// Функция для очистки массива `timeStorage`
    private func clearTimeStorage() {
        bestTimes.removeAll() // Очищаем локальную переменную
        UserDefaults.standard.set(bestTimes, forKey: "timeStorage") // Обновляем UserDefaults
    }

    /// Метод для форматирования времени из секунд в формат "мм:сс"
    private func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


#Preview("LightEN") {
    NavigationStack {
        LeaderboardView()
            .environment(\.locale, .init(identifier: "EN"))
            .preferredColorScheme(.light)
            .environment(GameViewModel())
            .environment(AppRouter())
    }
}

