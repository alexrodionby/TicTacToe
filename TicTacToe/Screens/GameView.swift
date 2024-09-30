//
//  GameView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct GameView: View {
    @StateObject private var timerManager = GameTimerManager(initialTime: 0)
    @State private var selectedMinutes: Int = 0
    @State private var selectedSeconds: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            // Таймер для Игрока 1 и Игрока 2
            Text("Player One Time: \(timerManager.playerOneTimeRemaining) sec")
            Text("Player Two Time: \(timerManager.playerTwoTimeRemaining) sec")

            // DatePicker для выбора времени в минутах и секундах
            VStack {
                Text("Выберите время для игроков:")
                HStack {
                    Picker("Минуты", selection: $selectedMinutes) {
                        ForEach(0..<60) { minute in
                            Text("\(minute) мин").tag(minute)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100)

                    Picker("Секунды", selection: $selectedSeconds) {
                        ForEach(0..<60) { second in
                            Text("\(second) сек").tag(second)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100)
                }
                .padding()
            }

            // Кнопка для передачи хода от Игрока 1 к Игроку 2
            Button("Игрок - 1 передал ход") {
                guard totalSelectedTime() > 0 else {
                    print("Время не выбрано!")
                    return
                }
                print("Игрок - 1 передал ход")
                timerManager.pauseTimer()
                timerManager.startTimer(for: .two)
            }
            .padding()
            .background(Color.blue.opacity(0.3))
            .cornerRadius(8)

            // Кнопка для передачи хода от Игрока 2 к Игроку 1
            Button("Игрок - 2 передал ход") {
                guard totalSelectedTime() > 0 else {
                    print("Время не выбрано!")
                    return
                }
                print("Игрок - 2 передал ход")
                timerManager.pauseTimer()
                timerManager.startTimer(for: .one)
            }
            .padding()
            .background(Color.green.opacity(0.3))
            .cornerRadius(8)

            // Отображение оставшегося времени для активного игрока
            if timerManager.activePlayer != .none {
                Text("Ходит игрок: \(timerManager.activePlayer == .one ? "Игрок 1" : "Игрок 2"), осталось времени: \(timerManager.activePlayer == .one ? timerManager.playerOneTimeRemaining : timerManager.playerTwoTimeRemaining) сек")
                    .font(.headline)
                    .padding()
            }
        }
        .padding()
        .onChange(of: selectedMinutes) { _ in
            updateInitialTime()
        }
        .onChange(of: selectedSeconds) { _ in
            updateInitialTime()
        }
    }

    private func updateInitialTime() {
        let totalTime = totalSelectedTime()
        timerManager.resetTimers(initialTime: totalTime)
    }

    private func totalSelectedTime() -> Int {
        return selectedMinutes * 60 + selectedSeconds
    }
}

#Preview {
    GameView()
}




