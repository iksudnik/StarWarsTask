//
//  RelatedItemsList.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import SwiftUI

struct RelatedItemsList<T: Identifiable, RowContent: View, DestinationView: View>: View {
    let items: [T]
    let rowContent: (T) -> RowContent?
    let destinationView: (T) -> DestinationView
    let emptyText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            if items.isEmpty {
                Text(emptyText)
                    .font(.subheadline)
                    .foregroundColor(AppColors.secondaryText)
                    .padding(.horizontal)
			} else {
				ForEach(items) { item in
					NavigationLink(destination: destinationView(item)) {
						if let rowContent = rowContent(item) {
							rowContent
						}
					}
				}
			}
		}
    }
}
