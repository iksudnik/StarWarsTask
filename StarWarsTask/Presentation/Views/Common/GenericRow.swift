//
//  GenericRow.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Core
import SwiftUI

struct GenericRow: View {
    let title: String
    
    let leftLabel: String
    let leftValue: String
    
    let rightLabel: String
    let rightValue: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
				.foregroundColor(AppColors.primaryText)

            HStack {
                Text("\(leftLabel): \(leftValue)")
                Spacer()
                Text("\(rightLabel): \(rightValue)")
            }
            .font(.subheadline)
            .foregroundColor(AppColors.secondaryText)
        }
        .padding(.vertical, 4)
    }
}


// MARK: - Preview
#Preview {
	GenericRow(
		title: "Luke Skywalker",
		leftLabel: "Gender",
		leftValue: "Male",
		rightLabel: "Birth Year",
		rightValue: "19BBY"
	)
	.preferredColorScheme(.dark)
}
