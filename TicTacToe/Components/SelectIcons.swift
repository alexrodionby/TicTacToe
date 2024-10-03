//
//  Icons.swift
//  TicTacToe
//
//  Created by Никита Мартьянов on 30.09.24.
//

import SwiftUI

struct SelectIcons: View {
    @State private var selectedIconSet: Int? = 0
    
    let iconSets = [
        ["xSkin4", "oSkin4"],
        ["xSkin5", "oSkin5"],
        ["xSkin6", "oSkin6"],
        ["xSkin3", "oSkin3"],
        ["xSkin2", "oSkin2"],
        ["xSkin1", "oSkin1"]
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(0..<iconSets.count, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white)
                            .shadow(color: .gray.opacity(0.3), radius: 15, x: 4, y: 4)
                            .frame(width: 150,height: 150)
                        
                        VStack {
                            Spacer()
                            
                            HStack {
                                ForEach(iconSets[index], id: \.self) { icon in
                                    Image(icon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                }
                            }
                            Spacer()
                            
                            Button(action: {
                                selectedIconSet = index
                                
                            }) {
                                Text(selectedIconSet == index ? "Picked" : "Choose")
                                    .padding(.vertical,10)
                                    .padding(.horizontal,30)
                                    .foregroundColor(selectedIconSet == index ? .customWhite : .customBlack)
                                    .font(.system(size: 16, weight: .bold, design: .default))
                                
                                    .background(selectedIconSet == index ? .customBlue : .customLightBlue)
                                    .cornerRadius(30)
                                    .foregroundColor(.black)
                            }
                            .padding([.leading, .trailing, .bottom])
                        }
                    }
                }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    SelectIcons()
}
