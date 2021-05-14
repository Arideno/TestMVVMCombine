//
//  AppDelegate.swift
//  TestMVVMCombine
//
//  Created by Andrii Moisol on 14.05.2021.
//

import UIKit
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var appCoordinator: AppCoordinator?
	var cancellables = Set<AnyCancellable>()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
	
		window = UIWindow(frame: UIScreen.main.bounds)
		
		appCoordinator = AppCoordinator(window: window!)
		appCoordinator?.start().sink(receiveValue: {}).store(in: &cancellables)
		
		return true
	}

}

