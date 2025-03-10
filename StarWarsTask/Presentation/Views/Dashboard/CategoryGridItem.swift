//
//  CategoryGridItem.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Core
import SwiftUI

struct CategoryGridItem: View {
    let resourceType: ResourceType
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
					.fill(AppColors.secondaryBackground)
                    .aspectRatio(1, contentMode: .fit)
                    .shadow(radius: 3)
                
                Image(systemName: resourceType.iconName)
                    .font(.system(size: 40))
					.foregroundColor(AppColors.accent)
            }
            
            Text(resourceType.title)
                .font(.headline)
				.foregroundColor(AppColors.primaryText)
                .padding(.top, 4)
        }
    }
}

// MARK: - ResourceType
private extension ResourceType {
	var iconName: String {
		switch self {
			case .person: return "person.3"
			case .planet: return "globe"
			case .starship: return "airplane"
			case .vehicle: return "car"
			case .species: return "person.and.arrow.left.and.arrow.right"
			case .film: return "film"
		}
	}
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        CategoryGridItem(resourceType: .person)
            .frame(width: 150)
			.preferredColorScheme(.dark)
    }
} 
