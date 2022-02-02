//
//  TileView.swift
//  assign3
//
//  Created by Jason Wang on 10/15/21.
//

import SwiftUI

struct TileView: View {
    @EnvironmentObject var game : Twos
    var tile : Tile?
    
    init(tile: Tile?) {
        self.tile = tile
    }
    
    private var backColor: some View {
        if (tile == nil) {
            return Text(String("")).bold().frame(width: 60, height: 60).background(Color.gray).cornerRadius(10)
        }
        switch tile!.val {
        case 0: return Text(String("")).bold().frame(width: 60, height: 60).background(Color.gray).cornerRadius(10)
        case 2: return Text(String(tile!.val)).bold().frame(width: 60, height: 60).background(Color(red: 233 / 255, green: 66 / 255, blue: 245 / 255)).cornerRadius(10)
        case 4: return Text(String(tile!.val)).bold().frame(width: 60, height: 60).background(Color.yellow).cornerRadius(10)
        case 8: return Text(String(tile!.val)).bold().frame(width: 60, height: 60).background(Color(red: 114 / 255, green: 237 / 255, blue: 229 / 255)).cornerRadius(10)
        case 16: return Text(String(tile!.val)).bold().frame(width: 60, height: 60).background(Color(red: 237 / 255, green: 180 / 255, blue: 187 / 255)).cornerRadius(10)
        case 32: return Text(String(tile!.val)).bold().frame(width: 60, height: 60).background(Color.blue).cornerRadius(10)
        case 64: return Text(String(tile!.val)).bold().frame(width: 60, height: 60).background(Color(red: 138 / 255, green: 79 / 255, blue: 232 / 255)).cornerRadius(10)
        case 128: return Text(String(tile!.val)).bold().frame(width: 60, height: 60).background(Color(red: 129 / 255, green: 237 / 255, blue: 92 / 255)).cornerRadius(10)
        default: return Text(String(tile!.val)).bold().frame(width: 60, height: 60).background(Color.gray).cornerRadius(10)
        }
    }
    
    var body: some View {
        HStack {
            backColor
        }.animation(.spring())
    }
}
