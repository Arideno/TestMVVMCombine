//
//  Coordinator.swift
//  TestMVVMCombine
//
//  Created by Andrii Moisol on 14.05.2021.
//

import UIKit
import Combine

class Coordinator<ResultType> {
	var presentedViewController: UIViewController!
	var childCoordinators = [UUID: Any]()
	let identifier = UUID()
	
	private func store<T>(coordinator: Coordinator<T>) {
		childCoordinators[coordinator.identifier] = coordinator
	}
	
	private func free<T>(coordinator: Coordinator<T>) {
		childCoordinators[coordinator.identifier] = nil
	}
	
	func coordinate<T>(to coordinator: Coordinator<T>) -> AnyPublisher<T, Never> {
		store(coordinator: coordinator)
		return coordinator.start()
			.handleEvents(receiveOutput: { [weak self, weak coordinator] _ in
				guard let coordinator = coordinator else { return }
				self?.free(coordinator: coordinator)
			})
			.eraseToAnyPublisher()
	}
	
	func start() -> AnyPublisher<ResultType, Never> {
		fatalError()
	}
}
