//
//  AppCoordinator.swift
//  TestMVVMCombine
//
//  Created by Andrii Moisol on 14.05.2021.
//

import UIKit
import Combine

class AppCoordinator: Coordinator<Void> {
	private let window: UIWindow
	
	init(window: UIWindow) {
		self.window = window
	}
	
	override func start() -> AnyPublisher<Void, Never> {
		return self.coordinate(to: HomeCoordinator(window: window))
	}
}
