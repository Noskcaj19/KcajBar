//
//  DateViewController.swift
//  KcajBar
//
//  Created by Jack Nunley on 2/21/18.
//  Copyright © 2018 Noskcaj. All rights reserved.
//

import Cocoa

class DateViewController : NSTextField {
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.stringValue = getDate()
		self.font = NSFont(name: "Hack", size: 12)
		self.textColor = NSColor(red: 0.15, green: 0.55, blue: 0.82, alpha: 1.0)
		self.backgroundColor = .clear
		self.isBezeled = false
		self.drawsBackground = false
		self.isSelectable = false
		self.isEditable = false
		Timer.scheduledTimer(withTimeInterval: 60*10, repeats: true) { _ in
			self.stringValue = self.getDate()
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func getDate() -> String {
		let date = Date()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEE dd MMM"
		return dateFormatter.string(from: date)
	}
}
