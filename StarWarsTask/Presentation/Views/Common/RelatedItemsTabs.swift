//
//  RelatedItemsTabs.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Core
import SwiftUI

struct RelatedItemsTabs: View {
    @Binding var selectedTab: Int
    let tabs: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        Button(action: {
							withAnimation(.easeInOut(duration: 0.1)) {
                                selectedTab = index
                            }
                        }) {
                            Text(tabs[index])
								.font(.title3)
                                .fontWeight(selectedTab == index ? .bold : .regular)
								.foregroundColor(selectedTab == index ? AppColors.accent : AppColors.secondaryText)
                                .padding(.vertical, 8)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
            Divider()
        }
    }
    
    private func tabWidth(for totalWidth: CGFloat) -> CGFloat {
        return totalWidth / CGFloat(tabs.count)
    }
    
    private func tabOffset(for totalWidth: CGFloat) -> CGFloat {
        return CGFloat(selectedTab) * tabWidth(for: totalWidth)
    }
}

//MARK: - Preview
#Preview {
	RelatedItemsTabs(
		selectedTab: .constant(0),
		tabs: ["Characters", "Planets", "Starships", "Vehicles", "Species"]
	)
	.preferredColorScheme(.dark)
}
