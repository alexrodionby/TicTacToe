//
//  SettingsPickerView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 5.10.24.
//

import SwiftUI

struct SettingsPickerView: View {
    
    var pickerTitle: String = "Duration"
    var backgroundCornerRadius: CGFloat = 30
    var selectedItem: String = ""
    var itemsForSelect: [String] = ["10", "20", "30"]
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 0) {
                Text(pickerTitle)
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .foregroundStyle(.customBlack)
                    .padding(.leading, 20)

                
                Spacer()
                
                Text("pickedTime")
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .foregroundStyle(.customBlack)
                    .padding(.trailing, 20)

                
            }
            .frame(minHeight: 70)
        }
        .background {
            RoundedRectangle(cornerRadius: backgroundCornerRadius, style: .continuous)
                .fill(.customLightBlue)
        }
    }
}


#Preview("LightEN") {
    SettingsPickerView()
        .environment(\.locale, .init(identifier: "EN"))
        .preferredColorScheme(.light)
        .padding()
}
