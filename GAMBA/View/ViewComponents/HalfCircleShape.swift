//
//  HalfCircleShape.swift
//  GAMBA
//
//  Created by Asher McConnell on 9/12/23.
//

import SwiftUI

struct HalfCircleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Calculate the center and radius of the half circle
        let centerX = rect.width / 2
        let centerY = rect.height
        let radius = rect.width / 2
        
        // Move to the starting point of the half circle
        path.move(to: CGPoint(x: centerX - radius, y: centerY))
        
        // Add the half circle arc
        path.addArc(center: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 0), clockwise: false)
        
        return path
    }
}
