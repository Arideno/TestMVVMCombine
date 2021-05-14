//
//  SecondViewModel.swift
//  TestMVVMCombine
//
//  Created by Andrii Moisol on 14.05.2021.
//

import Combine

class SecondViewModel: ObservableObject {
	var coordinatorInput: CoordinatorInput!
	
	private let closeSubject = PassthroughSubject<String, Never>()
	
	struct CoordinatorInput {
		var close: AnyPublisher<String, Never>
	}
	
	init() {
		coordinatorInput = CoordinatorInput(close: closeSubject.eraseToAnyPublisher())
	}
	
	@Published var text: String = ""
	
	func close() {
		closeSubject.send(text)
	}
}
