//
//  DashboardView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var container: DependencyContainer
    @EnvironmentObject var router: Router
    
    private let columns = [
		GridItem(
			.adaptive(minimum: 150, maximum: 180),
			spacing: 20
		)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Title banner
                VStack {
                    Text(Localized.Titles.starWarsHeader)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(AppColors.accent)
                        .padding(.top)
                    
                    Text(Localized.Titles.byJakala)
                        .font(.headline)
                        .foregroundColor(AppColors.accent.opacity(0.8))
                        .padding(.bottom)
                }
                .frame(maxWidth: .infinity)
                
                LazyVGrid(columns: columns, spacing: 20) {
					ForEach(ResourceType.allCases, id: \.self) { category in
                        Button {
                            router.navigateToList(for: category)
                        } label: {
                            CategoryGridItem(resourceType: category)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(
            AppColors.background
                .ignoresSafeArea()
        )
    }
}


// MARK: - Preview
#Preview {
    DashboardView()
        .environmentObject(DependencyContainer.preview)
        .environmentObject(Router())
        .preferredColorScheme(.dark)
} 
