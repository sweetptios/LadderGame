//
//  LadderRoom.swift
//  LadderGameSwiftUI
//
//  Created by mine on 2019/11/14.
//  Copyright © 2019 sweetpt365. All rights reserved.
//

import SwiftUI

struct LadderRoom: Shape {
    var value: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let from = rect.origin
        let room = rect.size
        path.move(to: from)
        path.addLine(to: CGPoint(x:from.x, y: from.y + room.height))
        if value {
            let mid: CGFloat = room.height / 2.0
            path.move(to: CGPoint(x: from.x, y: from.y + mid))
            path.addLine(to: CGPoint(x:from.x + room.width, y: from.y + mid))
        }
        return path
    }
}


struct LadderRoom_Previews: PreviewProvider {
    static var previews: some View {
        LadderRoom(value:true)
        .stroke()
    }
}


