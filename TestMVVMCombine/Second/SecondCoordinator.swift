//
//  SecondCoordinator.swift
//  TestMVVMCombine
//
//  Created by Andrii Moisol on 14.05.2021.
//

import UIKit
import Combine
import SwiftUI

class SecondCoordinator: Coordinator<String> {
	private let router: Router!
	
	init(router: Router) {
		self.router = router
	}
	
	override func start() -> AnyPublisher<String, Never> {
		let viewModel = SecondViewModel()
		let viewController = UIHostingController(rootView: SecondView(viewModel: viewModel))
		presentedViewController = viewController
		
		router.push(viewController, isAnimated: true) { [weak viewModel] in
			viewModel?.close()
		}
		
		return viewModel.coordinatorInput.close
			.handleEvents(receiveOutput: { [weak router] _ in
				router?.pop(true)
			})
			.eraseToAnyPublisher()
	}
}
