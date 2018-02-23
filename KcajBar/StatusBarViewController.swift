//
//  ViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/21/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa
import SnapKit

class StatusBarViewController : NSViewController {
	var screen: NSScreen

	var components: [Component] = [
		BackgroundViewController(),
		TimeViewController(),
		DateViewController(),
		BatteryViewController(),
		WifiViewController()
	]

	init(with screen: NSScreen) {
		self.screen = screen
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		let view = NSView(frame: screen.frame)
		view.wantsLayer = true
		self.view = view
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		components.forEach { component in
			component.layout(with: self.view)
		}
	}
}
