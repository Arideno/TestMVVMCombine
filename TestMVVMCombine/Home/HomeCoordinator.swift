//
//  HomeCoordinator.swift
//  TestMVVMCombine
//
//  Created by Andrii Moisol on 14.05.2021.
//

import UIKit
import Combine
import SwiftUI

class HomeCoordinator: Coordinator<Void> {
	
	let window: UIWindow
	
	var cancelBag = Set<AnyCancellable>()
	
	init(window: UIWindow) {
		self.window = window
	}
	
	override func start() -> AnyPublisher<Void, Never> {
		let viewModel = HomeViewModel()
		let viewController = UIHostingController(rootView: HomeView(viewModel: viewModel))
		presentedViewController = viewController
		
		window.rootViewController = UINavigationController(rootViewController: viewController)
		window.makeKeyAndVisible()
		
		viewModel.coordinatorInput.goToSecondView
			.flatMap { [weak self, weak viewController] _ -> AnyPublisher<String, Never> in
				guard let self = self, let viewController = viewController else { return Empty(completeImmediately: true).eraseToAnyPublisher() }
				return self.coordinate(to: SecondCoordinator(presentingViewController: viewController))
			}
			.subscribe(viewModel.coordinatorOutput.textReceived)
			.store(in: &cancelBag)
		
		return Empty<Void, Never>(completeImmediately: false)
			.eraseToAnyPublisher()
	}
}
