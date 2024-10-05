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
    
    @State var selected: String = "Classical"
    @State var isOn: Bool = false
    
    var body: some View {
        
        if !isOn {
            HStack {
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                Text(selected)
                    .font(.headline).opacity(0.5)
            }
            .onTapGesture {
                isOn = true
            }
            .modifier(MainModifier())
        }
        
       if isOn {
            VStack {
                HStack {
                    Text(title)
                        .font(.headline)
                        .padding()
                    
                    Spacer()
                }
                Color.customPurple
                    .frame(width:270 ,height: 1)
                
                ScrollView {
                    ForEach(options, id: \.self) { option in
                        HStack {
                            Text(option)
                                .padding()
                            
                            Spacer()
                        }
                        .background(selected == option ? .customPurple : .customLightBlue)
                        .onTapGesture {
                            selected = option
                            
                            isOn = false
                        }
                    }
                }
                .frame(maxHeight: 170)
            }
            .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.customLightBlue))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .frame(maxWidth: 270)
        }
            /*    if isOn {
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
             .background(selected == option ? .customPurple : .customLightBlue)
             .onTapGesture {
             selected = option
             }
             }
             }
             .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
             .fill(Color.customLightBlue))
             .frame(maxWidth: 270
             } */
        }
    }

//#Preview {
//    SettingsView()
//        .environment(\.locale, .init(identifier: "EN"))
//        .preferredColorScheme(.light)
//        .environment(GameViewModel())
//        .environment(AppRouter())
//}
