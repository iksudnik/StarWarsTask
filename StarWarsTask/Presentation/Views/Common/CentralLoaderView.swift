//
//  CentralLoaderView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import SwiftUI

struct CentralLoaderView: View {
	var body: some View {
		HStack {
			Spacer()
			ProgressView()
			Spacer()
		}
		.padding()
	}
}

//MARK: - Preview
#Preview {
	CentralLoaderView()
		.preferredColorScheme(.dark)
}
