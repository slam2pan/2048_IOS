//
//  BoardView.swift
//  assign3
//
//  Created by Jason Wang on 10/15/21.
//

import SwiftUI

struct BoardView: View {
    @EnvironmentObject var game : Twos
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(0..<game.board.count, id: \.self) { row in
                    HStack {
                        ForEach(0..<game.board[row].count, id: \.self) { _ in
                            TileView(tile: nil)
                        }
                    }
                }
            }
            VStack {
                ForEach(0..<game.board.count, id: \.self) { row in
                    HStack {
                        ForEach(0..<game.board[row].count, id: \.self) { col in
                                TileView(tile: game.board[row][col]!)
                        }
                    }
                }
            }
        }
    }
}
