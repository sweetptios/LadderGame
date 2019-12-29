//
//  LadderView.swift
//  LadderGameSwiftUI
//
//  Created by mine on 2019/11/14.
//  Copyright © 2019 sweetpt365. All rights reserved.
//

import SwiftUI
import LadderGameLibrary

struct LadderView: View {
    //tip
    @Binding var ladders: LadderMatrix
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0.0) {
                ForEach(0..<self.ladders.size().height, id: \.self){ i in
                    HStack(spacing: 1.0) {
                        ForEach(0..<self.ladders.size().width, id:\.self) { j in
                            LadderRoom(value: self.ladders[i, j])
                            .stroke()
                        }
                    }
                }
            }
        }
       
    }
}

struct LadderView_Previews: PreviewProvider {
    
    @State static var ladders = LadderMatrix(height: 5, players: ["a","b","c","d","e"].map{ LadderPlayer(name: $0)})
    static var previews: some View {
        LadderView(ladders: $ladders)
    }
}

