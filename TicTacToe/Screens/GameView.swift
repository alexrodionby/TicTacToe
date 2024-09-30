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
            // Отображение оставшегося времени для игроков
            Text("Player One Time: \(formatTime(timerManager.playerOneTimeRemaining))")
            Text("Player Two Time: \(formatTime(timerManager.playerTwoTimeRemaining))")

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

            Button("Игрок - 1 передал ход") {
                guard totalSelectedTime() > 0 else { // Проверяем, что время выбрано
                    print("Время не выбрано!")
                    return
                }
                print("Игрок - 1 передал ход")
                timerManager.pauseTimer() // Останавливаем таймер для игрока 1
                timerManager.startTimer(for: .two) // Запускаем таймер для игрока 2
            }
            .padding()
            .background(Color.blue.opacity(0.3))
            .cornerRadius(8)

            // Кнопка для передачи хода от Игрока 2 к Игроку 1
            Button("Игрок - 2 передал ход") {
                guard totalSelectedTime() > 0 else { // Проверяем, что время выбрано
                    print("Время не выбрано!")
                    return
                }
                print("Игрок - 2 передал ход")
                timerManager.pauseTimer() // Останавливаем таймер для игрока 2
                timerManager.startTimer(for: .one) // Запускаем таймер для игрока 1
            }
            .padding()
            .background(Color.green.opacity(0.3))
            .cornerRadius(8)

            // Отображение оставшегося времени для активного игрока
            if timerManager.activePlayer != .none {
                Text("Ходит игрок: \(timerManager.activePlayer == .one ? "Игрок 1" : "Игрок 2"), осталось времени: \(formatTime(timerManager.activePlayer == .one ? timerManager.playerOneTimeRemaining : timerManager.playerTwoTimeRemaining))")
                    .font(.headline)
                    .padding()
            }
        }
        .padding()
        // Обновление начального времени при изменении выбранных минут или секунд
        .onChange(of: selectedMinutes) { _ in
            updateInitialTime()
        }
        .onChange(of: selectedSeconds) { _ in
            updateInitialTime()
        }
    }

    /// Обновляет начальное время для обоих игроков
    private func updateInitialTime() {
        let totalTime = totalSelectedTime()
        timerManager.resetTimers(initialTime: totalTime) // Сбрасываем таймеры с новым значением
    }

    /// Вычисляет общее выбранное время в секундах
    private func totalSelectedTime() -> Int {
        return selectedMinutes * 60 + selectedSeconds
    }

    /// Форматирует время из секунд в формат "минуты:секунды"
    /// - Parameter time: Время в секундах
    /// - Returns: Строка в формате "минуты:секунды"
    private func formatTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    GameView()
}





