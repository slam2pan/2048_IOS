//
//  Model.swift
//  assign3
//
//  Created by Jason Wang on 10/15/21.
//

import Foundation

class Twos : ObservableObject {
    @Published var board: [[Tile?]]
    @Published var score: Score
    @Published var random: Bool
    @Published var isDone: Bool
    @Published var savedScores : [Score]
    var generator = SeededGenerator(seed: UInt64(Int.random(in:1...1000)))
    
    init() {
        board = Array(repeating: Array(repeating: Tile(v: 0), count: 4), count: 4)
        score = Score(score: 0, time: Date())
        random = true
        isDone = false
        savedScores = [Score(score: 400, time: Date()), Score(score: 300, time: Date())]
    }
    
    
    // high-level functions
    func shiftLeft()                                   // collapse to the left
    {
        board = elimBlanks(input: board)
        for i in 0...board.count - 1 {
            for j in 0...board.count - 2 {
                if board[i][j] != nil && board[i][j+1] != nil {
                    if (board[i][j]!.val == board[i][j + 1]!.val) {
                        board[i][j] = board[i][j + 1]
                        score.score += board[i][j]!.val * 2
                        board[i][j]!.val *= 2
                        board[i][j + 1] = Tile(v: 0)
                    }
                }
            }
        }
        
        board = elimBlanks(input: board)
    
    }
    
    func elimBlanks(input: [[Tile?]]) -> [[Tile?]]
    {
        var newBoard : [[Tile?]] = Array(repeating: Array(repeating: Tile(v: 0), count: input.count), count: input.count)
        
        var row = 0
        var col = 0
        
        for i in 0...board.count - 1 {
            for j in 0...board.count - 1 {
                if (board[i][j] != nil && board[i][j]!.val != 0) {
                    newBoard[row][col] = Tile(v: board[i][j]!.val)
                    col += 1
                }
            }
            col = 0
            row += 1
        }
        
        return newBoard
    }
    
    func rightRotate()                                 // define using only rotate2D
    {
        board = rotate2D(input: board)
    }
    
    func collapse(dir: Direction)                      // collapse in direction "dir" using only
    // shiftLeft() and rightRotate()
    {
        switch dir {
        case Direction.left:
            shiftLeft()
        case Direction.right:
            rightRotate()
            rightRotate()
            shiftLeft()
            rightRotate()
            rightRotate()
        case Direction.up:
            rightRotate()
            rightRotate()
            rightRotate()
            shiftLeft()
            rightRotate()
        case Direction.down:
            rightRotate()
            shiftLeft()
            rightRotate()
            rightRotate()
            rightRotate()
        }
        
        // check if any moves left
        isDone = isGameDone()
    }

    func newgame() {
        if (score.score != 0) {
            saveScore()
        } 
        board = Array(repeating: Array(repeating: Tile(v: 0), count: 4), count: 4)
        score = Score(score: 0, time: Date())
        isDone = false
        
        if (random) {
            generator = SeededGenerator(seed: UInt64(Int.random(in:1...1000)))
        } else {
            generator = SeededGenerator(seed: 14)
        }
        
        spawn()
        spawn()
    }
    
    func spawn() {
        let randomValue = Int.random(in: 0...1, using: &generator)
        let val = randomValue == 0 ? 2 : 4
        
        let tiles = getOpenTiles()
        
        let newRandomNumber = Int.random(in: 0...tiles.count - 1, using: &generator)
        board[tiles[newRandomNumber].0][tiles[newRandomNumber].1] = Tile(v: val)
    }
    
    func getOpenTiles() -> [(Int, Int)] {
        var openTiles: [(Int, Int)] = []
        for i in 0...board.count - 1 {
            for j in 0...board.count - 1 {
                if (board[i][j]!.val == 0) {
                    openTiles.append((i, j))
                }
            }
        }
        
        return openTiles
    }
    
    func isGameDone() -> Bool {
        if getOpenTiles().count != 0 {
            return false
        }
        
        for i in 0...board.count - 2 {
            for j in 0...board.count - 2 {
                if (board[i][j]!.val == board[i + 1][j]!.val || board[i][j]!.val == board[i][j + 1]!.val) {
                    return false
                }
            }
        }
        
        // last col
        for i in 0...board.count - 2 {
            if (board[i][3]!.val == board[i+1][3]!.val) {
                return false
            }
        }
        
        return true
    }
    
    func saveScore() {
        savedScores.append(score)
        savedScores.sort()
    }
}

struct Tile : Equatable {
    var val : Int
    var lastRow = 0, lastCol = 0
    init(v: Int) {
        val = v
    }
    
    static func ==(first: Tile, second: Tile) -> Bool {
        return first.val == second.val
    }
}

    enum Direction {
        case left
        case right
        case up
        case down
    }

    // primitive functions
    public func rotate2DInts(input: [[Int]]) ->[[Int]] // rotate a square 2D Int array clockwise
    {
        return rotate2D(input: input)
    }
    
    public func rotate2D<T>(input: [[T]]) ->[[T]]      // generic version of the above
    {
        let size = input.count - 1
        var rotated = input
        
        for i in 0...size {
            for j in 0...size {
                rotated[i][j] = input[size - j][i]
            }
        }
        
        return rotated
    }

