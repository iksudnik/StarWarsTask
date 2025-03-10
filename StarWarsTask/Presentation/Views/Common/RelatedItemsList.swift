//
//  RelatedItemsList.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Core
import SwiftUI

struct RelatedItemsList<T: Identifiable>: View {
    let items: [T]
    let rowContent: (T) -> AnyView
    let onItemSelected: (T) -> Void
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
					Button {
                        onItemSelected(item)
                    } label: {
                        rowContent(item)
                    }
                    .buttonStyle(PlainButtonStyle())
				}
			}
		}
    }
}

// MARK: - Convenience extensions
extension RelatedItemsList {
    init<RowView: View>(
        items: [T], 
        rowContent: @escaping (T) -> RowView, 
        onItemSelected: @escaping (T) -> Void,
        emptyText: String
    ) {
        self.items = items
        self.rowContent = { AnyView(rowContent($0)) }
        self.onItemSelected = onItemSelected
        self.emptyText = emptyText
    }
}
