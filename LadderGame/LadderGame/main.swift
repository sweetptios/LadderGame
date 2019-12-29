//
//  main.swift
//  LadderGame
//
//  Created by JK on 2019/11/11.
//  Copyright © 2019 codesquad. All rights reserved.

import Foundation
import LadderGameLibrary

/**
 * @brief 함수형 프로그래밍. LadderGameLibrary의 Entity Layer을 사용
 * @details
 * @param
 * @return
 */


//MARK: - Input

struct ConsoleInput {
    
    static func read() -> (String, String) {
        let height = read(q:"사다리 높이를 입력해주세요.")
        let names = read(q:"참여할 사람 이름을 입력하세요.")
        return (height, names)
    }
    
    private static func read(q: String) -> String {
        print(q)
        let result = readLine() ?? ""
        return result
    }
}


//MARK: - Output

struct ConsoleOutput {
    
    static func display(matrix: LadderMatrix) {
        let displayedData = DisplayedLadderMatrix.build(from: matrix)
        //5
        print(displayedData)
    }
}

struct DisplayedLadderMatrix {

    static func build(from matrix: LadderMatrix) -> String {
        var ladderString = ""
        let size = matrix.size()
        for i in 0 ..< size.height {
            ladderString += "|"
            for j in 0 ..< size.width {
                ladderString += ( matrix[i,j] ? "---|" : "   |" )
            }
            ladderString += "\n"
        }
        return ladderString
    }
}

//MARK: - 입력받은 정보로 Ladder Matrix를 만듬

struct LadderMatrixMaker {
    
    static func create(height: String, names: String) -> LadderMatrix {
        let _height = Int(height) ?? 0
        let players = names.split(separator: ",").map{String($0)}.map({LadderPlayer(name:$0)})
        //3
        let matrix = LadderMatrix(height: _height, players: players)
        
        return matrix
    }
}


//MARK: - Main Component

func ladderGameLoop(_ f: ()->Void ) {
    func loop() { f(); loop() }
    loop()
}

func executeGame(_ input: @escaping ()->(height: String, names: String), _ ladderMatrixMaker: @escaping (String, String) -> LadderMatrix, _ output:
    @escaping (LadderMatrix)->Void) -> (()->Void) {
    return {
        let (height, names) = input()
        output(ladderMatrixMaker(height, names))
    }
}

ladderGameLoop(executeGame(ConsoleInput.read, LadderMatrixMaker.create, ConsoleOutput.display))
