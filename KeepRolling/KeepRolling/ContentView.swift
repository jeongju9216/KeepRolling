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
            .rotationEffect(.degrees(angle))
            .animation(
                .linear(duration: animationDuration),
                value: angle
            )
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
    }
    
    // MARK: - Source of truth
    
    @State private var cornerRadiusPercent: CGFloat
    @State private var angle: Double = 0 // 회전 각도
    @State private var timer: Timer?

    // MARK: - Attribute
    
    private let length: CGFloat = 100
    private let minDuration: Double = 0.1
    private let maxDuration: Double = 1.0
    
    var cornerRadius: CGFloat {
        length * cornerRadiusPercent
    }
    var animationDuration: Double {
        maxDuration - (maxDuration - minDuration) * (cornerRadius / (length / 2))
    }
    
    // MARK: - Initializer
    
    init(cornerRadiusPercent: CGFloat = 0) {
        self.cornerRadiusPercent = cornerRadiusPercent
    }
    
    // MARK: - Timer
    
    private func startTimer() {
        stopTimer() // 기존 타이머 정리
        angle += 90

        let totalDelay = animationDuration + (1 / (cornerRadius + 1))
        timer = Timer.scheduledTimer(withTimeInterval: totalDelay, repeats: false) { _ in
            startTimer()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    ContentView()
}
