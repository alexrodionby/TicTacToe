//
//  LeaderboardView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 29.09.24.
//

import SwiftUI

struct LeaderboardView: View {
    @Environment(\.presentationMode) var presentationMode
    private var leaderboardIsEpty = false
    
    var body: some View {
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
                // Здесь будет лидер борд
                
                ScrollView {
                    
                    HStack(alignment: .top, spacing: 20) {
                        Circle()
                            .fill(Color.customLightBlue)
                            .frame(width: 69, height: 69)
                            .overlay {
                                Text("1")
                                    .font(.system(size: 20, weight: .regular, design: .default))
                            }
                        
                        Text("Best time 00:20")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 24)
                            .padding(.horizontal, 24)
                            .font(.system(size: 18, weight: .regular, design: .default))
                            .background(Color.customLightBlue)
                            .cornerRadius(30)
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

#Preview {
    LeaderboardView()
}
