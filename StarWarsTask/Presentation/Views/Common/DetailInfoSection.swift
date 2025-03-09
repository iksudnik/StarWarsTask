//
//  DetailInfoSection.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import SwiftUI

struct DetailInfoSection<Content: View>: View {
    let title: String
	let content: () -> Content

	init(
		title: String,
		@ViewBuilder content: @escaping () -> Content
	) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			Text(title)
				.font(.title2)
				.foregroundStyle(AppColors.accent)
			Grid(alignment: .leading, horizontalSpacing: 8, verticalSpacing: 8) {
				content()
			}
		}
    }
}

struct DetailInfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
		GridRow(alignment: .top) {
            Text(label + ":")
				.foregroundColor(AppColors.primaryText)
                .fontWeight(.medium)
                .frame(width: 100, alignment: .leading)
            
            Text(value)
				.foregroundColor(AppColors.secondaryText)
        }
    }
}


//MARK: - Preview
#Preview {
	VStack(alignment: .leading) {
		DetailInfoSection(title: "Basic Info") {
			DetailInfoRow(label: "Name", value: "Luke Skywalker, Luke Skywalker, Luke Skywalker")
			DetailInfoRow(label: "Gender", value: "Male")
		}

		DetailInfoSection(title: "Physical Traits") {
			DetailInfoRow(label: "Height", value: "172 cm")
			DetailInfoRow(label: "Weight", value: "77 kg")
		}
	}
	.preferredColorScheme(.dark)
}
