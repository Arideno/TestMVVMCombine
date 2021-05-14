//
//  HomeViewModel.swift
//  TestMVVMCombine
//
//  Created by Andrii Moisol on 14.05.2021.
//

import Combine

class HomeViewModel: ObservableObject {
	var coordinatorInput: CoordinatorInput!
	
	private let goToSecondViewSubject = PassthroughSubject<Void, Never>()
	
	struct CoordinatorInput {
		var goToSecondView: AnyPublisher<Void, Never>
	}
	
	init() {
		coordinatorInput = CoordinatorInput(goToSecondView: goToSecondViewSubject.eraseToAnyPublisher())
	}
	
	@Published var text: String = ""
	
	func goToSecondView() {
		goToSecondViewSubject.send(())
	}
}
