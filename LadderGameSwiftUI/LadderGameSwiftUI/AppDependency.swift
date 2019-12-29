//
//  AppDependency.swift
//  LadderGameSwiftUI
//
//  Created by mine on 2019/12/29.
//  Copyright © 2019 sweetpt365. All rights reserved.
//

import UIKit
import LadderGameLibrary
import SwiftUI

struct AppDependency {
    let window: UIWindow
}

extension AppDependency {
    
    static func resolve(with windowScene: UIWindowScene) -> AppDependency {
        
        let window = UIWindow(windowScene: windowScene)
        let contentView = LadderGameView()
        let interactor = LadderMakerInteractor()
        let ladderGameViewModel = LadderGameViewModel(inputBoundary: interactor)
        interactor.set(ladderGameViewModel)
        window.rootViewController = UIHostingController(rootView: contentView.environmentObject(ladderGameViewModel))
        
        return AppDependency(window: window)
    }
    
    
}
