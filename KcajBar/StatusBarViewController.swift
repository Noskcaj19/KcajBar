//
//  ViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/21/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa
import SnapKit

enum BarPos {
    case top
    case bottom
}

let POSITION = BarPos.bottom

class StatusBarViewController : NSViewController {
	var screen: NSScreen

	var backgroundVC = BackgroundViewController()

	var leftStack = NSStackView()
	var rightStack = NSStackView()

	var rightComponents: [Component] = [
		TimeViewController(),
		DateViewController(),
		BatteryViewController(),
		WifiViewController(),
		SpotifyViewController()
	]

	var leftComponents: [Component] = [
		WindowNameViewController()
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

		view.addSubview(backgroundVC)

		rightStack.edgeInsets = NSEdgeInsetsMake(0, 5, 0, 5)
		backgroundVC.addSubview(rightStack)

		leftStack.edgeInsets = NSEdgeInsetsMake(0, 5, 0, 5)
		backgroundVC.addSubview(leftStack)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		backgroundVC.snp.makeConstraints { (make) -> Void in
            if POSITION == .top {
                make.top.left.right.equalToSuperview()
                make.height.equalTo(22)
            } else {
                make.bottom.left.right.equalToSuperview()
                make.height.equalTo(20)
            }
		}

		leftStack.snp.makeConstraints { (make) -> Void in
            if POSITION == .top {
                make.left.right.equalToSuperview()
                make.top.equalToSuperview().offset(1)
            } else {
                make.bottom.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-1)

            }
		}

		rightStack.snp.makeConstraints { (make) -> Void in
            if POSITION == .top {
                make.left.right.equalToSuperview()
                make.top.equalToSuperview().offset(1)

            } else {
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-1)

            }
		}

		rightComponents.reversed().forEach { component in
			self.rightStack.addView(component as! NSView, in: .trailing)
		}

		leftComponents.forEach { component in
			self.leftStack.addView(component as! NSView, in: .leading)
		}
	}
}
