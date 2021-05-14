//
//  SecondView.swift
//  TestMVVMCombine
//
//  Created by Andrii Moisol on 14.05.2021.
//

import SwiftUI

struct SecondView: View {
	@ObservedObject var viewModel: SecondViewModel
	
	var body: some View {
		VStack {
			TextField("Text", text: $viewModel.text)
			
			Button(action: {
				viewModel.close()
			}, label: {
				Text("Back")
			})
		}
		.navigationBarHidden(true)
	}
}
