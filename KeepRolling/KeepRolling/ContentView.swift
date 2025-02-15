//
//  ContentView.swift
//  KeepRolling
//
//  Created by 유정주 on 2/13/25.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack(spacing: 50) {
            SpinRectangle()
                .foregroundStyle(Color(.primary))
                
            SpinRectangle(cornerRadiusPercent: 0.1)
                .foregroundStyle(Color(.primaryDark))
            
            SpinRectangle(cornerRadiusPercent: 0.3)
                .foregroundStyle(Color(.secondary))
            
            SpinRectangle(cornerRadiusPercent: 0.5)
                .foregroundStyle(Color(.text))
        }
    }
}

private struct SpinRectangle: View {
    
    var body: some View {
        Rectangle()
            .frame(width: length, height: length)
            .cornerRadius(cornerRadius)
            .rotationEffect(.degrees(isRotating ? 360 : 0))
            .animation(
                .linear(duration: animationSpeed)
                .repeatForever(autoreverses: false),
                value: isRotating
            )
            .onAppear {
                isRotating = true
            }
    }
    
    // MARK: - Source of truth
    
    @State private var isRotating = false
    @State private var cornerRadiusPercent: CGFloat
    
    // MARK: - Attribute
    
    private let length: CGFloat = 100
    private let minSpeed: Double = 1.0
    private let maxSpeed: Double = 5.0
    
    var cornerRadius: CGFloat {
        length * cornerRadiusPercent
    }
    var animationSpeed: Double {
        maxSpeed - (maxSpeed - minSpeed) * (cornerRadius / (length / 2))
    }
    
    // MARK: - Initializer
    
    init(cornerRadiusPercent: CGFloat = 0) {
        self.cornerRadiusPercent = cornerRadiusPercent
    }
}

#Preview {
    ContentView()
}
