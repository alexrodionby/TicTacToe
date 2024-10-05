//
//  SettingsPickerView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 5.10.24.
//

import SwiftUI

struct SettingsPickerView: View {
    /// Получаем доступ к модели игры через окружение
    @Environment(GameViewModel.self) private var gameVM
    
    var pickerTitle: String
    var backgroundCornerRadius: CGFloat = 30
    @State private var isExpanded: Bool = false     // Управляет раскрытием списка
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // Верхняя часть с заголовком и выбранным элементом
            Button {
                withAnimation {
                    isExpanded.toggle()  // Раскрываем или скрываем список
                }
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Text(pickerTitle)
                        .font(.system(size: 20, weight: .semibold, design: .default))
                        .foregroundStyle(.customBlack)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Text(pickerTitle == "Duration" ? "\(gameVM.selectedTime) sec" : gameVM.selectedMusic)  // Показываем выбранный элемент
                        .font(.system(size: 20, weight: .regular, design: .default))
                        .foregroundStyle(.customBlack)
                        .padding(.trailing, 20)
                }
                .frame(minHeight: 70)
                .background {
                    RoundedRectangle(cornerRadius: backgroundCornerRadius, style: .continuous)
                        .fill(.customLightBlue)
                }
            }
            
            // Раскрывающийся список вариантов
            if isExpanded {
                VStack(alignment: .center, spacing: 0) {
                    if pickerTitle == "Duration" {
                        ForEach(gameVM.timeVariants, id: \.self) { item in
                            Button {
                                withAnimation {
                                    gameVM.selectedTime = item
                                    isExpanded = false   // Скрываем список после выбора
                                }
                            } label: {
                                VStack {
                                    Divider()
                                    Text("\(item) sec")
                                        .font(.system(size: 20, weight: .regular, design: .default))
                                        .foregroundStyle(.customBlack)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(height: 40)
                                        .padding(.horizontal, 30)
                                }
                            }
                        }
                    } else {
                        ForEach(gameVM.musicVariants, id: \.self) { item in
                            Button {
                                withAnimation {
                                    gameVM.selectedMusic = item
                                    isExpanded = false   // Скрываем список после выбора
                                }
                            } label: {
                                VStack {
                                    Divider()
                                    Text(item)
                                        .font(.system(size: 20, weight: .regular, design: .default))
                                        .foregroundStyle(.customBlack)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(height: 40)
                                        .padding(.horizontal, 30)
                                }
                            }
                        }
                    }
                }
            }
        }
        .background {
            RoundedRectangle(cornerRadius: backgroundCornerRadius, style: .continuous)
                .fill(.customLightBlue)
        }
    }
}

#Preview("LightEN") {
    VStack {
        SettingsPickerView(pickerTitle: "Duration")
            .environment(\.locale, .init(identifier: "EN"))
            .preferredColorScheme(.light)
            .padding()
            .environment(GameViewModel())
            .padding(.bottom, 100)
        SettingsPickerView(pickerTitle: "Select Music")
            .environment(\.locale, .init(identifier: "EN"))
            .preferredColorScheme(.light)
            .padding()
            .environment(GameViewModel())
    }
}
