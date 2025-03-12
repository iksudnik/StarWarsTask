//
//  StarsBackgroundView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 12.03.2025.
//

import SwiftUI

/// A view that displays an animated star field background
struct StarsBackgroundView: View {

	// Caching stars positions
    @State private var starPositions: [(position: CGPoint, size: CGFloat, opacity: Double)] = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                
                ForEach(0..<starPositions.count, id: \.self) { index in
                    let star = starPositions[index]
                    Circle()
                        .fill(Color.white.opacity(star.opacity))
                        .frame(width: star.size)
                        .position(star.position)
                        .blendMode(.screen)
                }
            }
            .onAppear {
                if starPositions.isEmpty {
                    generateStarPositions(for: geometry)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    private func generateStarPositions(for geometry: GeometryProxy) {
        starPositions = (0..<150).map { _ in
            (
                position: CGPoint(
                    x: CGFloat.random(in: 0...geometry.size.width),
                    y: CGFloat.random(in: 0...geometry.size.height)
                ),
                size: CGFloat.random(in: 1...3.5),
                opacity: Double.random(in: 0.5...1.0)
            )
        }
    }
}

// MARK: - Preview
#Preview {
	StarsBackgroundView()
		.preferredColorScheme(.dark)
}
