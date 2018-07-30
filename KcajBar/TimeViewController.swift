//
//  TimeViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/21/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class TimeViewController : NSTextField, Component {
	let dateFormatter = DateFormatter()

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.dateFormatter.dateFormat = "hh:mm"
        self.usesSingleLineMode = true
		self.stringValue = getTime()
		self.font = NSFont(name: "Hack", size: 12)
		self.textColor = NSColor(red: 0.52, green: 0.60, blue: 0.00, alpha: 1.0)
		self.backgroundColor = .clear
		self.isBezeled = false
		self.drawsBackground = false
		self.isSelectable = false
		self.isEditable = false
		self.alignment = .right
		Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
			self.stringValue = self.getTime()
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func getTime() -> String {
		let date = Date()
		return self.dateFormatter.string(from: date)
	}
}
