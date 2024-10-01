//
//  Picker.swift
//  TicTacToe
//
//  Created by Никита Мартьянов on 30.09.24.
//

import SwiftUI

struct CustomPicker: View {
    var title: String = "Duration"
    var options: [String] = ["Classical", "Instrumentals", "Nature"]
    
    @State var selected: String = ""
    @Binding var isOn: Bool
    
    var body: some View {
        
        if isOn {
            VStack {
                HStack {
                    Text(title)
                        .font(.headline)
                        .padding()
                    
                    Spacer()
                }
                Divider()
                    .frame(height: 1)
                    .background(Color.customPurple)
                
                ForEach(options, id: \.self) { option in
                    HStack {
                        Text(option)
                            .padding()
                        
                        Spacer()
                    }
                    .background(selected == option ? .customPurple : .customLightBlue) // Окрашиваем всю строку
                    .onTapGesture {
                        selected = option
                    }
                }
            }
            .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.customLightBlue))
            .frame(maxWidth: 270)
        }
    }
}
