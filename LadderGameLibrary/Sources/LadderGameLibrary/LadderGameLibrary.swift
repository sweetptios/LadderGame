//
//  LadderGame.swift
//  LadderGameiOS
//
//  Created by mine on 2019/11/14.
//  Copyright © 2019 sweetpt365. All rights reserved.
//

import Foundation

//MARK: - entity layer

public struct LadderPlayer {
    private var name = ""
    
    public init(name: String) {
        self.name = name
    }
}

public struct LadderMatrix {
    private var height: Int
    private var width: Int { players.count-1 }
    private var players = [LadderPlayer]()
    private var matrix: [[Bool]] = [[]]
    
    public init(height: Int, players: [LadderPlayer]) {
        self.players = players
        self.height = height
        matrix = build(width: width, height: height)
    }
    
    public func size() -> (width: Int, height: Int) {
        return (width, height)
    }
    
    public subscript(row: Int, column: Int ) -> Bool {
        matrix[row][column]
    }
    
    private func build(width: Int, height: Int) -> [[Bool]] {
        var ladder = [[Bool]]()
        for _ in 0..<height {
            var one = [Bool]()
            for _ in 0..<width {
                one.append(Bool.random())
            }
            
            ladder.append(one)
        }
        return ladder
    }
}


//MARK: - usecase layer

public protocol LadderMakerOutputBoundary: AnyObject {
    func displayLadderMatrix(_ data: LadderMatrix)
}
public protocol LadderMakerInputBoundary {
    func buildLadderMatrix(height: Int, players: [LadderPlayer])
    func set(_ outputBoundary: LadderMakerOutputBoundary)
}
public class LadderMakerInteractor: LadderMakerInputBoundary {
    private weak var outputBoundary: LadderMakerOutputBoundary!
    
    public init() {}
    
    public func set(_ outputBoundary: LadderMakerOutputBoundary) {
        self.outputBoundary = outputBoundary
    }
    
    public func buildLadderMatrix(height: Int, players: [LadderPlayer]) {
        let data = LadderMatrix(height: height, players: players)
        outputBoundary?.displayLadderMatrix(data)
    }
}
