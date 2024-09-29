//
//  RulesView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct RulesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationBarBackButtonHidden(true) // Скрываем стандартную кнопку "Назад"
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // Возврат к предыдущему экрану
                      presentationMode.wrappedValue.dismiss()
                }) {
                    // Кастомная кнопка
                    HStack {
                        Image(systemName: "house")
                        Text("Назад")
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    // Возврат к предыдущему экрану
                      presentationMode.wrappedValue.dismiss()
                }) {
                    // Кастомная кнопка
                    HStack {
                        Image(systemName: "house")
                        Text("Назад")
                    }
                }
            }
        }
    }
}

#Preview {
    RulesView()
}
