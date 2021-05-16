//
//  NavigationController.swift
//  TestMVVMCombine
//
//  Created by Andrii Moisol on 16.05.2021.
//

import UIKit

protocol Drawable {
	var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
	var viewController: UIViewController? { return self }
}

typealias NavigationBackClosure = (() -> ())

protocol RouterProtocol: NSObject {
	func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack: NavigationBackClosure?)
	func pop(_ drawable: Drawable, _ isAnimated: Bool)
}

class Router: NSObject, RouterProtocol {
	let navigationController: UINavigationController
	private var closures: [String: NavigationBackClosure] = [:]
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		super.init()
		self.navigationController.delegate = self
		self.navigationController.interactivePopGestureRecognizer?.delegate = self
	}
	
	func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack closure: NavigationBackClosure?) {
		guard let viewController = drawable.viewController else { return }
		
		if let closure = closure {
			closures[viewController.description] = closure
		}
		navigationController.pushViewController(viewController, animated: isAnimated)
	}
	
	func pop(_ drawable: Drawable, _ isAnimated: Bool) {
		guard navigationController.topViewController === drawable.viewController, let previousController = navigationController.popViewController(animated: isAnimated) else { return }
		closures.removeValue(forKey: previousController.description)
	}
	
	private func executeClosure(_ viewController: UIViewController) {
		guard let closure = closures.removeValue(forKey: viewController.description) else { return }
		closure()
	}
}

extension Router: UINavigationControllerDelegate {
	func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
		guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(previousController) else {
			return
		}
		executeClosure(previousController)
	}
}

extension Router: UIGestureRecognizerDelegate {
	func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}
