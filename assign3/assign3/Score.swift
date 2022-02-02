//
//  Score.swift
//  assign3
//
//  Created by Jason Wang on 10/18/21.
//

import Foundation

struct Score : Hashable, Comparable {
    var score: Int
    var time: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(time)
    }
    
    init(score: Int, time: Date) {
        self.score = score
        self.time = time
    }
    
    static func < (lhs: Score, rhs: Score) -> Bool {
        if lhs.score != rhs.score {
            return lhs.score > rhs.score
        } else {
            return lhs.time > rhs.time
        }
    }
}
