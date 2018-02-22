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

	var background = BackgroundViewController()
	var time = TimeViewController()
	var date = DateViewController()
	var battery = BatterViewController()

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

		self.view.addSubview(background)
		background.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(20)
			make.width.left.right.top.equalTo(self.view)
		}

		self.view.addSubview(time)
		time.snp.makeConstraints { (make) -> Void in
			make.top.equalTo(0)
			make.right.equalTo(-10)
		}

		self.view.addSubview(date)
		date.snp.makeConstraints { (make) -> Void in
			make.top.equalTo(0)
			make.right.equalTo(-60)
		}

		self.view.addSubview(battery)
		battery.snp.makeConstraints { (make) -> Void in
			make.top.equalTo(0)
			make.right.equalTo(-144)
		}
	}
}
