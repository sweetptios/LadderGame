//
//  LadderGame.swift
//  LadderGameSwiftUI
//
//  Created by mine on 2019/11/14.
//  Copyright © 2019 sweetpt365. All rights reserved.
//

/**
 * @brief Clean Architecture + MVVM
 * @details
 * @param
 * @return
 */

import Foundation
import LadderGameLibrary
import Combine

//MARK: - Interface Adapter Layer

final class LadderGameViewModel: LadderMakerOutputBoundary, ObservableObject {
    @Published var ladders: LadderMatrix
    let didTapStartGame = PassthroughSubject<(String, String), Never>()
    private var cancellable: Cancellable?
    private var inputBoundary: LadderMakerInputBoundary!
    
    init(inputBoundary: LadderMakerInputBoundary) {
        self.inputBoundary = inputBoundary
        ladders = LadderMatrix(height: 0, players: [])
        cancellable = didTapStartGame.sink {
            let height = Int($0.0) ?? 0
            let list = $0.1.split(separator: ",").map{String($0)}
            let players = list.map({LadderPlayer(name:$0)})
            self.inputBoundary.buildLadderMatrix(height: height, players: players)
        }
    }
    
    func displayLadderMatrix(_ data: LadderMatrix) {
        ladders = data
    }
    
    deinit { print("deinit"); cancellable?.cancel() }
}

