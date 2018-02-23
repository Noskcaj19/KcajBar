//
//  BackgroundViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/21/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class BackgroundViewController : NSView, Component {
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.wantsLayer = true
		self.layer?.backgroundColor = NSColor(red: 0.00, green: 0.16, blue: 0.20, alpha:1.0).cgColor
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func layoutComponent() {
		self.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(20)
			make.width.left.right.top.equalToSuperview()
		}
	}
}
