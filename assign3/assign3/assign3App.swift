//
//  assign3App.swift
//  assign3
//
//  Created by Jason Wang on 10/15/21.
//

import SwiftUI

@main
struct assign3App: App {
    @StateObject var game = Twos()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(game)
        }
    }
}
