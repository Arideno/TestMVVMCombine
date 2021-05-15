//
//  HomeView.swift
//  TestMVVMCombine
//
//  Created by Andrii Moisol on 14.05.2021.
//

import SwiftUI

struct HomeView<VM>: View where VM: HomeViewModelType {
	@ObservedObject var viewModel: VM
	
	var body: some View {
		VStack {
			Button(action: {
				viewModel.goToSecondView()
			}, label: {
				Text("Second View")
			})
			
			Text(viewModel.text)
		}
		.navigationBarHidden(true)
	}
}

struct HomeView_Preview: PreviewProvider {
	static var previews: some View {
		HomeView(viewModel: HomeViewModel())
	}
}
