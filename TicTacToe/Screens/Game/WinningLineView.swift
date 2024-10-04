//
//  WinningLineView.swift
//  TicTacToe
//
//  Created by Alexandr Rodionov on 4.10.24.
//

import SwiftUI

struct WinningLineView: View {
    var winningPattern: Set<Int>
    var step: CGFloat = 10
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                if let start = positionForCell(index: winningPattern.min()!, in: geometry.size),
                   let end = positionForCell(index: winningPattern.max()!, in: geometry.size) {
                    path.move(to: start)
                    path.addLine(to: end)
                }
            }
            .stroke(Color.customBlue, style: StrokeStyle(lineWidth: 12, lineCap: .round))
        }
    }
    
    // Метод для получения позиции центра ячейки по индексу
    private func positionForCell(index: Int, in size: CGSize) -> CGPoint? {
        let row = index / 3
        let column = index % 3
        
        let cellWidth = size.width / 3
        let cellHeight = size.height / 3
        
        var yPosition: CGFloat = 0
        var xPosition: CGFloat = 0
        
        switch column {
        case 0:
            xPosition = (CGFloat(column) * cellWidth) + (cellWidth / 2) + step
        case 1:
            xPosition = (CGFloat(column) * cellWidth) + (cellWidth / 2)
        default:
            xPosition = (CGFloat(column) * cellWidth) + (cellWidth / 2) - step
        }
        
        switch row {
        case 0:
            yPosition = (CGFloat(row) * cellHeight) + (cellHeight / 2) + step
        case 1:
            yPosition = (CGFloat(row) * cellHeight) + (cellHeight / 2)
        default:
            yPosition = (CGFloat(row) * cellHeight) + (cellHeight / 2) - step
        }
        
        return CGPoint(x: xPosition, y: yPosition)
    }
}

#Preview("LightEN") {
    NavigationStack {
        GameView()
            .environment(\.locale, .init(identifier: "EN"))
            .preferredColorScheme(.light)
            .environment(GameViewModel())
            .environment(AppRouter())
    }
}
