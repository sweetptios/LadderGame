//
//  ContentView.swift
//  LadderGameSwiftUI
//
//  Created by mine on 2019/11/14.
//  Copyright © 2019 sweetpt365. All rights reserved.
//

import SwiftUI
import LadderGameLibrary

struct LadderGameView: View {
    
    @EnvironmentObject var viewModel: LadderGameViewModel
    @State var height = ""
    @State var names = ""

    var body: some View {
        VStack(alignment: .center) {
            TextField("사다리높이(ex. 10)", text: $height)
            TextField("참여자이름나열(ex. a,b,c,d,e)", text: $names)
            Button(action: {
                self.viewModel.didTapStartGame.send((self.height, self.names))
            }) {
                Text("게임시작")
            }
            LadderView(ladders: $viewModel.ladders)
                .border(Color.gray)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let interactor = LadderMakerInteractor()
        let viewModel = LadderGameViewModel(inputBoundary: interactor)
        interactor.set(viewModel)
        return LadderGameView().environmentObject(viewModel)
    }
}
