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
	private weak var presentingViewController: UIViewController!
	
	init(presentingViewController: UIViewController) {
		self.presentingViewController = presentingViewController
	}
	
	override func start() -> AnyPublisher<String, Never> {
		let viewModel = SecondViewModel()
		let viewController = UIHostingController(rootView: SecondView(viewModel: viewModel))
		presentedViewController = viewController
		
		presentingViewController?.navigationController?.pushViewController(viewController, animated: true)
		
		return viewModel.coordinatorInput.close
			.handleEvents(receiveOutput: { [weak viewController] _ in
				viewController?.navigationController?.popViewController(animated: true)
			})
			.eraseToAnyPublisher()
	}
}
