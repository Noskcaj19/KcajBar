//
//  WifiViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/23/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class WifiViewController : NSTextField, Component {
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		(self.stringValue, self.toolTip) = getWifi()
		self.font = NSFont(name: "Hack", size: 12)
		self.textColor = NSColor(red: 0.52, green: 0.60, blue: 0.00, alpha: 1.0)
		self.backgroundColor = .clear
		self.isBezeled = false
		self.drawsBackground = false
		self.isSelectable = false
		self.isEditable = false
		Timer.scheduledTimer(withTimeInterval: 60*2, repeats: true) { _ in
			(self.stringValue, self.toolTip) = self.getWifi()
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func getWifi() -> (String, String?) {
		switch wifiStatus() {
		case let .on(networkName):
			return ("On", networkName)
		case .off:
			return ("Off", nil)
		}
	}

	func layout(with view: NSView) {
		view.addSubview(self)
		self.snp.makeConstraints { (make) -> Void in
			make.top.equalTo(0)
			make.right.equalTo(-180)
		}
	}
}

