//
//  SecondView.swift
//  TestMVVMCombine
//
//  Created by Andrii Moisol on 14.05.2021.
//

import SwiftUI

struct SecondView<VM>: View where VM: SecondViewModelType {
	@ObservedObject var viewModel: VM
	
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
