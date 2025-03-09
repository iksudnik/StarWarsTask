//
//  LoadingStateView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import SwiftUI

enum LoadingState<T> {
	case loading
	case loaded(T)
	case empty
	case error(Error)
}

struct LoadingStateView<Content: View, Item>: View {
    let state: LoadingState<Item>
    let retryAction: () -> Void
    let content: (Item) -> Content
    
    var body: some View {
		switch state {
			case .loading:
				CentralLoaderView()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
        
        case .empty:
            ContentUnavailableView {
                Label(Localized.UI.noDataAvailable, systemImage: "tray")
            } description: {
                Text(Localized.UI.dataWillAppearHere)
            } actions: {
                Button(Localized.UI.refresh) {
                    retryAction()
                }
            }
        
        case .error(let error):
            ContentUnavailableView {
                Label(Localized.UI.error, systemImage: "exclamationmark.triangle")
            } description: {
				Text(error.localizedDescription)
            } actions: {
                Button(Localized.UI.tryAgain) {
                    retryAction()
                }
            }
        
        case .loaded(let item):
            content(item)
        }
    }
}

//MARK: - Preview
#Preview("Empty") {
	LoadingStateView<EmptyView, Film>(
		state: .empty,
		retryAction: { },
		content: { _ in EmptyView() })
		.preferredColorScheme(.dark)
}

#Preview("Loading") {
	LoadingStateView<EmptyView, Film>(
		state: .loading,
		retryAction: { },
		content: { _ in EmptyView() })
		.preferredColorScheme(.dark)
}

#Preview("Loaded") {
	LoadingStateView<Text, Film>(
		state: .loaded(Film.previewList[0]),
		retryAction: { },
		content: { _ in
		Text("Loaded")
			.foregroundColor(.green)
	})
	.preferredColorScheme(.dark)
}

#Preview("Error") {
	LoadingStateView<EmptyView, Film>(
		state: .error(NSError(domain: "", code: 0, userInfo: nil)),
		retryAction: { },
		content: { _ in EmptyView() })
	.preferredColorScheme(.dark)
}
