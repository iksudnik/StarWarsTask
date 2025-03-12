//
//  OpeningCrawlView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 11.03.2025.
//

import SwiftUI
import Core

/// Just for fun. Quickly tried to reproduce opening crawl animation
struct OpeningCrawlView: View {
    let text: String
    
    @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { geometry in
			let frameSize = geometry.size
            ZStack {
                // Star background
                StarsBackgroundView()
                
                // Text container
				crawlingTextContainer(screenSize: frameSize)
					.starWarsCrawlEffect(isAnimating: isAnimating, screenSize: frameSize)

				topGradient(screenHeight: frameSize.height)
            }
            .allowsHitTesting(false)
            .onAppear {
				isAnimating = true
            }
            .onDisappear {
                isAnimating = false
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - Views
private extension OpeningCrawlView {
	func crawlingText(screenWidth: CGFloat) -> some View {
		Text(text)
			.font(.system(size: 38, weight: .black))
			.foregroundColor(AppColors.accent)
			.multilineTextAlignment(.center)
			.lineSpacing(16)
			.frame(width: screenWidth * 1.2)
			.fixedSize(horizontal: false, vertical: true)
	}

	func crawlingTextContainer(screenSize: CGSize) -> some View {
        VStack {
            Spacer()
			crawlingText(screenWidth: screenSize.width)
        }
    }
    
    func topGradient(screenHeight: CGFloat) -> some View {
        VStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
                startPoint: .top,
                endPoint: .bottom
            )
			.frame(height: screenHeight * 0.6)

            Spacer()
        }
    }
}

// MARK: - View Modifiers
private extension View {
	func starWarsCrawlEffect(isAnimating: Bool, screenSize: CGSize) -> some View {
        self
            .frame(width: screenSize.width)
			.scaleEffect(isAnimating ? 0.2 : 1, anchor: .top)
            .rotation3DEffect(
                .degrees(60),
                axis: (x: 1, y: 0, z: 0),
                anchor: .top,
				perspective: 0.9
            )
			.offset(y: isAnimating ? -screenSize.height :  screenSize.height)
            .animation(
				.linear(duration: 30).delay(0.2),
                value: isAnimating
            )
    }
}


// MARK: - Preview
#Preview {
    OpeningCrawlView(
        text: "It is a period of civil war. Rebel spaceships, striking from a hidden base, have won their first victory against the evil Galactic Empire. During the battle, Rebel spies managed to steal secret plans to the Empire's ultimate weapon, the DEATH STAR, an armored space station with enough power to destroy an entire planet."
    )
    .background(Color.black)
    .preferredColorScheme(.dark)
}
