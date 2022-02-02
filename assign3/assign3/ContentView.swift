//
//  ContentView.swift
//  assign3
//
//  Created by Jason Wang on 10/15/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game : Twos
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var startPos : CGPoint = .zero
    @State var isSwipping = true
    
    var body: some View {
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            TabView {
                VStack {
                    HStack {
                        Text("Score: ").font(.system(size: 30))
                        Text(String(game.score.score)).font(.system(size: 30))
                    }
                    
                    BoardView().alert(isPresented: $game.isDone) {
                        Alert(title: Text("No moves left"), message: Text("Your score was: " + String(game.score.score)),
                              dismissButton: .default(Text("New Game")) {
                            game.newgame()
                        })
                    }.gesture(DragGesture()
                        .onChanged {
                        gesture in
                        if self.isSwipping {
                            self.startPos = gesture.location
                            self.isSwipping.toggle()
                        }
                    }.onEnded { gesture in
                        let oldBoard = game.board
                        let xDist = abs(gesture.location.x - self.startPos.x)
                        let yDist = abs(gesture.location.y - self.startPos.y)
                        if self.startPos.y < gesture.location.y && yDist > xDist {
                            // Down
                            game.collapse(dir: Direction.down)
                        }
                        else if self.startPos.y > gesture.location.y && yDist > xDist {
                            // Up
                            game.collapse(dir: Direction.up)
                        }
                        else if self.startPos.x > gesture.location.x && yDist < xDist {
                            // Left
                            game.collapse(dir: Direction.left)
                        }
                        else if self.startPos.x < gesture.location.x && yDist < xDist {
                            // Right
                            game.collapse(dir: Direction.right)
                        }
                        
                        if !game.board.elementsEqual(oldBoard) {
                            game.spawn()
                        }
                        self.isSwipping.toggle()
                    })
                    ButtonView()
                }.tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Board")
                }
                VStack {
                    Text("High Scores")
                    Form {
                        List {
                            ForEach(game.savedScores.indices, id: \.self) { i in
                                HStack {
                                    Text("\(i+1))")
                                    Spacer()
                                    Text(String(game.savedScores[i].score))
                                    Spacer()
                                    VStack {
                                        Text(game.savedScores[i].time, style: .date)
                                        Text(game.savedScores[i].time, style: .time)
                                    }
                                }
                            }
                        }
                    }
                }.tabItem {
                    Image(systemName: "list.dash")
                    Text("Scores")
                }
            }
        } else {
            TabView {
                HStack {
                    VStack {
                        HStack {
                            Text("Score: ").font(.system(size: 30))
                            Text(String(game.score.score)).font(.system(size: 30))
                        }
                        
                        BoardView().alert(isPresented: $game.isDone) {
                            Alert(title: Text("No moves left"), message: Text("Your score was: " + String(game.score.score)),
                                  dismissButton: .default(Text("New Game")) {
                                game.newgame()
                            })
                        }.gesture(DragGesture()
                            .onChanged {
                            gesture in
                            if self.isSwipping {
                                self.startPos = gesture.location
                                self.isSwipping.toggle()
                            }
                        }.onEnded { gesture in
                            let oldBoard = game.board
                            let xDist = abs(gesture.location.x - self.startPos.x)
                            let yDist = abs(gesture.location.y - self.startPos.y)
                            if self.startPos.y < gesture.location.y && yDist > xDist {
                                // Down
                                game.collapse(dir: Direction.down)
                            }
                            else if self.startPos.y > gesture.location.y && yDist > xDist {
                                // Up
                                game.collapse(dir: Direction.up)
                            }
                            else if self.startPos.x > gesture.location.x && yDist < xDist {
                                // Left
                                game.collapse(dir: Direction.left)
                            }
                            else if self.startPos.x < gesture.location.x && yDist < xDist {
                                // Right
                                game.collapse(dir: Direction.right)
                            }
                            
                            if !game.board.elementsEqual(oldBoard) {
                                game.spawn()
                            }
                            self.isSwipping.toggle()
                        })
                    }
                    ButtonView()
                }.tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Board")
                }
                VStack {
                    Text("High Scores")
                    Form {
                        List {
                            ForEach(game.savedScores.indices, id: \.self) { i in
                                HStack {
                                    Text("\(i+1))")
                                    Spacer()
                                    Text(String(game.savedScores[i].score))
                                    Spacer()
                                    VStack {
                                        Text(game.savedScores[i].time, style: .date)
                                        Text(game.savedScores[i].time, style: .time)
                                    }
                                }
                            }
                        }
                    }
                }.tabItem {
                    Image(systemName: "list.dash")
                    Text("Scores")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Twos())
    }
}
