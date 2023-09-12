//
//  PlayerSlotsView.swift
//  GAMBA
//
//  Created by Asher McConnell on 9/12/23.
//

import SwiftUI

struct PlayerSlotsView: View {
    var curveHeight: CGFloat = 50
    var numShapes: Int = 5
    var shapeSize: CGFloat = 20
    
    var rotationArray = [110, 140, 0, -140, -110]
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<numShapes) { index in
                RoundedRectangle(cornerRadius: 5)
                    .rotation(Angle(degrees: Double(rotationArray[index])))
                    .fill(Color.blue)
                    .frame(width: shapeSize, height: shapeSize * 1.4)
                    .position(curvePoint(at: CGFloat(Double(index) / 1) / CGFloat(numShapes - 1), in: geometry.size))
            }
        }
    }
    
    func curvePoint(at t: CGFloat, in size: CGSize) -> CGPoint {
        let x = size.width * t
        let y = size.height - curveHeight * sin(.pi * t)
        return CGPoint(x: x, y: y)
    }
}
