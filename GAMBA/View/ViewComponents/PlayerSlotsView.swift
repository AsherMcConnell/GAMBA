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
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .rotation(Angle(degrees: Double(rotationArray[index])))
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color(hue: 0.143, saturation: 0.279, brightness: 0.895))
                        .frame(width: shapeSize, height: shapeSize * 1.4)
                        .position(curvePoint(at: CGFloat(Double(index) / 1) / CGFloat(numShapes - 1), in: geometry.size))
                }
            }
        }
    }
    
    func curvePoint(at t: CGFloat, in size: CGSize) -> CGPoint {
        let x = size.width - curveHeight * cos(.pi * t) * 1.2 - curveHeight - 75
        let y = size.height - curveHeight * sin(.pi * t)
        return CGPoint(x: x, y: y)
    }
}
