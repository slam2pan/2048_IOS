//
//  ButtonView.swift
//  assign3
//
//  Created by Jason Wang on 10/15/21.
//

import SwiftUI

struct ButtonView: View {
    @EnvironmentObject var game : Twos
    
    var body: some View {
        VStack {
            Button("Up") {
                let oldBoard = game.board
                game.collapse(dir: Direction.up)
                if !game.board.elementsEqual(oldBoard) {
                    game.spawn()
                }
            }.frame(width: 80, height: 40).overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 3)
            )
            
            HStack {
                Button("Left") {
                    let oldBoard = game.board
                    game.collapse(dir: Direction.left)
                    if !game.board.elementsEqual(oldBoard) {
                        game.spawn()
                    }
                }.frame(width: 80, height: 40).overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue, lineWidth: 3)
                )
                Button("Right") {
                    let oldBoard = game.board
                    game.collapse(dir: Direction.right)
                    if !game.board.elementsEqual(oldBoard) {
                        game.spawn()
                    }
                }.frame(width: 80, height: 40).overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue, lineWidth: 3)
                )
            }
            Button("Down") {
                let oldBoard = game.board
                game.collapse(dir: Direction.down)
                if !game.board.elementsEqual(oldBoard) {
                    game.spawn()
                }
            }.frame(width: 80, height: 40).overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 3)
            )
            
            Button("New Game") {
                game.newgame()
            }.frame(width: 150, height: 40).overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 3)
            ).padding(.bottom)
            
            Picker("", selection: $game.random, content: {
                Text("Random").tag(true)
                Text("Deterministic").tag(false)
            }).pickerStyle(SegmentedPickerStyle()).padding()
        }
    }
}

